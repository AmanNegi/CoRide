import 'package:flutter/material.dart';
import 'package:take_me/globals.dart';

class ActionButton extends StatefulWidget {
  final String text;
  final Function onPressed;
  final Color? fillColor;
  final bool isFilled;
  const ActionButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.fillColor,
    this.isFilled = true,
  }) : super(key: key);

  @override
  State<ActionButton> createState() => _ActionButtonState();
}

class _ActionButtonState extends State<ActionButton> {
  late double width, height;

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () => widget.onPressed(),
      child: Container(
        height: 0.06 * height,
        width: double.infinity,
        decoration: BoxDecoration(
          color: widget.isFilled
              ? widget.fillColor ?? accentColor
              : Colors.transparent,
          border: Border.all(
            width: 0.7,
            color: !widget.isFilled
                ? widget.fillColor ?? accentColor
                : Colors.transparent,
          ),
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: Center(
          child: Text(
            widget.text,
            style: TextStyle(
              color: widget.isFilled
                  ? Colors.white
                  : widget.fillColor ?? accentColor,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
