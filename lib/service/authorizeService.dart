import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:money_manager_app/service/exception/http_exception.dart';
import 'package:money_manager_app/utils/api.dart';

final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService(Dio());
});

class AuthService {
  AuthService(this._dio);

  final Dio _dio;

  Future<dynamic> login({
    required String email,
    required String password,
  }) async {
    try {
      var encodeJson = json.encode({'email': email, 'password': password});
      debugPrint(encodeJson);
      var response = await http.post(
        Uri.parse(APIURL.loginUrl),
        body: encodeJson,
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
        },
      );
      var userData = jsonDecode(response.body);

      debugPrint('Response ************** $userData');
      return userData;
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
  }
}
