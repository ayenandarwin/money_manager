// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:money_manager_app/data/model/income/income.dart';
// import 'dart:convert';
// import 'package:money_manager_app/service/dio_client.dart';
// import 'package:money_manager_app/service/exception/dio_response_handler.dart';
// import 'package:money_manager_app/service/hive_service.dart';
// import 'package:money_manager_app/utils/api.dart';
// import '../exception/http_exception.dart';

// class IncomeService {
//   Future<Income> getIncomeData() async {
//     final token =
//         HiveCacheManager()
//             .getToken(); // Ensure token is fetched from Hive if needed

//     if (token == null) {
//       throw Exception('Token not found');
//     }

//     try {
//       final response = await DioClient.dio.get(
//         '${APIURL.mainUrl}/incomes',
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

//       return Income.fromJson(decodedData);
//     } on DioException catch (e) {
//       debugPrint('Dio Exception: ********  ${e.response}');
//       throw HttpException('Failed to load income: ${e.response}');
//     } catch (e) {
//       debugPrint('UnExpected error: ********  $e');
//       throw HttpException('Failed to load income: $e');
//     }
//   }

//   Future<Income> postIncomeData(Income income) async {
//     final token =
//         HiveCacheManager()
//             .getToken(); // Ensure token is fetched from Hive if needed

//     if (token == null) {
//       throw Exception('Token not found');
//     }

//     try {
//       final response = await DioClient.dio.post(
//         '${APIURL.mainUrl}/incomes',
//         data: income.toJson(),
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

//       return Income.fromJson(decodedData);
//     } on DioException catch (e) {
//       debugPrint('Dio Exception: ********  ${e.response}');
//       throw HttpException('Failed to load income: ${e.response}');
//     } catch (e) {
//       debugPrint('UnExpected error: ********  $e');
//       throw HttpException('Failed to load income: $e');
//     }
//   }

//   Future<Income> updateSelectionIntent(int id) async {
//     final token =
//         HiveCacheManager()
//             .getToken(); // Ensure token is fetched from Hive if needed

//     if (token == null) {
//       throw Exception('Token not found');
//     }

//     try {
//       final response = await DioClient.dio.post(
//         '${APIURL.mainUrl}/incomes',
//         data: id,
//         options: Options(
//           headers: {
//             'Authorization': 'Bearer $token', // Make sure token is valid
//             'Accept': 'application/json',
//           },
//         ),
//       );

//       // ✅ Let handler check response validity
//       final data = DioResponseHandler.handleResponse(response);
//       // ✅ Ensure data is decoded correctly
//       final dynamic decodedData = data is String ? json.decode(data) : data;
//       debugPrint("✅ Data: $decodedData");

//       return Income.fromJson(decodedData);
//     } on DioException catch (e) {
//       debugPrint('Dio Exception: ********  ${e.response}');
//       throw HttpException('Failed to load income: ${e.response}');
//     } catch (e) {
//       debugPrint('UnExpected error: ********  $e');
//       throw HttpException('Failed to load income: $e');
//     }
//   }

//   Future<Income> deleteIncomeData(int id) async {
//     final token =
//         HiveCacheManager()
//             .getToken(); // Ensure token is fetched from Hive if needed

//     if (token == null) {
//       throw Exception('Token not found');
//     }

//     try {
//       final response = await DioClient.dio.post(
//         '${APIURL.mainUrl}/incomes',
//         data: id,
//         options: Options(
//           headers: {
//             'Authorization': 'Bearer $token', // Make sure token is valid
//             'Accept': 'application/json',
//           },
//         ),
//       );

//       // ✅ Let handler check response validity
//       final data = DioResponseHandler.handleResponse(response);
//       // ✅ Ensure data is decoded correctly
//       final dynamic decodedData = data is String ? json.decode(data) : data;
//       debugPrint("✅ Data: $decodedData");

