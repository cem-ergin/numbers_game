import 'package:get_it/get_it.dart';
import 'package:sayiciklar/repositories/auth/auth_repository.dart';
import 'package:sayiciklar/repositories/user/user_repository.dart';
import 'package:sayiciklar/repositories/user/user_service.dart';

GetIt locator = GetIt.I;

class MyLocator {
  static setupLocator() {
    locator.registerLazySingleton(() => AuthRepository());

    locator.registerLazySingleton(() => UserRepository());
    locator.registerLazySingleton(() => UserService());
  }
}
