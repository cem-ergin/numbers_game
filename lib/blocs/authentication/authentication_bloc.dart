import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:sayiciklar/constants/shared_preferences.dart';
import 'package:sayiciklar/models/auth/auth.dart';
import 'package:sayiciklar/repositories/auth/auth_repository.dart';
import 'package:sayiciklar/repositories/user/user_repository.dart';
import 'package:sayiciklar/utils/locator.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(AuthenticationInitialState());

  final AuthRepository _authRepository = locator<AuthRepository>();
  final UserRepository _userRepository = locator<UserRepository>();

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is AppStarted) {
      // await Future.delayed(Duration(milliseconds: 1250));
      if (event.email != null &&
          event.password != null &&
          event.email.length > 1 &&
          event.password.length > 1) {
        print("app started, authenticate oluyorum");

        await _authRepository.authenticate(
          username: event.email,
          password: event.password,
        );
      }

      final bool hasToken = await _authRepository.hasToken();
      if (hasToken) {
        yield AuthenticationSuccessState();
      } else {
        yield AuthenticationFailureState();
      }
    }

    if (event is AuthenticationLoggedIn) {
      yield AuthenticationInProgressState();

      final bool hasToken = await _authRepository.hasToken();
      if (hasToken) {
        yield AuthenticationSuccessState();
      } else {
        yield AuthenticationFailureState();
      }
    }

    if (event is AuthenticationSkipEvent) {
      yield AuthenticationSkippedState();
    }

    if (event is AuthenticationLoggedOut) {
      yield AuthenticationFailureState();
      SharedPreferences _sharedPreferences =
          await SharedPreferences.getInstance();
      _sharedPreferences.setString(SharedPreferencesConstants.USERNAME, "");
      _sharedPreferences.setString(SharedPreferencesConstants.PASSWORD, "");
    }
  }
}
