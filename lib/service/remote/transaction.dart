import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:money_manager_app/data/model/transaction.dart';
import 'package:money_manager_app/service/dio_client.dart';
import 'package:money_manager_app/service/exception/dio_response_handler.dart';
import 'package:money_manager_app/service/exception/http_exception.dart';
import 'package:money_manager_app/service/hive_service.dart';
import 'package:money_manager_app/utils/api.dart';
import 'package:uuid/uuid.dart';

class TransactionService {
  final Dio _dio = Dio(BaseOptions(baseUrl: APIURL.mainUrl));

  Future<List<Transaction>> getTransactions() async {
    final token = HiveCacheManager().getToken();
    if (token == null) throw Exception('Token not found');

    try {
      final response = await DioClient.dio.get(
        '${APIURL.mainUrl}/transaction-data-by-date',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Accept': 'application/json',
          },
        ),
        data: {'date': DateTime.now().toIso8601String().split('T').first},
      );

      final data = DioResponseHandler.handleResponse(response);
      final dynamic decodedData = data is String ? json.decode(data) : data;

      final transactions = mapToTransactions(decodedData);
      debugPrint("✅ Transactions: $transactions");   
      return transactions;
    } on DioException catch (e) {
      debugPrint('❌ Dio Exception: ${e.response}');
      throw HttpException('Failed to load transactins: ${e.response}');
    } catch (e) {
      debugPrint('❌ Unexpected error: $e');
      throw HttpException('Failed to load transactins: $e');
    }
  }

  // Future<List<Transaction>> getTransactions() async {
  //    final token = HiveCacheManager().getToken();
  //   if (token == null) throw Exception('Token not found');
  //   final response = await _dio.get(
  //     '/transactions',
  //     options: Options(
  //       headers: {
  //         'Authorization': 'Bearer $token',
  //         'Accept': 'application/json',
  //       },
  //     ),
  //   );

  //   final List<dynamic> data = response.data;

  //   return data.map((json) {
  //     // final typeString = json['type'] as String;
  //     // final type = TransactionType.values.firstWhere(
  //     //   (e) => e.toString().split('.').last == typeString,
  //     //   orElse: () => TransactionType.expense,
  //     // );

  //     return Transaction.fromJson(json);
  //   }).toList();
  // }

  Future<Transaction> getTransactionDetail(int id, String token) async {
    final response = await _dio.get(
      '/transactions/$id',
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      ),
    );

    final json = response.data;
    // final typeString = json['type'] as String;
    // final type = TransactionType.values.firstWhere(
    //   (e) => e.toString().split('.').last == typeString,
    //   orElse: () => TransactionType.expense,
    // );

    return Transaction.fromJson(json);
  }



  final _uuid = Uuid();

  List<Transaction> mapToTransactions(Map<String, dynamic> decodedData) {
    final dataObj = decodedData['data'];

    // incomes
    final incomes = (dataObj['incomes'] as List)
        .map((e) => Transaction(
              id: _uuid.v4(), // generate UUID
              category: e['provider']['name'], // e.g., KBZ
              amount: (e['amount'] as num).toDouble(),
              type: TransactionType.income,
              date: DateTime.parse(e['created_at']),
              description: e['description'],
            ))
        .toList();

    // expenses
    final expenses = (dataObj['expenses'] as List)
        .map((e) => Transaction(
              id: _uuid.v4(),
              category: e['category']['name'], // e.g., Food & Dining
              amount: (e['amount'] as num).toDouble(),
              type: TransactionType.expense,
              date: DateTime.parse(e['created_at']),
              description: e['description'],
            ))
        .toList();

    // merge & sort by date
    final allTransactions = [...incomes, ...expenses]
      ..sort((a, b) => a.date.compareTo(b.date));

    return allTransactions;
  }

}
