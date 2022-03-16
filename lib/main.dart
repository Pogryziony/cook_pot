import 'dart:io';

import 'package:cook_pot/bloc/authentication_bloc.dart';
import 'package:cook_pot/bloc/registration/registration_bloc.dart';
import 'package:cook_pot/core/auth/register/registration_form_screen.dart';
import 'package:cook_pot/core/first_steps/welcome_screen.dart';
import 'package:cook_pot/modules/main_menu_screen.dart';
import 'package:cook_pot/modules/recipes/appetizers/recipes_screen.dart';
import 'package:cook_pot/modules/recipes/bloc/recipes_bloc.dart';
import 'package:cook_pot/utils/services/authentication_service.dart';
import 'package:cook_pot/widgets/recipe_create_form.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseApp app = await Firebase.initializeApp();
  HttpOverrides.global = MyHttpOverrides();
  runApp(Provider<AuthenticationService>(
    create: (_) => AuthenticationService(),
    child: MyApp(),
  ));
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (BuildContext context, AsyncSnapshot<Object?> snapshot) {
        if (snapshot.hasError) {
          return InitializationError();
        }

        if (snapshot.connectionState == ConnectionState.done) {
          return MyApp();
        }

        return CircularProgressIndicator();
      },
    );
  }
}

class InitializationError extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    throw UnimplementedError();
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, {bool listen = false}) {
    final repository = context.select((AuthenticationService r) => r);
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthenticationBloc(repository)),
        BlocProvider(create: (context) => RecipesBloc()),
        BlocProvider(
            create: (context) => RegistrationBloc(
                userRepository: repository,
                authenticationService: AuthenticationService())),
      ],
      child: MaterialApp(
        title: 'Cook Pot',
        routes: <String, WidgetBuilder>{
          WelcomeScreen.routeName: (BuildContext context) => WelcomeScreen(),
          MainMenuScreen.routeName: (BuildContext context) => MainMenuScreen(),
          RegistrationFormScreen.routeName: (BuildContext context) =>
              RegistrationFormScreen(),
          RecipeCreateForm.routeName: (BuildContext context) =>
              RecipeCreateForm(),
          RecipesScreen.routeName: (BuildContext context) => RecipesScreen(),
        },
        initialRoute: '/',
        theme: ThemeData(
          primarySwatch: Colors.lightGreen,
        ),
      ),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
