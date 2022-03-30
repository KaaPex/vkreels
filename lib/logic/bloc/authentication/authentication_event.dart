part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AppStarted extends AuthenticationEvent {
  @override
  String toString() => 'AppStarted';
}

class AuthenticationLoginRequested extends AuthenticationEvent {
  final String token;

  AuthenticationLoginRequested({required this.token});

  @override
  String toString() => 'AuthenticationLogin { token: $token }';

  @override
  List<Object> get props => [token];
}

class AuthenticationLogoutRequested extends AuthenticationEvent {
  @override
  String toString() => 'AuthenticationLogoutRequested';
}

class AuthenticationStatusChanged extends AuthenticationEvent {
  const AuthenticationStatusChanged(this.status);

  final AuthenticationStatus status;

  @override
  List<Object> get props => [status];
}
