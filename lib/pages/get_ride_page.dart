import 'package:flutter/material.dart';
import 'package:co_ride/globals.dart';
import 'package:co_ride/pages/available_rides_page.dart';
import 'package:co_ride/pages/map_page.dart';

import '../data/location_data.dart';
import '../widgets/action_button.dart';

class GetRidePage extends StatefulWidget {
  const GetRidePage({super.key});

  @override
  State<GetRidePage> createState() => _GetRidePageState();
}

class _GetRidePageState extends State<GetRidePage> {
  String name = "";
  String phone = "";
  String people = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Get Ride"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: accentColor,
                borderRadius: BorderRadius.circular(5.0),
              ),
              padding: const EdgeInsets.all(15.0),
              child: const Text(
                "We need few details before we can help you. 😊",
                style: TextStyle(fontSize: 14, color: Colors.white),
              ),
            ),
            _getTextField(
              "Your Name",
              name,
              (v) {
                name = v;
                setState(() {});
              },
            ),
            _getTextField(
              "Phone Number",
              phone,
              (v) {
                phone = v;
                setState(() {});
              },
            ),
            _getTextField(
              "Number of people",
              people,
              (v) {
                people = v;
                setState(() {});
              },
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: ActionButton(
                    isFilled: false,
                    text: "Pickup",
                    onPressed: () {
                      goToPage(
                        context,
                        MapPage(
                          location: locationData.pickupLocation,
                          isPickup: true,
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: ActionButton(
                    isFilled: false,
                    text: "Destination",
                    onPressed: () {
                      goToPage(
                        context,
                        MapPage(
                          location: locationData.destinationLocation,
                          isPickup: false,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            const Spacer(),
            ActionButton(
                text: "Search",
                onPressed: () {
                  goToPage(context, const AvailableRidesPage());
                }),
            const SizedBox(height: 10)
          ],
        ),
      ),
    );
  }

  Container _getTextField(
      String hintText, String initialValue, Function onChange,
      {bool enabled = true}) {
    return Container(
      height: 0.07 * getHeight(context),
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.only(left: 10, right: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          color: Colors.grey.withOpacity(0.2)),
      child: TextField(
        enabled: enabled,
        onChanged: (value) => onChange(value),
        controller: TextEditingController(text: initialValue),
        decoration: InputDecoration(
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
