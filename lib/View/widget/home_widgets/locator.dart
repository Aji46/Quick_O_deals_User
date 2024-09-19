import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPicker extends StatefulWidget {
  @override
  _MapPickerState createState() => _MapPickerState();
}

class _MapPickerState extends State<MapPicker> {
  LatLng? _selectedLocation;
  late GoogleMapController _mapController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        onMapCreated: (controller) {
          _mapController = controller;
        },
        initialCameraPosition: CameraPosition(
          target: LatLng(0, 0),
          zoom: 2,
        ),
        onTap: (LatLng location) {
          setState(() {
            _selectedLocation = location;
          });
          print('Selected location: ${location.latitude}, ${location.longitude}');
        },
        markers: _selectedLocation != null
            ? {
                Marker(
                  markerId: MarkerId('selected_location'),
                  position: _selectedLocation!,
                ),
              }
            : {},
      ),
    );
  }
}