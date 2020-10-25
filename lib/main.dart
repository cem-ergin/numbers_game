import 'package:eralpsoftware/eralpsoftware.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:sayiciklar/blocs/authentication/authentication_bloc.dart';
import 'package:sayiciklar/blocs/login/login_bloc.dart';
import 'package:sayiciklar/constants/shared_preferences.dart';
import 'package:sayiciklar/providers/game_provider.dart';
import 'package:sayiciklar/repositories/auth/auth_repository.dart';
import 'package:sayiciklar/route/route_generator.dart';
import 'package:sayiciklar/utils/locator.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MyLocator.setupLocator();
  Bloc.observer = MyBlocObserver();
  AuthRepository _authRepository = locator<AuthRepository>();
  SharedPreferences _sharedPreferences = await SharedPreferences.getInstance();
  final String _email =
      _sharedPreferences.getString(SharedPreferencesConstants.USERNAME);
  final String _password =
      _sharedPreferences.getString(SharedPreferencesConstants.PASSWORD);

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => AuthenticationBloc()
            ..add(
              AppStarted(email: _email, password: _password),
            ),
        ),
        BlocProvider(
          create: (ctx) => LoginBloc(
            authenticationBloc: BlocProvider.of<AuthenticationBloc>(ctx),
            authRepository: _authRepository,
          ),
        ),
      ],
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => GameProvider(),
          ),
        ],
        child: MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Eralp.builder(
      context: context,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Sayiciklar',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        onGenerateRoute: RouteGenerator.generateRoute,
        initialRoute: "/",
      ),
    );
  }
}

class MyBlocObserver extends BlocObserver {
  @override
  void onCreate(Cubit cubit) {
    super.onCreate(cubit);
    print('onCreate -- cubit: ${cubit.runtimeType}');
  }

  @override
  void onChange(Cubit cubit, Change change) {
    super.onChange(cubit, change);
    print('onChange -- cubit: ${cubit.runtimeType}, change: $change');
  }

  @override
  void onError(Cubit cubit, Object error, StackTrace stackTrace) {
    print('onError -- cubit: ${cubit.runtimeType}, error: $error');
    super.onError(cubit, error, stackTrace);
  }

  @override
  void onClose(Cubit cubit) {
    super.onClose(cubit);
    print('onClose -- cubit: ${cubit.runtimeType}');
  }
}
