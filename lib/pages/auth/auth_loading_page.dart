import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sayiciklar/blocs/authentication/authentication_bloc.dart';
import 'package:sayiciklar/pages/auth/auth_home_page.dart';
import 'package:sayiciklar/pages/auth/splash_page.dart';
import 'package:sayiciklar/pages/home/home_page.dart';
import 'package:sayiciklar/utils/device.dart';

class AuthLoadingPage extends StatefulWidget {
  @override
  _AuthLoadingPageState createState() => _AuthLoadingPageState();
}

class _AuthLoadingPageState extends State<AuthLoadingPage> {
  MyDevice _myDevice;
  @override
  void initState() {
    super.initState();
    // manageLogin();
    _myDevice = MyDevice();
  }

  @override
  Widget build(BuildContext context) {
    _myDevice.setSize(MediaQuery.of(context).size);
    _myDevice.padding = MediaQuery.of(context).padding;

    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        if (state is AuthenticationInitialState) {
          return SplashPage();
        }
        if (state is AuthenticationSuccessState) {
          return MyHomePage();
        }
        if (state is AuthenticationSkippedState) {
          return MyHomePage();
        }
        if (state is AuthenticationFailureState) {
          return AuthHomePage();
        }
        if (state is AuthenticationInProgressState) {
          return Container(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        return SplashPage();
      },
    );
  }
}
