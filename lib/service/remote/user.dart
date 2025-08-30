import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:money_manager_app/model/user.dart';
import 'package:money_manager_app/service/dio_client.dart';
import 'package:money_manager_app/service/exception/dio_response_handler.dart';
import 'package:money_manager_app/service/hive_service.dart';
import 'package:money_manager_app/utils/api.dart';
import '../exception/http_exception.dart';

class UserService {
  Future<UserModel> fetchUserData() async {
    final token =
        HiveCacheManager()
            .getToken(); // Ensure token is fetched from Hive if needed

    if (token == null) {
      throw Exception('Token not found');
    }

    try {
      final response = await DioClient.dio.get(
        APIURL.mainUrl,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token', // Make sure token is valid
            'Accept': 'application/json',
          },
        ),
      );

      // ✅ Let handler check response validity
      final data = DioResponseHandler.handleResponse(response);
      // ✅ Ensure data is decoded correctly
      final dynamic decodedData = data is String ? json.decode(data) : data;
      debugPrint("✅ Data: $decodedData");

      return UserModel.fromJson(decodedData);
    } on DioException catch (e) {
      debugPrint('Dio Exception: ********  ${e.response}');
      throw HttpException('Failed to load user profile: ${e.response}');
    } catch (e) {
      debugPrint('UnExpected error: ********  $e');
      throw HttpException('Failed to load user profile: $e');
    }
  }
}
