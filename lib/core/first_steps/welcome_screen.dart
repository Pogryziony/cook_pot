import 'package:cook_pot/widgets/button/google_sign_in_button.dart';
import 'package:cook_pot/widgets/button/redirect_to_login.dart';
import 'package:cook_pot/widgets/button/register_button.dart';
import 'package:cook_pot/widgets/button/remind_password_button.dart';
import 'package:cook_pot/widgets/slider/welcome_slider.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
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
            margin: const EdgeInsets.only(top: 100),
            padding: const EdgeInsets.all(36.0),
            child: ListView(
              children: <Widget>[
                WelcomeSlider(),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: new Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: RedirectToLoginButton(),
                      ),
                    ),
                    Expanded(
                      child: new Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: GoogleSignInButton(),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(5),
                      child: RemindPasswordButton(),
                    ),
                    Padding(
                      padding: EdgeInsets.all(5),
                      child: RegisterButton(),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
