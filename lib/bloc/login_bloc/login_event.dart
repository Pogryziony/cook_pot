import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  final String email;
  final String password;

  const LoginEvent(this.email, this.password);

  @override
  List<Object?> get props => [email, password];
}

class LoginButtonPressed extends LoginEvent {
  const LoginButtonPressed({required String email, required String password})
      : super(email, password);
}
