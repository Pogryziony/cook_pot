import 'package:flutter/material.dart';
import 'button.dart';

class MediumButton extends StatelessWidget {
  final String text;
  final TextStyle? textStyle;
  final double borderRadius;
  final VoidCallback onPressed;
  final bool centered;
  
  MediumButton({
    required this.onPressed,
    required this.text,
    this.textStyle,
    this.borderRadius = defaultBorderRadius,
    this.centered = false,
  });

  @override
  Widget build(BuildContext context) {
    return StretchableButton(
      width: MediaQuery.of(context).size.width/(2.5),
      borderRadius: borderRadius,
      onPressed: onPressed,
      buttonPadding: 0.0,
      centered: centered,
      buttonColor: Colors.lightGreen,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 8.0),
          child: Text(
            text,
            style: textStyle ??
                TextStyle(
                  fontSize: 18.0,
                  fontFamily: "Roboto",
                  fontWeight: FontWeight.w500,
                  color: Colors.white
                ),
          ),
        ),
      ],
    );
  }
}
