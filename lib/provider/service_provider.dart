import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:money_manager_app/data/repository/dashboard_repository.dart';
import 'package:money_manager_app/data/repository/income_repository.dart';
import 'package:money_manager_app/data/repository/user_repository.dart';
import 'package:money_manager_app/service/remote/dashboard.dart';
import 'package:money_manager_app/service/remote/income.dart';
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