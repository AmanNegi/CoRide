import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  CameraPosition currentPosition = const CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.5,
  );
  GoogleMapController? controller;
  Set<Marker> markers = {};

  Future<Position> _determinePosition() async {
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
    currentPosition = CameraPosition(
      target: LatLng(pos.latitude, pos.longitude),
      zoom: 15.0,
    );
    if (controller != null) {
      markers.add(Marker(
        markerId: MarkerId(DateTime.now().microsecondsSinceEpoch.toString()),
        position: LatLng(pos.latitude, pos.longitude),
        infoWindow: const InfoWindow(title: "You are here"),
      ));
      controller!.moveCamera(
        CameraUpdate.newCameraPosition(currentPosition),
      );
      setState(() {});
    }
    return pos;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Select Destination")),
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: currentPosition,
        compassEnabled: true,
        markers: markers,
        onTap: (e) async {
          markers.clear();

          markers.add(Marker(
            markerId:
                MarkerId(DateTime.now().microsecondsSinceEpoch.toString()),
            position: e,
            infoWindow: const InfoWindow(title: "Destination"),
          ));
          setState(() {});
        },
        onMapCreated: (GoogleMapController? c) {
          if (c != null) {
            controller = c;
            _determinePosition();
          }
        },
      ),
    );
  }
}
