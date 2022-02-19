part of 'registration_bloc.dart';

@immutable
abstract class RegistrationState extends Equatable {
  const RegistrationState();

  @override
  List<Object?> get props => [];
}

class RegistrationInitial extends RegistrationState {
  const RegistrationInitial();
}

class RegistrationLoading extends RegistrationState {
  const RegistrationLoading();
}

class RegistrationPassed extends RegistrationState {
  const RegistrationPassed();
}

class RegistrationFailure extends RegistrationState {
  const RegistrationFailure();
}
