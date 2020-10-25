import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sayiciklar/blocs/authentication/authentication_bloc.dart';
import 'package:sayiciklar/utils/device.dart';

MyDevice _myDevice = MyDevice();

class AuthHomePage extends StatefulWidget {
  AuthHomePage({Key key}) : super(key: key);

  @override
  _AuthHomePageState createState() => _AuthHomePageState();
}

class _AuthHomePageState extends State<AuthHomePage> {
  AuthenticationBloc _authenticationBloc;
  @override
  void initState() {
    super.initState();
    _authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () => Navigator.pushNamed(context, "/loginPage"),
              child: Text(
                "Login",
                style: _textStyle,
              ),
            ),
            Divider(),
            InkWell(
              onTap: () {
                _authenticationBloc.add(
                  AuthenticationSkipEvent(),
                );
              },
              child: Text(
                "Skip",
                style: _textStyle.copyWith(fontWeight: FontWeight.w300),
              ),
            ),
            Divider(),
            InkWell(
              onTap: () => Navigator.pushNamed(context, "/signUpPage"),
              child: Text(
                "Sign Up",
                style: _textStyle,
              ),
            ),
          ],
        ),
      ),
    );
  }

  TextStyle get _textStyle => TextStyle(
        fontSize: _myDevice.getDouble(34),
        fontWeight: FontWeight.bold,
      );
}
