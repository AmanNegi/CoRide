import 'package:flutter/material.dart';
import 'package:co_ride/globals.dart';
import 'package:co_ride/widgets/action_button.dart';

class MessagesPage extends StatefulWidget {
  final bool requestingRide;
  const MessagesPage({super.key, this.requestingRide = false});

  @override
  State<MessagesPage> createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          !widget.requestingRide ? "Waiting for responses" : "Request for ride",
        ),
      ),
      body: Stack(
        children: [
          Positioned(
            top: 0,
            bottom: 60,
            left: 0,
            right: 0,
            child: ListView(
              physics: const BouncingScrollPhysics(),
              reverse: true,
              children: !widget.requestingRide
                  ? [
                      const SizedBox(height: 20),
                      _getSelfMessageWidget(
                          "Sure, thing. I am already on my way"),
                      _getReceivedMessageWidget("Yes, can you book my ride"),
                      _getSelfMessageWidget(
                          "Hello, are you looking for a ride"),
                      _getReceivedMessageWidget("Hi There!")
                    ]
                  : [
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: ActionButton(
                          onPressed: () {},
                          text: "Accept Ride",
                        ),
                      ),
                      _getReceivedMessageWidget(
                          "Sure, thing. I am already on my way"),
                      _getSelfMessageWidget("Yes, can you book my ride"),
                      _getReceivedMessageWidget(
                          "Hello, are you looking for a ride"),
                      _getSelfMessageWidget("Hi There!")
                    ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 60,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 5.0,
                    spreadRadius: 3.0,
                    offset: const Offset(0.0, -5.0),
                  )
                ],
              ),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        onTap: () async {},
                        cursorRadius: const Radius.circular(20.0),
                        decoration: const InputDecoration(
                          isDense: true,
                          contentPadding: EdgeInsets.only(
                              left: 10.0, right: 10.0, bottom: 5.0),
                          hintText: "Type your message.",
                          alignLabelWithHint: true,
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    tooltip: 'Send',
                    icon: Icon(
                      Icons.send,
                      color: accentColor,
                    ),
                    onPressed: () async {},
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  _getSelfMessageWidget(String message) {
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.only(right: 5.0),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(20.0),
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Container(
              constraints: BoxConstraints(maxWidth: getWidth(context) * 0.7),
              padding: const EdgeInsets.only(
                top: 15.0,
                left: 15.0,
                right: 10.0,
                bottom: 5.0,
              ),
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(20.0),
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  ),
                  color: accentColor,
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 2.0,
                        color: Colors.black.withOpacity(0.05),
                        offset: const Offset(0.0, 0.0),
                        spreadRadius: 1.0)
                  ]),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Text(message, style: const TextStyle(color: Colors.white)),
                  const SizedBox(
                    height: 5.0,
                  ),
                  const Text("Just now",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w500)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _getReceivedMessageWidget(String message) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(
          left: 5.0,
        ),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Container(
            constraints: BoxConstraints(maxWidth: getWidth(context) * 0.7),
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(20.0),
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
                color: Theme.of(context).scaffoldBackgroundColor,
                border: Border.all(
                  color: accentColor,
                )),
            child: Padding(
              padding: const EdgeInsets.all(1.0),
              child: Container(
                padding: const EdgeInsets.only(
                  top: 15.0,
                  left: 10.0,
                  right: 15.0,
                  bottom: 5.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(message),
                    const SizedBox(
                      height: 5.0,
                    ),
                    const Text(
                      "A few moments ago",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 10,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
