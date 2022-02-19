import 'dart:ui';
import 'package:cook_pot/bloc/authentication_bloc.dart';
import 'package:cook_pot/bloc/login_bloc.dart';
import 'package:cook_pot/core/auth/register/registration_form_screen.dart';
import 'package:cook_pot/repository/test_repository.dart';
import 'package:cook_pot/widgets/field/registration_form.dart';
import 'package:cook_pot/widgets/login_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen();

  @override
  Widget build(BuildContext context) {
    final userRepository = context.select((TestUserRepository u) => u);
    final authenticationBloc = context.watch<AuthenticationBloc>();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocProvider<LoginBloc>(
        create: (context) => LoginBloc(
          authenticationBloc: authenticationBloc,
          userRepository: userRepository,
        ),
        child: Center(
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
                      height: 140,
                    ),
                  ),
                  LoginForm(),
                  ElevatedButton(onPressed: () =>{
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (BuildContext context) {
                          return RegistrationFormScreen();
                        }),
                      )}, child: Text('Register'))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
