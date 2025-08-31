// import 'dart:convert';
// import 'dart:io';
// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:money_manager_app/data/model/expense/expense.dart';
// import 'package:money_manager_app/service/dio_client.dart';
// import 'package:money_manager_app/service/exception/dio_response_handler.dart';
// import 'package:money_manager_app/service/hive_service.dart';
// import 'package:money_manager_app/utils/api.dart';

// class ExpenseService {
//   Future<Expense> getExpenseData() async {
//     final token =
//         HiveCacheManager()
//             .getToken(); // Ensure token is fetched from Hive if needed

//     if (token == null) {
//       throw Exception('Token not found');
//     }

//     try {
//       final response = await DioClient.dio.get(
//         '${APIURL.mainUrl}/expenses',
//         options: Options(
//           headers: {
//             'Authorization': 'Bearer $token', // Make sure token is valid
//             'Accept': 'application/json',
//           },
//         ),
//       );
//       final data = DioResponseHandler.handleResponse(response);
//       final dynamic decodedData = data is String ? json.decode(data) : data;
//       debugPrint("✅ Data: $decodedData");
//       return Expense.fromJson(decodedData);
//     } on DioException catch (e) {
//       debugPrint('Dio Exception: ********  ${e.response}');
//       throw HttpException('Failed to load expense: ${e.response}');
//     } catch (e) {
//       debugPrint('UnExpected error: ********  $e');
//       throw HttpException('Failed to load expense: $e');
//     }
//   }

//   Future<Expense> postExpenseData(Expense expense) async {
//     final token =
//         HiveCacheManager()
//             .getToken(); // Ensure token is fetched from Hive if needed

//     if (token == null) {
//       throw Exception('Token not found');
//     }

//     try {
//       final response = await DioClient.dio.post(
//         '${APIURL.mainUrl}/expenses',
//         data: expense.toJson(),
//         options: Options(
//           headers: {
//             'Authorization': 'Bearer $token', // Make sure token is valid
//             'Accept': 'application/json',
//             HttpHeaders.contentTypeHeader: 'application/json',
//           },
//         ),
//       );
//       final data = DioResponseHandler.handleResponse(response);
//       final dynamic decodedData = data is String ? json.decode(data) : data;
//       debugPrint("✅ Data: $decodedData");
//       return Expense.fromJson(decodedData);
//     } on DioException catch (e) {
//       debugPrint('Dio Exception: ********  ${e.response}');
//       throw HttpException('Failed to post expense: ${e.response}');
//     } catch (e) {
//       debugPrint('UnExpected error: ********  $e');
//       throw HttpException('Failed to post expense: $e');
//     }
//   }
// }

import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:money_manager_app/data/model/expense/expense.dart';
import 'package:money_manager_app/service/dio_client.dart';
import 'package:money_manager_app/service/exception/dio_response_handler.dart';
import 'package:money_manager_app/service/hive_service.dart';
import 'package:money_manager_app/utils/api.dart';
import '../exception/http_exception.dart';

class ExpenseService {
  /// ✅ Get token once
  Future<String> _getToken() async {
    final token = HiveCacheManager().getToken();
    if (token == null) throw Exception('Token not found');
    return token;
  }

  /// ✅ Centralized request handler
  Future<Expense> _handleRequest(
    Future<Response> Function(String token) request,
  ) async {
    final token = await _getToken();

    try {
      final response = await request(token);
      final data = DioResponseHandler.handleResponse(response);
      final dynamic decodedData = data is String ? json.decode(data) : data;

      debugPrint("✅ Expense Response: $decodedData");

      return Expense.fromJson(decodedData);
    } on DioException catch (e) {
      debugPrint('❌ Dio Exception: ${e.response}');
      throw HttpException('Failed to process expense: ${e.response}');
    } catch (e) {
      debugPrint('❌ Unexpected error: $e');
      throw HttpException('Failed to process expense: $e');
    }
  }

  /// ✅ GET all expenses
  Future<Expense> getExpenseData() {
    return _handleRequest((token) {
      return DioClient.dio.get(
        '${APIURL.mainUrl}/expenses',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Accept': 'application/json',
          },
        ),
      );
    });
  }

  /// ✅ POST (create) expense
  Future<Expense> postExpenseData(Expense expense) {
    return _handleRequest((token) {
      return DioClient.dio.post(
        '${APIURL.mainUrl}/expenses',
        data: expense.toJson(),
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Accept': 'application/json',
            HttpHeaders.contentTypeHeader: 'application/json',
          },
        ),
      );
    });
  }

  /// ✅ PUT (update) expense
  Future<Expense> updateExpenseData(int id) {
    return _handleRequest((token) {
      return DioClient.dio.put(
        '${APIURL.mainUrl}/expenses/:$id',
        data: id,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Accept': 'application/json',
            HttpHeaders.contentTypeHeader: 'application/json',
          },
        ),
      );
    });
  }

  /// ✅ DELETE expense
  Future<Expense> deleteExpenseData(int id) {
    return _handleRequest((token) {
      return DioClient.dio.delete(
        '${APIURL.mainUrl}/expenses/:$id',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Accept': 'application/json',
          },
        ),
      );
    });
  }

  /// ✅ GET detail of one expense
  Future<Expense> detailExpenseData(int id) {
    return _handleRequest((token) {
      return DioClient.dio.get(
        '${APIURL.mainUrl}/expenses/:$id',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Accept': 'application/json',
          },
        ),
      );
    });
  }
}
