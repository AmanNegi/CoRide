import 'package:flutter/material.dart';

Color accentColor = const Color(0xFF03045e);
 Color lightColor = Color(0xFF0077b6);
goToPage(BuildContext context, Widget destination, {bool clearStack = false}) {
  if (clearStack) {
    return Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => destination), (route) => false);
  }
  return Navigator.of(context)
      .push(MaterialPageRoute(builder: (context) => destination));
}

getHeight(context) => MediaQuery.of(context).size.height;
getWidth(context) => MediaQuery.of(context).size.width;
