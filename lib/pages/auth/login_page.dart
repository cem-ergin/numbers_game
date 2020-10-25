import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sayiciklar/blocs/authentication/authentication_bloc.dart';
import 'package:sayiciklar/blocs/login/login_bloc.dart';
import 'package:sayiciklar/utils/device.dart';

MyDevice _myDevice = MyDevice();

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _usernameController.text = "cemergin";
    _passwordController.text = "123456";
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state is AuthenticationSuccessState) {
          Navigator.popUntil(context, (route) => route.isFirst);
        }
        if (state is AuthenticationSkippedState) {
          Navigator.popUntil(context, (route) => route.isFirst);
        }
      },
      child: _buildLoginPage(context),
    );
  }

  GestureDetector _buildLoginPage(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0,
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    hintText: "username",
                  ),
                ),
                TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    hintText: "password",
                  ),
                  obscureText: true,
                ),
                _myDevice.sbh(8),
                BlocConsumer<LoginBloc, LoginState>(
                  builder: (context, state) {
                    return Container(
                      height: _myDevice.getHeight(70),
                      child: RaisedButton(
                        onPressed: state is LoginInProgressState ? null : login,
                        child: state is LoginInProgressState
                            ? Container(
                                height: _myDevice.getHeight(22),
                                width: _myDevice.getWidth(100),
                                child: FittedBox(
                                  fit: BoxFit.fitHeight,
                                  child: CircularProgressIndicator(
                                    backgroundColor: Colors.white,
                                    valueColor: AlwaysStoppedAnimation(
                                      Color(0xff3866EC),
                                    ),
                                  ),
                                ),
                              )
                            : Container(
                                height: _myDevice.getHeight(22),
                                width: _myDevice.getWidth(100),
                                child: Center(
                                  child: Text(
                                    "Giriş Yap",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontStyle: FontStyle.italic,
                                      fontWeight: FontWeight.w500,
                                      fontSize: _myDevice.getDouble(18),
                                    ),
                                  ),
                                ),
                              ),
                      ),
                    );
                  },
                  listener: (context, state) {
                    if (state is LoginFailureState) {
                      Scaffold.of(context).showSnackBar(
                        SnackBar(
                          content: Text("${state.error}"),
                        ),
                      );
                      // RegisterDialogHelper.showResultDialog(
                      //     context, "${state.error}");
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void login() {
    // if (_formKey.currentState.validate()) {
    BlocProvider.of<LoginBloc>(context).add(
      LoginButtonPressed(
        username: _usernameController.text,
        password: _passwordController.text,
      ),
    );
    // }
  }
}
