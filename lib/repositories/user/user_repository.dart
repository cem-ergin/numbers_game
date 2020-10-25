import 'package:sayiciklar/repositories/user/user_service.dart';
import 'package:sayiciklar/utils/locator.dart';

class UserRepository {
  final UserService _userServices = locator<UserService>();

  String _fullName = "";
  String get fullName => _fullName;
  set fullName(String fullName) {
    _fullName = fullName;
    print("FULLNAME SETTED TO $_fullName");
  }

  Future<bool> register(Map<String, dynamic> userData) async {
    return await _userServices.register(userData);
  }
}
