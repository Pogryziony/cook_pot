import 'package:flutter/material.dart';

class SmallUniversalButton extends StatelessWidget {

  final String visibleName;
  final VoidCallback? callbackFunction;

  SmallUniversalButton({required this.visibleName, this.callbackFunction});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.fromLTRB(60, 0, 60, 0),
        child: Material(
          elevation: 5.0,
          borderRadius: BorderRadius.circular(30.0),
          color: Colors.lightGreen,
          child: MaterialButton(
            minWidth: MediaQuery
                .of(context)
                .size
                .width,
            onPressed: callbackFunction,
            child: Text(
              visibleName,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      );
  }
}
