import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:money_manager_app/data/model/getprovider/getprovider.dart';
import 'package:money_manager_app/service/dio_client.dart';
import 'package:money_manager_app/service/exception/dio_response_handler.dart';
import 'package:money_manager_app/service/hive_service.dart';
import 'package:money_manager_app/utils/api.dart';

class GetProviderService {
  Future<List<GetProvider>> getGetProviderData() async {
    final token = HiveCacheManager().getToken();
    if (token == null) throw Exception('Token not found');

    try {
      final response = await DioClient.dio.get(
        '${APIURL.mainUrl}/providers',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Accept': 'application/json',
          },
        ),
      );

      final data = DioResponseHandler.handleResponse(response);
      final dynamic decodedData = data is String ? json.decode(data) : data;

      debugPrint("✅ Categories: $decodedData");

      // ✅ Map JSON list to List<GetProvider>
      return (decodedData as List).map((e) => GetProvider.fromJson(e)).toList();
    } on DioException catch (e) {
      debugPrint('❌ Dio Exception: ${e.response}');
      throw HttpException('Failed to load categories: ${e.response}');
    } catch (e) {
      debugPrint('❌ Unexpected error: $e');
      throw HttpException('Failed to load categories: $e');
    }
  }
}
