import 'package:cook_pot/core/auth/login/login_screen.dart';
import 'package:cook_pot/widgets/button/google_button.dart';
import 'package:cook_pot/widgets/button/large_button.dart';
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
            padding: const EdgeInsets.all(35.0),
            child: Column(
              children: <Widget>[
                Container(
                  child: Image.asset(
                    'assets/images/logo/cook_pot_logo_150px_transparent.png',
                    fit: BoxFit.fitHeight,
                    height: 200,
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.fromLTRB(5,15,5,2.5),
                        child: LargeButton(
                          onPressed: () => {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (BuildContext context) {
                                return LoginScreen();
                              }),
                            ),
                          },
                          text: 'Sign in with Email',
                          centered: true,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(5),
                        child: GoogleSignInButton(
                          key: UniqueKey(),
                          onPressed: () {},
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(5),
                        child: LargeButton(
                          onPressed: () => {},
                          text: 'Sign up with Email',
                          centered: true,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
