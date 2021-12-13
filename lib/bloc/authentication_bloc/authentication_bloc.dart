import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cook_pot/repository/user_repository.dart';
import 'package:equatable/equatable.dart';

import 'authentication_event.dart';
import 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository userRepository;
  AuthenticationBloc(this.userRepository) : super(AuthenticationInit());

  @override
  Stream<AuthenticationState> mapEventToState(
      AuthenticationEvent event) async* {
    if (event is LoggedIn) {
      yield AuthenticationSuccess();
    }

    if (event is LoggedOut) {
      yield AuthenticationLoading();
      await userRepository.logOut();
      yield AuthenticationRevoked();
    }
  }
}
