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
  Future<void> register(String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password
      );
    } on FirebaseAuthException catch (error) {
      if (error.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (error.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (error) {
    }
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
