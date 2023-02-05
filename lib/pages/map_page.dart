import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:co_ride/data/location_data.dart';
import 'package:co_ride/globals.dart';

class MapPage extends StatefulWidget {
  final bool isPickup;
  final LatLng? location;
  const MapPage({
    super.key,
    this.isPickup = false,
    required this.location,
  });

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
  final startAddressController = TextEditingController();

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }

  _determinePosition() async {
    if (locationData.currentLocation == null) {
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
    }

// Add marker only if the location passed is null
    if (widget.location != null) return;

    currentPosition = CameraPosition(
      target: locationData.currentLocation!,
      zoom: 15.0,
    );
    if (controller != null) {
      addMarker(currentPosition.target);
      controller!.moveCamera(
        CameraUpdate.newCameraPosition(currentPosition),
      );
      setState(() {});
    }
  }

  @override
  void initState() {
    if (widget.location != null) {
      currentPosition = CameraPosition(
        target: widget.location!,
        zoom: 15.0,
      );
      addMarker(widget.location!);
    }
    super.initState();
  }

  addMarker(LatLng loc) {
    markers.clear();
    markers.add(
      Marker(
        markerId: MarkerId(DateTime.now().microsecondsSinceEpoch.toString()),
        position: loc,
      ),
    );
    setState(() {});
  }

  _getAddress(String address) async {
    List<Location> data = await locationFromAddress(address);
    if (data.isEmpty) {
      return;
    }

    addMarker(LatLng(data[0].latitude, data[0].longitude));
    currentPosition = CameraPosition(
      target: LatLng(data[0].latitude, data[0].longitude),
      zoom: 15.0,
    );
    controller!.moveCamera(
      CameraUpdate.newCameraPosition(currentPosition),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: accentColor,
        child: const Icon(Icons.save, color: Colors.white),
        onPressed: () {
          Navigator.pop(context, currentPosition);
        },
      ),
      appBar: AppBar(
        title: Text(widget.isPickup ? "Pickp Location" : "Select Destination"),
        bottom: PreferredSize(
          preferredSize: const Size(double.infinity, 50),
          child: Container(
            margin:
                const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.2),
              borderRadius: BorderRadius.circular(30.0),
            ),
            child: TextField(
              onSubmitted: (value) => {_getAddress(value)},
              decoration: const InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 15.0,
                    vertical: 10.0,
                  ),
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.search),
                  hintText: "Search"),
            ),
          ),
        ),
      ),
      body: GoogleMap(
        zoomControlsEnabled: false,
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
            markerId:
                MarkerId(DateTime.now().microsecondsSinceEpoch.toString()),
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
      ),
    );
  }
}
