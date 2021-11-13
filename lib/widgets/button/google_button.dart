import 'package:flutter/material.dart';
import 'button.dart';

class GoogleSignInButton extends StatelessWidget {
  final String text;
  final TextStyle? textStyle;
  final double borderRadius;
  final VoidCallback onPressed;
  final bool centered;

  GoogleSignInButton(
      {required this.onPressed,
        this.text = 'Sign in with Google',
        this.textStyle,
        this.borderRadius = defaultBorderRadius,
        this.centered = false,
        required Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StretchableButton(
      width: MediaQuery.of(context).size.width,
      borderRadius: borderRadius,
      onPressed: onPressed,
      buttonPadding: 0.0,
      centered: centered,
      buttonColor: Colors.lightGreen,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(1.0),
          child: Container(
            height: 38.0, // 40dp - 2*1dp border
            width: 38.0, // matches above
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(this.borderRadius),
            ),
            child: Center(
              child: Image(
                image: AssetImage(
                  "assets/images/logo/google-logo.png",
                ),
                height: 18.0,
                width: 18.0,
              ),
            ),
          ),
        ),

        SizedBox(width: 14.0 /* 24.0 - 10dp padding */),
        Padding(
          padding: const EdgeInsets.fromLTRB(0.0, 8.0, 8.0, 8.0),
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
