import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cook_pot/bloc/authentication_bloc.dart';
import 'package:cook_pot/bloc/login_bloc.dart';
import 'package:cook_pot/repository/user_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';


import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository userRepository;
  final AuthenticationBloc authenticationBloc;

  LoginBloc({
    required this.authenticationBloc,
    required this.userRepository,
  }) : super(LoginInitial());

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginButtonPressed) {
      yield* _loginPressed(event);
    }
  }

  Stream<LoginState> _loginPressed(LoginEvent event) async* {
    yield LoginLoading();
    try {
      final success = await userRepository.authenticate(
          event.email, event.password);
      
      if (success) {
        authenticationBloc.add(const LoggedIn());
        yield LoginPassed();
      }  else{
        yield LoginFailure();
      }
    } on FirebaseException{
      yield LoginFailure();
    }
  }
}