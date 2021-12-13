import 'package:flutter/material.dart';

// ignore: must_be_immutable
class LoginField extends StatelessWidget {

  TextEditingController loginFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      child: TextFormField(
        controller: loginFieldController,
        style: const TextStyle(color: Colors.white),
        cursorColor: Colors.white,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: 'Login',
          hintStyle: const TextStyle(color: Colors.white),
          focusColor: Colors.white,
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
