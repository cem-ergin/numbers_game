import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sayiciklar/blocs/authentication/authentication_bloc.dart';

class BlocHelper {
  static void logout({@required BuildContext context}) {
    //authentication -> failure state
    BlocProvider.of<AuthenticationBloc>(context).add(AuthenticationLoggedOut());
  }
}
