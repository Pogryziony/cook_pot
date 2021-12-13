import 'package:equatable/equatable.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object?> get props => [];
}

class LoginInitial extends LoginState {
  const LoginInitial();
}

class LoginLoading extends LoginState{
  const LoginLoading();
}

class LoginPassed extends LoginState{
  const LoginPassed();
}

class LoginFailure extends LoginState{
  const LoginFailure();
}