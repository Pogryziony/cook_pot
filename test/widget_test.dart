// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:cook_pot/core/first_steps/welcome_screen.dart';
import 'package:cook_pot/repository/user_repository.dart';
import 'package:cook_pot/utils/services/authentication_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets('App initialization test with form check', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    await tester.pumpWidget(Provider<AuthenticationService>(
      create: (_) => AuthenticationService(),
      child: WelcomeScreen(),
    ));
    await tester.enterText(find.byType(TextFormField), 'Check typing');
    await tester.pump();
    expect(find.text('Check typing'), findsWidgets);
  });
}
