import 'package:cook_pot/widgets/field/registration_form.dart';
import 'package:flutter/material.dart';

class RegistrationFormScreen extends StatefulWidget {
  @override
  _RegistrationFormScreenState createState() => _RegistrationFormScreenState();
}

class _RegistrationFormScreenState extends State<RegistrationFormScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/background/background.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            margin: const EdgeInsets.only(top: 100),
            padding: const EdgeInsets.all(35.0),
            child: Column(
              children: <Widget>[
                Container(
                  child: Image.asset(
                    'assets/images/logo/cook_pot_logo_150px_transparent.png',
                    fit: BoxFit.fitHeight,
                    height: 140,
                  ),
                ),
                RegistrationForm(),
              ],
            ),
          ),
        ),
    );
  }
}
