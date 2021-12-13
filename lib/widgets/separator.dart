import 'package:flutter/material.dart';

/// Used to separate widgets in the vertical direction
class Separator extends StatelessWidget {
  final double height;
  const Separator(this.height);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
    );
  }
}