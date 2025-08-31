import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:money_manager_app/utils/api.dart';

class DioClient {
  static final Dio dio =
      Dio(
          BaseOptions(
            baseUrl: APIURL.loginUrl,
            connectTimeout: const Duration(seconds: 10),
            receiveTimeout: const Duration(seconds: 10),
            headers: {'Accept': 'application/json'},
          ),
        )
        ..interceptors.add(
          InterceptorsWrapper(
            onRequest: (options, handler) {
              // Add headers like Authorization
              // options.headers['Authorization'] = 'Bearer your_access_token';
              debugPrint('--> ${options.method} ${options.uri}');
              return handler.next(options); // continue
            },
            onResponse: (response, handler) {
              debugPrint(
                '<-- ${response.statusCode} ${response.requestOptions.uri}',
              );
              return handler.next(response); // continue
            },
            onError: (DioException e, handler) {
              debugPrint('❌ Error: ${e.message}');
              return handler.next(e); // continue
            },
          ),
        )
        ..interceptors.add(
          LogInterceptor(
            request: true,
            requestHeader: true,
            requestBody: true,
            responseBody: true,
            responseHeader: false,
            error: true,
          ),
        );
}
