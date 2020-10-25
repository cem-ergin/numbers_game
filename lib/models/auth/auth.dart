// To parse this JSON data, do
//
//     final auth = authFromJson(jsonString);

import 'dart:convert';

Auth authFromJson(String str) => Auth.fromJson(json.decode(str));

String authToJson(Auth data) => json.encode(data.toJson());

class Auth {
  Auth({
    this.status,
    this.token,
    this.data,
  });

  String status;
  String token;
  AuthData data;

  factory Auth.fromJson(Map<String, dynamic> json) => Auth(
        status: json["status"],
        token: json["token"],
        data: AuthData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "token": token,
        "data": data.toJson(),
      };
}

class AuthData {
  AuthData({
    this.id,
    this.fullname,
    this.username,
    this.password,
    this.imageUrl,
    this.point,
    this.gameCount,
  });

  int id;
  String fullname;
  String username;
  String password;
  String imageUrl;
  int point;
  int gameCount;

  factory AuthData.fromJson(Map<String, dynamic> json) => AuthData(
        id: json["id"],
        fullname: json["fullname"],
        username: json["username"],
        password: json["password"],
        imageUrl: json["imageUrl"],
        point: json["point"],
        gameCount: json["gameCount"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "fullname": fullname,
        "username": username,
        "password": password,
        "imageUrl": imageUrl,
        "point": point,
        "gameCount": gameCount,
      };
}
