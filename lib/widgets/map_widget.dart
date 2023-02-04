import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:take_me/data/location_data.dart';

class MapWidget extends StatefulWidget {
  final bool isPickup;
  final LatLng? location;
  const MapWidget({
    super.key,
    this.isPickup = false,
    required this.location,
  });

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  CameraPosition currentPosition = const CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.5,
  );
  GoogleMapController? controller;
  Set<Marker> markers = {};
  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }

  @override
  void initState() {
    if (widget.location != null) {
      markers.clear();
      currentPosition = CameraPosition(
        target: widget.location!,
        zoom: 15.0,
      );
      markers.add(
        Marker(
          markerId: MarkerId(
            DateTime.now().microsecondsSinceEpoch.toString(),
          ),
          position: widget.location!,
        ),
      );
    }
    super.initState();
  }

  _determinePosition() async {
    if (locationData.currentLocation != null) return;

    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      bool res = await Geolocator.openLocationSettings();
      if (!res) return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    var pos = await Geolocator.getCurrentPosition();
    var currentLatLng = LatLng(pos.latitude, pos.longitude);
    locationData.currentLocation = currentLatLng;

    // Assuming that currentLocation is the pickup location
    locationData.pickupLocation = currentLatLng;

    currentPosition = CameraPosition(
      target: currentLatLng,
      zoom: 15.0,
    );
    if (controller != null) {
      markers.add(Marker(
          markerId: MarkerId(DateTime.now().microsecondsSinceEpoch.toString()),
          position: currentLatLng));
      controller!.moveCamera(
        CameraUpdate.newCameraPosition(currentPosition),
      );
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      myLocationEnabled: true,
      scrollGesturesEnabled: true,
      mapType: MapType.normal,
      initialCameraPosition: currentPosition,
      compassEnabled: true,
      myLocationButtonEnabled: true,
      markers: markers,
      onTap: (e) async {
        markers.clear();

        if (widget.isPickup) {
          locationData.pickupLocation = e;
        } else {
          locationData.destinationLocation = e;
        }

        markers.add(Marker(
          markerId: MarkerId(DateTime.now().microsecondsSinceEpoch.toString()),
          position: e,
        ));
        setState(() {});
      },
      onMapCreated: (GoogleMapController? c) {
        if (c != null) {
          controller = c;
          _determinePosition();
        }
      },
    );
  }
}
