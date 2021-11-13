import 'package:cook_pot/core/auth/register/registration_form_screen.dart';
import 'package:cook_pot/modules/main_menu_screen.dart';
import 'package:cook_pot/widgets/button/large_button.dart';
import 'package:cook_pot/widgets/field/login_field.dart';
import 'package:cook_pot/widgets/field/password_field.dart';
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
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/background/background.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            margin: const EdgeInsets.only(top: 70),
            padding: const EdgeInsets.all(38.0),
            child: Column(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(20.0),
                  child: Image.asset(
                    'assets/images/logo/cook_pot_logo_150px_transparent.png',
                    fit: BoxFit.fitHeight,
                    height: 200, // set your height
                  ),
                ),
                LoginField(),
                PasswordField(),
                Container(
                  padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                  child: Column(
                    children: [
                      LargeButton(
                        text: 'Login',
                        centered: true,
                        onPressed: () => {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (BuildContext context) {
                              return MainMenuScreen();
                            }),
                          ),
                        },
                      ),
                      LargeButton(
                        text: 'Register',
                        centered: true,
                        onPressed: () => {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (BuildContext context) {
                              return RegistrationFormScreen();
                            }),
                          ),
                        },
                      ),
                    ],
                  ) ,
                )

              ],
            ),
          ),
        ),
      ),
    );
  }
}
