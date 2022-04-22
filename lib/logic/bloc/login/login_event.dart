part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginButtonPressed extends LoginEvent {
  const LoginButtonPressed();

  @override
  String toString() => 'LoginButtonPressed';
}

class LogoutButtonPressed extends LoginEvent {
  const LogoutButtonPressed();

  @override
  String toString() => 'LogoutButtonPressed';
}

class LoginCancelled extends LoginEvent {
  @override
  String toString() => 'LoginCancelled';
}
