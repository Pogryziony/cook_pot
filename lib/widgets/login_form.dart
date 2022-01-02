import 'package:cook_pot/bloc/login_bloc.dart';
import 'package:cook_pot/modules/main_menu_screen.dart';
import 'package:cook_pot/widgets/separator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';


class LoginForm extends StatefulWidget {
  const LoginForm();

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void loginButtonPressed(BuildContext context,{bool listen = false}) {
    Provider.of<LoginBloc>(context, listen: false).add(LoginButtonPressed(
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
  Widget build(BuildContext context,{bool listen = false}) {

    return LayoutBuilder(builder: (builder, data) {
      var baseWidth = MediaQuery.of(context).size.width;
      if (data.maxWidth <= baseWidth) {
        baseWidth = data.maxWidth;
      }
      return SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Separator(50),
            Form(
              key: formKey,
              child: Wrap(
                direction: Axis.vertical,
                spacing: 20,
                children: <Widget>[
                  SizedBox(
                    width: baseWidth,
                    child: TextFormField(
                      controller: emailController,
                      validator: validateEmail,
                      cursorColor: Colors.white,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      decoration: InputDecoration(
                        contentPadding:
                            const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        hintText: 'Login',
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
                      controller: passwordController,
                      validator: validatePassword,
                      obscureText: true,
                      cursorColor: Colors.white,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      decoration: InputDecoration(
                        contentPadding:
                            const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        hintText: 'Password',
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
            BlocConsumer<LoginBloc, LoginState>(listener: (context, state) {
              if (state is LoginFailure) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text('Login failed')));
              }
            }, builder: (context, state) {
              if (state is LoginLoading) {
                return const CircularProgressIndicator();
              }
              return ElevatedButton(
                key:  Key('loginButton'),
                onPressed: () {
              //TODO: change navigator to validate
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (BuildContext context) {
                  //     return LoginScreen();
                  //   }),
                  // )
                  if(formKey.currentState!.validate()){
                    loginButtonPressed(context);
                    Navigator.push(context, 
                        MaterialPageRoute(builder: (BuildContext context){
                            return MainMenuScreen();
                        }),
                    );
                  }else{
                    
                  }
                },
                child: Text('login'),
              );
            })
          ],
        ),
      );
    });
  }
}
