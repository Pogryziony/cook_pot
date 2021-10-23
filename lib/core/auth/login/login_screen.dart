import 'package:cook_pot/widgets/field/login_field.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Container(
          child: LoginField(),
          //decoration: const BoxDecoration(
            // image: DecorationImage(
            //   image: AssetImage(''),
            // ),
         // ),
        ),
      ),
    );
  }
}
