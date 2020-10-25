import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sayiciklar/constants/api_urls.dart';
import 'package:sayiciklar/constants/shared_preferences.dart';
import 'package:sayiciklar/helper/eralp_helper.dart';
import 'package:sayiciklar/models/auth/auth.dart';
import 'package:http/http.dart' as http;
import 'package:sayiciklar/repositories/user/user_repository.dart';
import 'package:sayiciklar/utils/locator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepository {
  final UserRepository _userRepository = locator<UserRepository>();

  Auth _auth;
  Future<dynamic> authenticate({
    @required String username,
    @required String password,
  }) async {
    var response;
    try {
      EralpHelper.startProgress();
      response = await getAuth(username, password);

      if (response is Auth && response != null) {
        // _userRepository.setUser(response);
        // _userRepository.fullName = response.adiSoyadi;
        setAccountToSharedPreferences(username, password);
        _auth = response;
        return _auth;
      } else {
        return response;
      }
    } catch (e) {
      print("authenticate catch, error: $e");
      return response;
    } finally {
      EralpHelper.stopProgress();
    }
  }

  Future<bool> hasToken() async {
    if (_auth != null) {
      if (_auth.token != null) {
        return true;
      }
      return false;
    }
    return false;
  }

  Future<dynamic> getAuth(String _username, String _password) async {
    print("getting auth on: ${ApiUrls.LOGIN_URL}");
    final response = await http.post(
      ApiUrls.LOGIN_URL,
      headers: {
        HttpHeaders.contentTypeHeader: "application/json",
      },
      body: jsonEncode(
        <String, String>{
          'username': _username,
          'password': _password,
        },
      ),
    );
    if (response.statusCode == 200) {
      Auth _auth = authFromJson(utf8.decode(response.bodyBytes));
      return _auth;
    } else if (response.statusCode == 400) {
      return "Kullanıcı bulunamadı";
    } else {
      return jsonDecode(response.body)["message"];
    }
  }

  Future<void> setAccountToSharedPreferences(
      String username, String password) async {
    SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();
    _sharedPreferences.setString(SharedPreferencesConstants.USERNAME, username);
    _sharedPreferences.setString(SharedPreferencesConstants.PASSWORD, password);
    print("\n---- SETTED -----");
    print("SHARED PREFS USERNAME: $username");
    print("SHARED PREFS PASSWORD: $password");
    print("---- SETTED -----\n\n");
  }
}
