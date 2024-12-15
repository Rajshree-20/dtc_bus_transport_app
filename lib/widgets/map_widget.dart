import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart' show GeoPoint, MapController, OSMFlutter, OSMOption;
import 'package:geolocator/geolocator.dart';

class MapWidget extends StatefulWidget {
  final Position? currentPosition;
  final GeoPoint destination;

  MapWidget({this.currentPosition, required this.destination});

  @override
  _MapWidgetState createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  late MapController mapController;

  @override
  void initState() {
    super.initState();
    mapController = MapController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.currentPosition != null) {
        mapController.moveTo(
          GeoPoint(
            latitude: widget.currentPosition!.latitude,
            longitude: widget.currentPosition!.longitude,
          ),
        );
      }
    });
  }

  void _zoomIn() {
    mapController.zoomIn();
  }

  void _zoomOut() {
    mapController.zoomOut();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        OSMFlutter(
          controller: mapController,
          osmOption: OSMOption(
            showZoomController: true,
          ),
          onLocationChanged: (GeoPoint point) {
            // Handle location changes
          },
        ),
        Positioned(
          bottom: 20,
          right: 20,
          child: Column(
            children: [
              FloatingActionButton(
                onPressed: _zoomIn,
                mini: true,
                child: Icon(Icons.zoom_in),
                backgroundColor: Colors.blue,
              ),
              SizedBox(height: 10),
              FloatingActionButton(
                onPressed: _zoomOut,
                mini: true,
                child: Icon(Icons.zoom_out),
                backgroundColor: Colors.blue,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
