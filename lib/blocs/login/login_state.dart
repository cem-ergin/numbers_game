part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();
}

class LoginInitialState extends LoginState {
  @override
  List<Object> get props => [];
}

class LoginInProgressState extends LoginState {
  @override
  List<Object> get props => [];
}

class LoginFailureState extends LoginState {
  final String error;

  LoginFailureState({@required this.error});
  @override
  List<Object> get props => [error];
}
