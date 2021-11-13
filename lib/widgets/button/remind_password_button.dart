import 'package:flutter/material.dart';

class RemindPasswordButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Material(
        elevation: 5.0,
        borderRadius: BorderRadius.circular(30.0),
        color: Colors.orange,
        child: MaterialButton(
          minWidth: MediaQuery.of(context).size.width,
          onPressed: () {},
          child: const Text(
            'Forgot password',
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
