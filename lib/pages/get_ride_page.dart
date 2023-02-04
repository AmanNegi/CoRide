import 'package:flutter/material.dart';
import 'package:take_me/globals.dart';

class GetRidePage extends StatefulWidget {
  const GetRidePage({super.key});

  @override
  State<GetRidePage> createState() => _GetRidePageState();
}

class _GetRidePageState extends State<GetRidePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Get Ride"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: lightColor,
                  borderRadius: BorderRadius.circular(5.0),
                ),
                padding: const EdgeInsets.all(15.0),
                child: const Text(
                  "We need few details before we can help you. 😊",
                  style: TextStyle(fontSize: 14, color: Colors.white),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
