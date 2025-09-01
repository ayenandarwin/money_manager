import 'package:dio/dio.dart';
import 'package:money_manager_app/data/model/transactions.dart';
import 'package:money_manager_app/utils/api.dart';

class TransactionService {
  final Dio _dio = Dio(BaseOptions(baseUrl: APIURL.mainUrl));

  Future<List<TransactionModel>> getTransactions(String token) async {
    final response = await _dio.get(
      '/transactions',
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      ),
    );

    final List<dynamic> data = response.data;

    return data.map((json) {
      final typeString = json['type'] as String;
      final type = TransactionType.values.firstWhere(
        (e) => e.toString().split('.').last == typeString,
        orElse: () => TransactionType.expense,
      );

      return TransactionModel.fromJson(json, type);
    }).toList();
  }

  Future<TransactionModel> getTransactionDetail(int id, String token) async {
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
    final typeString = json['type'] as String;
    final type = TransactionType.values.firstWhere(
      (e) => e.toString().split('.').last == typeString,
      orElse: () => TransactionType.expense,
    );

    return TransactionModel.fromJson(json, type);
  }
}
