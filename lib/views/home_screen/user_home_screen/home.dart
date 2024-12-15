import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show SystemUiOverlayStyle;
import 'package:google_maps_flutter/google_maps_flutter.dart'; // Import Google Maps Flutter package
import 'package:dtc/views/home_screen/user_home_screen/search.dart';
import 'bus_route_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late GoogleMapController mapController; // Google Map Controller

  // Initial position of the map
  final LatLng _initialPosition = LatLng(28.6139, 77.2090); // Coordinates of New Delhi

  // Function to handle map creation
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  // Function to center the map on the current location
  void _centerMapOnCurrentLocation() {
    mapController.animateCamera(
      CameraUpdate.newLatLngZoom(_initialPosition, 14),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        toolbarHeight: 0,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          // Google Map
          Positioned.fill(
            child: GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: _initialPosition,
                zoom: 14.0,
              ),
              // myLocationEnabled: true,
              // Additional map configurations as needed
            ),
          ),
          // Search bar with shadow and notch space
          Positioned(
            top: MediaQuery.of(context).padding.top + 10,
            left: 15,
            right: 15,
            child: GestureDetector(
              onTap: () async {
                final selectedLocation = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SearchPage()),
                );

                if (selectedLocation != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BusRouteOptionsScreen(
                        selectedLocation: selectedLocation,
                      ),
                    ),
                  );
                }
              },
              child: Container(
                height: 50,
                padding: const EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Icon(Icons.search, color: Colors.grey.shade600),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextFormField(
                        readOnly: true,
                        onTap: () async {
                          final selectedLocation = await Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => SearchPage()),
                          );

                          if (selectedLocation != null) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BusRouteOptionsScreen(
                                  selectedLocation: selectedLocation,
                                ),
                              ),
                            );
                          }
                        },
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Search your destination',
                          hintStyle: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Combined Current location button
          Positioned(
            bottom: 100, // Adjust as needed to place it above the slider
            right: 15,
            child: FloatingActionButton(
              onPressed: _centerMapOnCurrentLocation,
              child: Icon(Icons.my_location),
              backgroundColor: Colors.blue,
            ),
          ),
          // Draggable Scrollable Sheet
          DraggableScrollableSheet(
            initialChildSize: 0.3,
            minChildSize: 0.1,
            maxChildSize: 0.7,
            builder: (BuildContext context, ScrollController scrollController) {
              return Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: ListView(
                  controller: scrollController,
                  children: [
                    const SizedBox(height: 10),
                    Center(
                      child: Container(
                        width: 50,
                        height: 5,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    const ListTile(
                      leading: Icon(Icons.directions_bus, color: Colors.blue),
                      title: Text('Karol Bagh'),
                      subtitle: Text('1.2KM'),
                      trailing: Icon(Icons.arrow_forward_ios, size: 16),
                    ),
                    const Divider(),
                    const ListTile(
                      leading: Icon(Icons.directions_bus, color: Colors.grey),
                      title: Text('20 S'),
                      subtitle: Text('Sarojini Nagar -  Via (Chanakyapuri)'),
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('5 min', style: TextStyle(color: Colors.green)),
                          Text('Next in 25 min', style: TextStyle(fontSize: 12)),
                        ],
                      ),
                    ),
                    const ListTile(
                      leading: Icon(Icons.directions_bus, color: Colors.grey),
                      title: Text('21 AC'),
                      subtitle: Text('Anand Parbat'),
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('22 min', style: TextStyle(color: Colors.green)),
                          Text('Next in 40 min', style: TextStyle(fontSize: 12)),
                        ],
                      ),
                    ),
                    // Add more ListTiles as needed
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
