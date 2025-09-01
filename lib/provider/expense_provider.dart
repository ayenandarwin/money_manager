import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:money_manager_app/data/model/expense/expense.dart';
import 'package:money_manager_app/provider/service_provider.dart';

final expenseDataProvider = FutureProvider<Expense>((ref) async {
  final expenseDataRepository = ref.watch(expenseRepositoryProvider);
  return await expenseDataRepository.getExpenseData();
});

final postExpenseProvider = FutureProvider.family<Expense, Expense>((
  ref,
  expense,
) async {
  final expenseDataRepository = ref.watch(expenseRepositoryProvider);
  return await expenseDataRepository.postExpenseData(expense);
});

final updateExpenseDataProvider = FutureProvider.family<Expense, int>((
  ref,
  id,
) async {
  final expenseDataRepository = ref.watch(expenseRepositoryProvider);

  return await expenseDataRepository.updateExpenseData(id);
});

final deleteExpenseDataProvider = FutureProvider.family<Expense, int>((
  ref,
  id,
) async {
  final expenseDataRepository = ref.watch(expenseRepositoryProvider);
  return await expenseDataRepository.deleteExpenseData(id);
});

final detailExpenseDataProvider = FutureProvider.family<Expense, int>((
  ref,
  id,
) async {
  final expenseDataRepository = ref.watch(expenseRepositoryProvider);
  return await expenseDataRepository.detailExpenseData(id);
});