//       return Income.fromJson(decodedData);
//     } on DioException catch (e) {
//       debugPrint('Dio Exception: ********  ${e.response}');
//       throw HttpException('Failed to load income: ${e.response}');
//     } catch (e) {
//       debugPrint('UnExpected error: ********  $e');
//       throw HttpException('Failed to load income: $e');
//     }
//   }

//   Future<Income> detailIncomeData(int id) async {
//     final token =
//         HiveCacheManager()
//             .getToken(); // Ensure token is fetched from Hive if needed

//     if (token == null) {
//       throw Exception('Token not found');
//     }

//     try {
//       final response = await DioClient.dio.post(
//         '${APIURL.mainUrl}/incomes',
//         data: id,
//         options: Options(
//           headers: {
//             'Authorization': 'Bearer $token', // Make sure token is valid
//             'Accept': 'application/json',
//           },
//         ),
//       );

//       // ✅ Let handler check response validity
//       final data = DioResponseHandler.handleResponse(response);
//       // ✅ Ensure data is decoded correctly
//       final dynamic decodedData = data is String ? json.decode(data) : data;
//       debugPrint("✅ Data: $decodedData");

//       return Income.fromJson(decodedData);
//     } on DioException catch (e) {
//       debugPrint('Dio Exception: ********  ${e.response}');
//       throw HttpException('Failed to load income: ${e.response}');
//     } catch (e) {
//       debugPrint('UnExpected error: ********  $e');
//       throw HttpException('Failed to load income: $e');
//     }
//   }
// }

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:money_manager_app/data/model/income/income.dart';
import 'dart:convert';
import 'package:money_manager_app/service/dio_client.dart';
import 'package:money_manager_app/service/exception/dio_response_handler.dart';
import 'package:money_manager_app/service/hive_service.dart';
import 'package:money_manager_app/utils/api.dart';
import '../exception/http_exception.dart';

class IncomeService {
  /// ✅ Common helper to get token
  Future<String> _getToken() async {
    final token = HiveCacheManager().getToken();
    if (token == null) throw Exception('Token not found');
    return token;
  }

  /// ✅ Common helper to handle Dio requests
  Future<Income> _handleRequest(
    Future<Response> Function(String token) request,
  ) async {
    final token = await _getToken();

    try {
      final response = await request(token);

      final data = DioResponseHandler.handleResponse(response);
      final dynamic decodedData = data is String ? json.decode(data) : data;

      debugPrint("✅ Data: $decodedData");

      return Income.fromJson(decodedData);
    } on DioException catch (e) {
      debugPrint('❌ Dio Exception: ${e.response}');
      throw HttpException('Failed to load income: ${e.response}');
    } catch (e) {
      debugPrint('❌ Unexpected error: $e');
      throw HttpException('Failed to load income: $e');
    }
  }

  /// ✅ GET all incomes
  Future<Income> getIncomeData() {
    return _handleRequest((token) {
      return DioClient.dio.get(
        '${APIURL.mainUrl}/incomes',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Accept': 'application/json',
          },
        ),
      );
    });
  }

  /// ✅ POST income
  Future<Income> postIncomeData(Income income) {
    return _handleRequest((token) {
      return DioClient.dio.post(
        '${APIURL.mainUrl}/incomes',
        data: income.toJson(),
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Accept': 'application/json',
          },
        ),
      );
    });
  }

  /// ✅ Update selection intent
  Future<Income> updateIncomeData(int id) {
    return _handleRequest((token) {
      return DioClient.dio.post(
        '${APIURL.mainUrl}/incomes/:$id',
        data: {"id": id},
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Accept': 'application/json',
          },
        ),
      );
    });
  }

  /// ✅ Delete income
  Future<Income> deleteIncomeData(int id) {
    return _handleRequest((token) {
      return DioClient.dio.delete(
        '${APIURL.mainUrl}/incomes/:$id',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Accept': 'application/json',
          },
        ),
      );
    });
  }

  /// ✅ Detail income
  Future<Income> detailIncomeData(int id) {
    return _handleRequest((token) {
      return DioClient.dio.get(
        '${APIURL.mainUrl}/incomes/:$id',
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
