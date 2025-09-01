import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:money_manager_app/data/repository/category_repository.dart';
import 'package:money_manager_app/data/repository/dashboard_repository.dart';
import 'package:money_manager_app/data/repository/expense_repository.dart';
import 'package:money_manager_app/data/repository/getprovier_repository.dart';
import 'package:money_manager_app/data/repository/income_repository.dart';
import 'package:money_manager_app/data/repository/transaction_repository.dart';
import 'package:money_manager_app/data/repository/user_repository.dart';
import 'package:money_manager_app/service/remote/category.dart';
import 'package:money_manager_app/service/remote/dashboard.dart';
import 'package:money_manager_app/service/remote/expense.dart';
import 'package:money_manager_app/service/remote/getprovider.dart';
import 'package:money_manager_app/service/remote/income.dart';
import 'package:money_manager_app/service/remote/transaction.dart';
import 'package:money_manager_app/service/remote/user.dart';

final userServiceProvider = Provider((ref) => UserService());
final userRepositoryProvider = Provider((ref) {
  final userService = ref.watch(userServiceProvider);
  return UserRepository(userService: userService);
});

final dashboardServiceProvider = Provider((ref) => DashboardService());
final dashboardRepositoryProvider = Provider((ref) {
  final dashboardService = ref.watch(dashboardServiceProvider);
  return DashboardRepository(dashboardService: dashboardService);
});

final incomeServiceProvider = Provider((ref) => IncomeService());
final incomeRepositoryProvider = Provider((ref) {
  final incomeService = ref.watch(incomeServiceProvider);
  return IncomeRepository(incomeService: incomeService);
});

final expenseServiceProvider = Provider((ref) => ExpenseService());
final expenseRepositoryProvider = Provider((ref) {
  final expenseService = ref.watch(expenseServiceProvider);
  return ExpenseRepository(expenseService: expenseService);
});

final categoryServiceProvider = Provider((ref) => CategoryService());
final categoryRepositoryProvider = Provider((ref) {
  final categoryService = ref.watch(categoryServiceProvider);
  return CategoryRepository(categoryService: categoryService);
});

final getProviderServiceProvider = Provider((ref) => GetProviderService());
final getProviderRepositoryProvider = Provider((ref) {
  final getProviderService = ref.watch(getProviderServiceProvider);
  return GetProviderRepository(getProviderService: getProviderService);
});

final transactionServiceProvider = Provider((ref) => TransactionService());
final transactionRepositoryProvider = Provider((ref) {
  final transactionService = ref.watch(transactionServiceProvider);
  return TransactionRepository(transactionService: transactionService);
});
