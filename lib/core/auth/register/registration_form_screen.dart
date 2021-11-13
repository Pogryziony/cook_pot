import 'package:cook_pot/widgets/button/login_button.dart';
import 'package:cook_pot/widgets/button/medium_button.dart';
import 'package:cook_pot/widgets/button/submit_button.dart';
import 'package:cook_pot/widgets/field/confirm_password_field.dart';
import 'package:cook_pot/widgets/field/email_field.dart';
import 'package:cook_pot/widgets/field/login_field.dart';
import 'package:cook_pot/widgets/field/password_field.dart';
import 'package:cook_pot/widgets/field/username_field.dart';
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
      body: Center(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/background/background.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            margin: const EdgeInsets.only(top: 90),
            padding: const EdgeInsets.all(45.0),
            child: Column(
              children: <Widget>[
                SizedBox(
                  child: Image.asset(
                    'assets/images/logo/cook_pot_logo_150px_transparent.png',
                    fit: BoxFit.fitHeight,
                    height: 180, // set your height
                  ),
                ),
                UsernameField(),
                EmailField(),
                PasswordField(),
                ConfirmPasswordField(),
                MediumButton(
                  onPressed: () => {},
                  text: 'Register',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
