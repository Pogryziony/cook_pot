import 'package:cook_pot/core/first_steps/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:cook_pot/core/auth/login/login_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: WelcomeScreen(),
    );
  }
}
