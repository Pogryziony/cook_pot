import 'package:cook_pot/core/auth/login/login_screen.dart';
import 'package:flutter/material.dart';

class RedirectToLoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Material(
        elevation: 5.0,
        borderRadius: BorderRadius.circular(30.0),
        color: Colors.orange,
        child: MaterialButton(
          minWidth: MediaQuery.of(context).size.width,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (BuildContext context) {
                return LoginScreen();
              }),
            );
          },
          child: Container(
            child: Text(
              'Log in',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
