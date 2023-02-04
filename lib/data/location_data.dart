import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationData {
  LatLng? currentLocation;
  LatLng? pickupLocation;
  LatLng? destinationLocation;
}

LocationData locationData = LocationData();
