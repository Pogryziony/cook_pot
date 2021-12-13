import 'dart:convert';
import 'package:cook_pot/repository/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class AuthenticationService extends UserRepository {
  final currentUser = FirebaseAuth.instance.currentUser;

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  @override
  Future<bool> authenticate(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return true;
    } on FirebaseAuthException catch (e) {
      debugPrint(e.message);
      return false;
    }
  }

  @override
  Future<void> logOut() => FirebaseAuth.instance.signOut();

  @override
  Future<bool> register(String email, String password) {
    // TODO: implement register
    throw UnimplementedError();
  }

  @override
  String? get signedEmail {
    if (this.currentUser != null) {
      return currentUser!.email;
    } else {
      return "";
    }
  }
}
