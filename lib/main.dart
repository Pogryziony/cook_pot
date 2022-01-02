import 'dart:io';

import 'package:cook_pot/bloc/authentication_bloc.dart';
import 'package:cook_pot/core/first_steps/welcome_screen.dart';
import 'package:cook_pot/repository/test_repository.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseApp app = await Firebase.initializeApp();
  HttpOverrides.global = MyHttpOverrides();
  runApp(Provider<TestUserRepository>(
    create: (_) =>
    const TestUserRepository(
      fakeEmail: "pogryziony98@gmail.com",
      success: true,
    ),
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
  Widget build(BuildContext context,{bool listen = false}) {
    final repository = context.select((TestUserRepository r) => r);
    return BlocProvider(
      create: (context) => AuthenticationBloc(repository),
      child: MaterialApp(
        title: 'Cook Pot',
        theme: ThemeData(
          primarySwatch: Colors.lightGreen,
        ),
        home: WelcomeScreen(),
      ),
    );
  }
}

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}
