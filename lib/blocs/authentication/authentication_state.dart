part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();
}

class AuthenticationInitialState extends AuthenticationState {
  @override
  List<Object> get props => [];
}

class AuthenticationSuccessState extends AuthenticationState {
  @override
  List<Object> get props => [];
}

class AuthenticationFailureState extends AuthenticationState {
  @override
  List<Object> get props => [];
}

class AuthenticationInProgressState extends AuthenticationState {
  @override
  List<Object> get props => [];
}

class AuthenticationSkippedState extends AuthenticationState {
  @override
  List<Object> get props => [];
}
