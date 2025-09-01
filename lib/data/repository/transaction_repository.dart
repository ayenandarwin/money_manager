import 'package:money_manager_app/data/model/transaction.dart';
import 'package:money_manager_app/service/remote/transaction.dart';

class TransactionRepository {
  final TransactionService transactionService;
  TransactionRepository({required this.transactionService});

  Future<List<Transaction>> getTransactions() async {
    return await transactionService.getTransactions();
  }
}