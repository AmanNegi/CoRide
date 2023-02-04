import 'package:flutter/material.dart';
import 'package:take_me/globals.dart';
import 'package:take_me/pages/get_ride_page.dart';
import 'package:take_me/widgets/action_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 0.1 * getHeight(context)),
            const Text(
              "What are you looking for?",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 23,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 0.1 * getHeight(context)),
            Center(
              child: Image.asset(
                "assets/home_img.png",
                width: 0.8 * getWidth(context),
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: ActionButton(
                text: "I want a ride",
                onPressed: () {
                  goToPage(context, const GetRidePage());
                },
              ),
            ),
            SizedBox(height: 0.01 * getHeight(context)),
            const Center(child: Text("OR")),
            SizedBox(height: 0.01 * getHeight(context)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: ActionButton(
                text: "I want some company",
                isFilled: false,
                onPressed: () {},
              ),
            ),
            SizedBox(height: 0.1 * getHeight(context)),
          ],
        ),
      ),
    );
  }
}
