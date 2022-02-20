import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cook_pot/repository/user_repository.dart';
import 'package:cook_pot/utils/services/authentication_service.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'registration_event.dart';

part 'registration_state.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  final UserRepository userRepository;
  final AuthenticationService authenticationService;

  RegistrationBloc({
    required this.userRepository,
    required this.authenticationService,
  }) : super(RegistrationInitial());

  @override
  Stream<RegistrationState> mapEventToState(RegistrationEvent event) async* {
    if (event is RegistrationButtonPressed) {
      yield* _registrationButtonPressed(event);
    }
  }

  Stream<RegistrationState> _registrationButtonPressed(
      RegistrationEvent event) async* {
    yield RegistrationLoading();
    try {
      await userRepository.register(event.email, event.password);
    } on FirebaseException {
      yield RegistrationFailure();
    } catch (e) {
      print(e);
    }
  }
}
