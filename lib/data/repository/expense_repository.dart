import 'package:money_manager_app/data/model/expense/expense.dart';
import 'package:money_manager_app/service/remote/expense.dart';

class ExpenseRepository {
  final ExpenseService expenseService;
  ExpenseRepository({required this.expenseService});
  Future<Expense> getExpenseData() async {
    return await expenseService.getExpenseData();
  }

  Future<Expense> postExpenseData(Expense expense) async {
    return await expenseService.postExpenseData(expense);
  }

  Future<Expense> updateExpenseData(int id) async {
    return await expenseService.updateExpenseData(id);
  }

  Future<Expense> deleteExpenseData(int id) async {
    return await expenseService.deleteExpenseData(id);
  }

  Future<Expense> detailExpenseData(int id) async {
    return await expenseService.detailExpenseData(id);
  }
}
