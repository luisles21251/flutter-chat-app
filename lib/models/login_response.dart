// To parse this JSON data, do
//
//     final loginRespose = loginResposeFromJson(jsonString);

import 'dart:convert';

import 'package:flutter_02_chat/models/user.dart';

LoginRespose loginResponseFromJson(String str) => LoginRespose.fromJson(json.decode(str));

String loginResponseToJson(LoginRespose data) => json.encode(data.toJson());

class LoginRespose {
    LoginRespose({
        this.ok,
        this.user,
        this.token,
    });

    bool? ok;
    User? user;
    String? token;

    factory LoginRespose.fromJson(Map<String, dynamic> json) => LoginRespose(
        ok: json["ok"],
        user: User.fromJson(json["user"]),
        token: json["token"],
    );

    Map<String, dynamic> toJson() => {
        "ok": ok,
        "user": user?.toJson(),
        "token": token,
    };
}


