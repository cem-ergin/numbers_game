import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:sayiciklar/blocs/authentication/authentication_bloc.dart';
import 'package:sayiciklar/models/auth/auth.dart';
import 'package:sayiciklar/repositories/auth/auth_repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository authRepository;
  final AuthenticationBloc authenticationBloc;
  LoginBloc({
    @required this.authRepository,
    @required this.authenticationBloc,
  }) : super(LoginInitialState());

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is LoginButtonPressed) {
      yield LoginInProgressState();
      try {
        var response = await authRepository.authenticate(
          username: event.username,
          password: event.password,
        );

        if (response is Auth && response != null) {
          print("auth null degil");
          authenticationBloc.add(AuthenticationLoggedIn(auth: response));
          yield LoginInitialState();
        } else {
          yield LoginFailureState(error: response);
        }
      } catch (error) {
        yield LoginFailureState(error: error.toString());
      }
    }
  }
}
