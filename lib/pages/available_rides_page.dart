import 'package:flutter/material.dart';
import 'package:take_me/globals.dart';
import 'package:take_me/pages/get_company_page.dart';

class AvailableRidesPage extends StatefulWidget {
  const AvailableRidesPage({super.key});

  @override
  State<AvailableRidesPage> createState() => _AvailableRidesPageState();
}

class _AvailableRidesPageState extends State<AvailableRidesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Available Rides"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
        child: Column(
          children: [
            _getRideItem(1),
            const SizedBox(height: 20),
            _getRideItem(2),
          ],
        ),
      ),
    );
  }

  Container _getRideItem(int index) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        color: Theme.of(context).cardColor,
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor.withOpacity(0.05),
            blurRadius: 5.0,
            spreadRadius: 5.0,
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15),
      // height: 0.2 * getHeight(context),
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                rideData["$index"]!["name"],
                style:
                    const TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                    color: accentColor,
                    borderRadius: BorderRadius.circular(5.0)),
                child: const Icon(
                  Icons.message_rounded,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Wrap(
            spacing: 10,
            children: rideData["$index"]!["tags"]
                .map<Widget>(
                  (e) => ChipWidget(
                    text: e,
                    displayOnly: true,
                  ),
                )
                .toList(),
          ),
          const Text(
            "Based on your current search",
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}

Map<String, Map> rideData = {
  "1": {
    "name": "Aman Negi",
    "tags": ["Free", "AC", "4 Seater"],
  },
  "2": {
    "name": "Aster Joules",
    "tags": ["Paid", "\$40", "NonAC", "7 Seater", "Mask Required"],
  }
};
