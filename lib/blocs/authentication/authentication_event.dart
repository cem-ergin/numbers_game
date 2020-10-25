part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();
}

class AppStarted extends AuthenticationEvent {
  final String email;
  final String password;

  AppStarted({this.email, this.password});

  @override
  List<Object> get props => [email, password];

  @override
  String toString() => 'App started {email: $email, password: $password}';
}

class AuthenticationLoggedIn extends AuthenticationEvent {
  final Auth auth;

  const AuthenticationLoggedIn({@required this.auth});

  @override
  List<Object> get props => [auth];

  @override
  String toString() => 'LoggedIn { auth: ${auth.toJson()} }';
}

class AuthenticationLoggedOut extends AuthenticationEvent {
  @override
  List<Object> get props => [];
}

class AuthenticationSkipEvent extends AuthenticationEvent {
  @override
  List<Object> get props => [];
}
