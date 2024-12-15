import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:uuid/uuid.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:http/http.dart' as http;

class SuggestionScreen extends StatefulWidget {
  const SuggestionScreen({super.key});

  @override
  _SuggestionScreenState createState() => _SuggestionScreenState();
}

class _SuggestionScreenState extends State<SuggestionScreen> {
  GoogleMapController? _mapController;
  LatLng _currentLocation = const LatLng(28.6139, 77.2090); // Default to New Delhi coordinates
  Location _location = Location();
  bool _locationEnabled = false;
  Set<Marker> _markers = {};
  List<LatLng> _routePoints = [];
  bool _isAddingMarker = false;
  bool _isDrawingRoute = false;
  bool _isConfirmationVisible = false; // To control the visibility of confirmation buttons

  Map<MarkerId, String> _markerComments = {}; // To store comments for markers
  String? _routeComment; // To store the comment for the route

  String tokenForSession = '12345';
  var uuid = Uuid();

  List<dynamic> listForPlaces = [];
  bool _isSuggestionsVisible = false;
  final TextEditingController _searchController = TextEditingController();

  void makeSuggestion(String input) async {
    String googlePlacesApiKey = 'AIzaSyA7MU4OHu9HKJ5h5bvTiuhaVHiXJ85mFYc';
    String autocompleteURL = 'https://maps.googleapis.com/maps/api/place/autocomplete/json';

    // Coordinates for New Delhi
    double newDelhiLat = 28.6139;
    double newDelhiLng = 77.2090;
    int radius = 10000; // Adjust the radius as needed (in meters)

    // Bias the search results towards New Delhi
    String request = '$autocompleteURL?input=$input&key=$googlePlacesApiKey&sessiontoken=$tokenForSession&location=$newDelhiLat,$newDelhiLng&radius=$radius';

    var responseResult = await http.get(Uri.parse(request));
    var resultData = responseResult.body.toString();

    if (responseResult.statusCode == 200) {
      setState(() {
        listForPlaces = jsonDecode(responseResult.body.toString())['predictions'];
      });
    } else {
      throw Exception('Failed to fetch suggestions');
    }
  }



  Future<void> fetchPlaceDetails(String placeId) async {
    String googlePlacesApiKey = 'AIzaSyA7MU4OHu9HKJ5h5bvTiuhaVHiXJ85mFYc';
    String placeDetailsURL = 'https://maps.googleapis.com/maps/api/place/details/json';

    String request = '$placeDetailsURL?place_id=$placeId&key=$googlePlacesApiKey';

    var responseResult = await http.get(Uri.parse(request));
    var resultData = responseResult.body.toString();

    if (responseResult.statusCode == 200) {
      var details = jsonDecode(responseResult.body.toString())['result'];
      double lat = details['geometry']['location']['lat'];
      double lng = details['geometry']['location']['lng'];
      LatLng location = LatLng(lat, lng);

      _onSuggestionSelected(location);
    } else {
      throw Exception('Failed to fetch place details');
    }
  }


  void _onSearchChanged(String input) {
    if (input.isNotEmpty) {
      makeSuggestion(input);
      setState(() {
        _isSuggestionsVisible = true;
      });
    } else {
      setState(() {
        _isSuggestionsVisible = false;
      });
    }
  }


