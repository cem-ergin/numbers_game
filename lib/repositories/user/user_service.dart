import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:sayiciklar/constants/api_urls.dart';

// 4440490
class UserService {
  Future<bool> register(Map<String, dynamic> userData) async {
    print("register on: ${ApiUrls.CREATE_USER_URL}");
    print("data: ${jsonEncode(userData)}");
    final response = await http.post(
      ApiUrls.CREATE_USER_URL,
      headers: {
        HttpHeaders.contentTypeHeader: "application/json",
      },
      body: jsonEncode(userData),
    );
    print("response status code: ${response.statusCode}");
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
