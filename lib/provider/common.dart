// Provider for managing the currently selected bottom navigation index
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:money_manager_app/data/model/transactions.dart';

final bottomNavIndexProvider = StateProvider<int>((ref) => 0);

// Provider for managing the selected month/year for charts
final selectedChartDateProvider = StateProvider<DateTime>(
  (ref) => DateTime.now(),
);

// Provider for managing the chart type (Expense/Income for charts)
final chartTypeProvider = StateProvider<TransactionType>(
  (ref) => TransactionType.expense,
);

// New Providers for AddTransactionScreen
final addTransactionTypeProvider = StateProvider<TransactionType>(
  (ref) => TransactionType.expense,
);
final currentAmountInputProvider = StateProvider<String>((ref) => '0');
final selectedCategoryProvider = StateProvider<String?>((ref) => null);
final transactionNoteProvider = StateProvider<String>((ref) => '');
final transactionDateProvider = StateProvider<DateTime>(
  (ref) => DateTime.now(),
);