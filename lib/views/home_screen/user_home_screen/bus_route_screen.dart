import 'package:flutter/material.dart';

class BusRouteOptionsScreen extends StatelessWidget {
  final String selectedLocation;

  const BusRouteOptionsScreen({Key? key, required this.selectedLocation}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bus Route Options'),
      ),
      body: Center(
        child: Text('Selected Location: $selectedLocation'),
      ),
    );
  }
}