  void _onSuggestionSelected(LatLng location) {
    setState(() {
      _currentLocation = location;
      _isSuggestionsVisible = false;
      _mapController?.animateCamera(
        CameraUpdate.newLatLngZoom(_currentLocation, 14),
      );
    });
  }


  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    final hasPermission = await _location.hasPermission();
    if (hasPermission == PermissionStatus.granted) {
      final locationData = await _location.getLocation();
      setState(() {
        _currentLocation = LatLng(locationData.latitude!, locationData.longitude!);
        _locationEnabled = true;
      });
      _mapController?.animateCamera(
        CameraUpdate.newLatLngZoom(_currentLocation, 14),
      );
    } else {
      final permissionStatus = await _location.requestPermission();
      if (permissionStatus == PermissionStatus.granted) {
        final locationData = await _location.getLocation();
        setState(() {
          _currentLocation = LatLng(locationData.latitude!, locationData.longitude!);
          _locationEnabled = true;
        });
        _mapController?.animateCamera(
          CameraUpdate.newLatLngZoom(_currentLocation, 14),
        );
      }
    }
  }


  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
    _getCurrentLocation(); // Fetch location after map is created

    // Fetch markers from Firestore
    FirebaseFirestore.instance.collection('markers').get().then((snapshot) {
      snapshot.docs.forEach((doc) {
        LatLng position = LatLng(doc['position']['lat'], doc['position']['lng']);
        MarkerId markerId = MarkerId(position.toString());
        setState(() {
          _markers.add(
            Marker(
              markerId: markerId,
              position: position,
            ),
          );
          _markerComments[markerId] = doc['comment'];
        });
      });
    });

    // Fetch routes from Firestore
    FirebaseFirestore.instance.collection('routes').get().then((snapshot) {
      snapshot.docs.forEach((doc) {
        List<dynamic> routePointsData = doc['routePoints'];
        List<LatLng> routePoints = routePointsData
            .map((point) => LatLng(point['lat'], point['lng']))
            .toList();
        setState(() {
          // Assuming you want to display all routes at once
          if (routePoints.isNotEmpty) {
            _routePoints = routePoints;
          }
        });
      });
    });
  }


  void _centerMapOnCurrentLocation() {
    if (_locationEnabled) {
      _mapController?.animateCamera(
        CameraUpdate.newLatLngZoom(_currentLocation, 14),
      );
    }
  }


  void _startAddingMarker() {
    setState(() {
      _isAddingMarker = true;
      _isDrawingRoute = false;
      _isConfirmationVisible = false; // Hide confirmation buttons when adding marker
    });
  }


  void _startDrawingRoute() {
    _showInstructionDialog();
  }


  void _onMapTap(LatLng position) async {
    if (_isAddingMarker) {
      final comment = await _showCommentDialog(); // Show comment dialog and wait for comment input
      if (comment != null) {
        MarkerId markerId = MarkerId(position.toString());
        setState(() {
          _markers.add(
            Marker(
              markerId: markerId,
              position: position,
            ),
          );
          _markerComments[markerId] = comment; // Save the comment for the marker
          _isAddingMarker = false;
        });

        // Save marker to Firestore
        await FirebaseFirestore.instance.collection('markers').add({
          'position': {
            'lat': position.latitude,
            'lng': position.longitude,
          },
          'comment': comment,
        });
      }
    } else if (_isDrawingRoute) {
      setState(() {
        _routePoints.add(position);
      });
    }
  }


  Future<String?> _showCommentDialog() async {
    String? comment;
    return showDialog<String>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Comment'),
          content: TextField(
            decoration: const InputDecoration(hintText: 'Enter your comment here...'),
            onChanged: (value) {
              comment = value;
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(comment);
              },
              child: const Text('Submit'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }


  void _showInstructionDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Route Instructions'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text('Draw your desired route on the map by tapping along the path you want to take.'),
              SizedBox(height: 10.0),
              Text("Tip: Try to follow the roads."),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  _isDrawingRoute = true;
                  _isConfirmationVisible = true;
                });
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }


  void _confirmRoute() async {
    final comment = await _showCommentDialog(); // Show comment dialog after route is confirmed
    if (comment != null) {
      setState(() {
        _routeComment = comment;
        _isDrawingRoute = false;
        _isConfirmationVisible = false; // Hide confirmation buttons
      });

      // Save the route to Firestore
      await FirebaseFirestore.instance.collection('routes').add({
        'routePoints': _routePoints.map((point) => {
          'lat': point.latitude,
          'lng': point.longitude,
        }).toList(),
        'comment': comment, // Save comment along with route points
      });
    }
  }


  void _cancelRouteDrawing() {
    setState(() {
      _routePoints.clear(); // Clear the route points
      _isDrawingRoute = false;
      _isConfirmationVisible = false; // Hide confirmation buttons
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: _currentLocation,
              zoom: 14.0,
            ),
            markers: _markers,
            onTap: _onMapTap,
            polylines: _isDrawingRoute
                ? {
              Polyline(
                polylineId: const PolylineId('route'),
                points: _routePoints,
                color: Colors.blue,
                width: 4,
              ),
            }
                : {},
          ),
          Positioned(
            top: 40.0,
            left: 20.0,
            right: 20.0,
            child: Column(
              children: [
                TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    filled: true,
                    hintText: 'Search for places...',
                    prefixIcon: IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: () {
                        _onSearchChanged(_searchController.text);
                      },
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  onChanged: _onSearchChanged,
                ).box.shadow.make(),
                if (_isSuggestionsVisible)
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 6,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    margin: const EdgeInsets.only(top: 8.0),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: listForPlaces.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(listForPlaces[index]['description']),
                          onTap: () async {
                            String placeId = listForPlaces[index]['place_id'];
                            await fetchPlaceDetails(placeId);
                          },
                        );
                      },
                    ),
                  ),
                if (_isConfirmationVisible)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: _confirmRoute,
                        child: const Text('Confirm Route'),
                      ),
                      ElevatedButton(
                        onPressed: _cancelRouteDrawing,
                        child: const Text('Cancel'),
                      ),
                    ],
                  ).box.white.padding(const EdgeInsets.all(16)).make(),
              ],
            ),
          ),
          Positioned(
            bottom: 16.0,
            left: 16.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  icon: const Icon(Icons.my_location),
                  onPressed: _centerMapOnCurrentLocation,
                  tooltip: 'My Location',
                  color: Colors.blueAccent,
                ).box.white.roundedSM.margin(const EdgeInsets.only(bottom: 8.0)).make(),
                IconButton(
                  icon: const Icon(Icons.add_location_alt_outlined),
                  onPressed: _startAddingMarker,
                  tooltip: 'Add Marker',
                  color: Colors.blueAccent,
                ).box.white.roundedSM.margin(const EdgeInsets.only(bottom: 8.0)).make(),
                IconButton(
                  icon: const Icon(Icons.route_outlined),
                  onPressed: _startDrawingRoute,
                  tooltip: 'Draw Route',
                  color: Colors.blueAccent,
                ).box.white.roundedSM.margin(const EdgeInsets.only(bottom: 16.0)).make(),
                if (_isDrawingRoute)
                  IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      setState(() {
                        _routePoints.clear();
                        _markers.clear();
                        _isDrawingRoute = false;
                        _isAddingMarker = false;
                      });
                    },
                    tooltip: 'Clear All',
                    color: Colors.red,
                  ).box.white.roundedSM.margin(const EdgeInsets.only(bottom: 8.0)).make(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
