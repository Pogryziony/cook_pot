import 'package:cook_pot/bloc/login_bloc.dart';
import 'package:cook_pot/bloc/registration/registration_bloc.dart';
import 'package:cook_pot/core/first_steps/welcome_screen.dart';
import 'package:cook_pot/modules/main_menu_screen.dart';
import 'package:cook_pot/widgets/separator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class RegistrationForm extends StatefulWidget {
  const RegistrationForm();

  @override
  _RegistrationFormState createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final registrationFormKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  void registrationButtonPressed(BuildContext context, {bool listen = false}) {
    Provider.of<RegistrationBloc>(context, listen: false).add(RegistrationButtonPressed(
        email: emailController.text, password: passwordController.text));
  }

  String? validateEmail(String? input) {
    if ((input!.length > 10) && (input.contains("@"))) {
      return null;
    } else {
      return ("Incorrect email");
    }
  }

  String? validatePassword(String? input) {
    if (input!.length > 5) {
      return null;
    } else {
      return ("Incorrect password");
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context, {bool listen = false}) {
    return LayoutBuilder(builder: (builder, data) {
      var baseWidth = MediaQuery.of(context).size.width;
      if (data.maxWidth <= baseWidth) {
        baseWidth = data.maxWidth;
      }
      return SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Separator(20),
            Form(
              key: registrationFormKey,
              child: Wrap(
                direction: Axis.vertical,
                spacing: 20,
                children: <Widget>[
                  SizedBox(
                    width: baseWidth,
                    child: TextFormField(
                      controller: emailController,
                      cursorColor: Colors.white,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      decoration: InputDecoration(
                        contentPadding:
                            const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        hintText: 'Email address',
                        hintStyle: const TextStyle(color: Colors.white),
                        disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(32),
                          borderSide:
                              const BorderSide(color: Colors.white, width: 2),
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(32),
                            borderSide: const BorderSide(
                                color: Colors.white, width: 2)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(32),
                            borderSide: const BorderSide(
                                color: Colors.white, width: 2)),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: baseWidth,
                    child: TextFormField(
                      controller: passwordController,
                      cursorColor: Colors.white,
                      obscureText: true,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      decoration: InputDecoration(
                        contentPadding:
                        const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        hintText: 'Password',
                        hintStyle: const TextStyle(color: Colors.white),
                        focusColor: Colors.white,
                        disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(32),
                          borderSide:
                          const BorderSide(color: Colors.white, width: 2),
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(32),
                            borderSide: const BorderSide(
                                color: Colors.white, width: 2)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(32),
                            borderSide: const BorderSide(
                                color: Colors.white, width: 2)),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: baseWidth,
                    child: TextFormField(
                      controller: confirmPasswordController,
                      obscureText: true,
                      cursorColor: Colors.white,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      decoration: InputDecoration(
                        contentPadding:
                        const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        hintText: 'Confirm password',
                        hintStyle: const TextStyle(color: Colors.white),
                        disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(32),
                          borderSide:
                          const BorderSide(color: Colors.white, width: 2),
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(32),
                            borderSide: const BorderSide(
                                color: Colors.white, width: 2)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(32),
                            borderSide: const BorderSide(
                                color: Colors.white, width: 2)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Separator(25),
            BlocConsumer<RegistrationBloc, RegistrationState>(listener: (context, state) {
              if (state is RegistrationFailure) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text('Registration failed')));
              }
            }, builder: (context, state) {
              if (state is RegistrationLoading) {
                return const CircularProgressIndicator();
              }
              return ElevatedButton(
                key: Key('registrationButton'),
                onPressed: () {
                  if (registrationFormKey.currentState!.validate()) {
                    registrationButtonPressed(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (BuildContext context) {
                        return WelcomeScreen();
                      }),
                    );
                  }
                },
                child: Text('Register'),
              );
            })
          ],
        ),
      );
    });
  }
}
