import 'package:cook_pot/utils/helpers/validate_password.dart';
import 'package:flutter/material.dart';

class PasswordField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      child: TextFormField(
        style: const TextStyle(color: Colors.white),
        cursorColor: Colors.white,
        obscureText: true,
        validator: validatePassword,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: 'Password',
          hintStyle: const TextStyle(color: Colors.white),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(32),
            borderSide: const BorderSide(color: Colors.white, width: 2),
          ),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(32),
              borderSide: const BorderSide(color: Colors.white, width: 2)
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(32),
              borderSide: const BorderSide(color: Colors.white, width: 2)
          ),
        ),
      ),
    );

  }
}
