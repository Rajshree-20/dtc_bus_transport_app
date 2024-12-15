import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController(text: 'Esplanade Mall, Rasulgarh');
  String departureTime = "9:30 AM";
  String busType = "AC";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          'Search for bus stops',
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // My Location Section
            Row(
              children: [
                Icon(Icons.location_on, color: Colors.blueAccent),
                SizedBox(width: 8),
                Text(
                  "My Location",
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
                Spacer(),
                IconButton(
                  icon: Icon(Icons.my_location, color: Colors.blueAccent),
                  onPressed: _fetchCurrentLocation,
                ),
              ],
            ),
            SizedBox(height: 8),
            // Pre-filled Location Field
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.grey[200],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.clear, color: Colors.blueAccent),
                    onPressed: () {
                      _searchController.clear();
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Icon(Icons.directions, color: Colors.blueAccent),
                SizedBox(width: 8),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.grey[200],
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Enter destination',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            // Filter and Bus Options
            Row(
              children: [
                Expanded(
                  child: DropdownButton<String>(
                    value: departureTime,
                    isExpanded: true,
                    onChanged: (String? newValue) {
                      setState(() {
                        departureTime = newValue!;
                      });
                    },
                    items: <String>['9:30 AM', '10:00 AM', '10:30 AM']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: DropdownButton<String>(
                    value: busType,
                    isExpanded: true,
                    onChanged: (String? newValue) {
                      setState(() {
                        busType = newValue!;
                      });
                    },
                    items: <String>['AC', 'Non AC']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Text(
              "Available Options",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            Expanded(
              child: ListView(
                children: [
                  _buildBusOption(
                    context,
                    '228 S',
                    '24',
                    '10:30 AM',
                    '44min',
                    'Slight delay on the route.',
                    isDelayed: true,
                  ),
                  _buildBusOption(
                    context,
                    '21 AC',
                    '5',
                    '10:48 AM',
                    '1hr 02min',
                    'On time',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _fetchCurrentLocation() async {
    try {
      // Fetch current location
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

      // Reverse geocode to get the address
      List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
      Placemark place = placemarks[0];
      String address = '${place.name}, ${place.locality}, ${place.administrativeArea}, ${place.country}';

      setState(() {
        _searchController.text = address; // Display the address in the text field
      });
    } catch (e) {
      print("Error fetching location: $e");
    }
  }


  Widget _buildBusOption(BuildContext context, String bus1, String bus2, String arrivalTime, String duration, String status, {bool isDelayed = false}) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.directions_walk),
                SizedBox(width: 4),
                Text('Arrive by $arrivalTime', style: TextStyle(color: Colors.black)),
                Spacer(),
                Text(duration, style: TextStyle(color: Colors.green)),
              ],
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(bus1, style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(width: 4),
                    Icon(Icons.arrow_forward),
                    SizedBox(width: 4),
                    Text(bus2, style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
                if (isDelayed)
                  Row(
                    children: [
                      Icon(Icons.error_outline, color: Colors.red),
                      SizedBox(width: 4),
                      Text(status, style: TextStyle(color: Colors.red)),
                    ],
                  )
                else
                  Text(status, style: TextStyle(color: Colors.blueGrey)),
              ],
            ),
            SizedBox(height: 4),
            Text('Leave at 9:45 AM from Karol Bagh'),
          ],
        ),
      ),
    );
  }
}
