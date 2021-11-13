import 'package:flutter/material.dart';

const double defaultBorderRadius = 3.0;

class StretchableButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final double borderRadius;
  final double? buttonPadding;
  final Color buttonColor;
  final Color? buttonBorderColor;
  final List<Widget> children;
  final bool centered;
  final double? width;

  StretchableButton({
    required this.buttonColor,
    required this.borderRadius,
    required this.children,
    this.buttonBorderColor,
    this.onPressed,
    this.buttonPadding,
    this.centered = false,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        var contents = List<Widget>.from(children);

        if (constraints.minWidth == 0) {
          contents.add(SizedBox.shrink());
        } else {
          if (centered) {
            contents.insert(0, Spacer());
          }
          contents.add(Spacer());
        }

        BorderSide bs;
        if (buttonBorderColor != null) {
          bs = BorderSide(
            color: (buttonBorderColor)!,
          );
        } else {
          bs = BorderSide.none;
        }

        return Container(
          width: width,
          child: ButtonTheme(
              height: 50.0,
              padding: EdgeInsets.all(buttonPadding ?? 0.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadius),
                side: bs,
              ),
              child: ElevatedButton(
                onPressed: onPressed,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: contents,
                ),
              ),
          ),
        );
      },
    );
  }
}
