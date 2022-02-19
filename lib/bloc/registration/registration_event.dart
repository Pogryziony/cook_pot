part of 'registration_bloc.dart';

@immutable
abstract class RegistrationEvent extends Equatable {
  final String email;
  final String password;

  const RegistrationEvent(this.email, this.password);

  @override
  List<Object?> get props => [email, password];
}

class RegistrationButtonPressed extends RegistrationEvent {
  const RegistrationButtonPressed({
    required String email,
    required String password,
  }) : super(email, password);
}
