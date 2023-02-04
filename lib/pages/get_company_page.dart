import 'package:flutter/material.dart';
import 'package:take_me/globals.dart';
import 'package:take_me/pages/map_page.dart';
import 'package:take_me/pages/messages_page.dart';

import '../data/location_data.dart';
import '../widgets/action_button.dart';

class GetCompanyPage extends StatefulWidget {
  const GetCompanyPage({super.key});

  @override
  State<GetCompanyPage> createState() => _GetCompanyPageState();
}

class _GetCompanyPageState extends State<GetCompanyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Get Company"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: accentColor.withOpacity(0.7),
                borderRadius: BorderRadius.circular(5.0),
              ),
              padding: const EdgeInsets.all(15.0),
              child: const Text(
                "You are great! We need few details before people can accompany you.😎",
                style: TextStyle(fontSize: 14, color: Colors.white),
              ),
            ),
            _getTextField("Your Name", "", (v) {}),
            _getTextField("Phone Number", "", (v) {}),
            _getTextField("Vehicle Number", "", (v) {}),
            const SizedBox(height: 20),
            const Text("Select all tags that apply:"),
            const SizedBox(height: 10),
            Wrap(
              spacing: 10.0,
              children: const [
                ChipWidget(text: "Paid"),
                ChipWidget(text: "Free"),
                ChipWidget(text: "AC"),
                ChipWidget(text: "Mask Required"),
                ChipWidget(text: "2 Seater"),
                ChipWidget(text: "4 Seater"),
                ChipWidget(text: "7 Seater"),
              ],
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
                text: "Continue",
                onPressed: () {
                  goToPage(
                    context,
                    const MessagesPage(
                      requestingRide: false,
                    ),
                  );
                }),
            const SizedBox(height: 20)
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

class ChipWidget extends StatefulWidget {
  final String text;
  final bool displayOnly;
  const ChipWidget({
    super.key,
    required this.text,
    this.displayOnly = false,
  });

  @override
  State<ChipWidget> createState() => _ChipWidgetState();
}

class _ChipWidgetState extends State<ChipWidget> {
  bool selected = false;

  @override
  void initState() {
    if (widget.displayOnly) selected = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      selected: selected,
      onSelected: (e) {
        if (widget.displayOnly) return;
        selected = !selected;
        setState(() {});
      },
      label: Text(widget.text),
    );
  }
}
