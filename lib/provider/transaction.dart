// Provider for managing the list of transactions
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:money_manager_app/data/model/transactions.dart';

final transactionsProvider =
    StateNotifierProvider<TransactionsNotifier, List<Transaction>>((ref) {
      return TransactionsNotifier();
    });

class TransactionsNotifier extends StateNotifier<List<Transaction>> {
  TransactionsNotifier()
    : super(_initialTransactions); // Initialize with dummy data

  // Dummy data for demonstration
  static final List<Transaction> _initialTransactions = [
    Transaction(
      id: 't1',
      category: 'Lottery',
      amount: 15000,
      type: TransactionType.expense,
      date: DateTime(2025, 7, 16),
    ),
    Transaction(
      id: 't2',
      category: 'Donations',
      amount: 60000,
      type: TransactionType.expense,
      date: DateTime(2025, 7, 16),
    ),
    Transaction(
      id: 't3',
      category: 'Lottery',
      amount: 10000,
      type: TransactionType.income,
      date: DateTime(2025, 7, 16),
    ),
    Transaction(
      id: 't4',
      category: 'Burger',
      amount: 8000,
      type: TransactionType.expense,
      date: DateTime(2025, 7, 16),
    ),
    Transaction(
      id: 't5',
      category: 'Beauty',
      amount: 50000,
      type: TransactionType.expense,
      date: DateTime(2025, 7, 15),
    ),
    Transaction(
      id: 't6',
      category: 'Part-Time',
      amount: 20000,
      type: TransactionType.income,
      date: DateTime(2025, 7, 15),
    ),
    Transaction(
      id: 't7',
      category: 'Salary',
      amount: 700000,
      type: TransactionType.income,
      date: DateTime(2025, 7, 15),
    ),
    Transaction(
      id: 't8',
      category: 'Shopping',
      amount: 100000,
      type: TransactionType.expense,
      date: DateTime(2025, 7, 15),
    ),
    Transaction(
      id: 't9',
      category: 'Food',
      amount: 200000,
      type: TransactionType.expense,
      date: DateTime(2025, 7, 15),
    ),
    // Add some data for May 2025 for chart view
    Transaction(
      id: 't10',
      category: 'Food',
      amount: 48030,
      type: TransactionType.expense,
      date: DateTime(2025, 5, 10),
    ),
    Transaction(
      id: 't11',
      category: 'Shopping',
      amount: 23090,
      type: TransactionType.expense,
      date: DateTime(2025, 5, 12),
    ),
    Transaction(
      id: 't12',
      category: 'Donations',
      amount: 13850,
      type: TransactionType.expense,
      date: DateTime(2025, 5, 15),
    ),
    Transaction(
      id: 't13',
      category: 'Beauty',
      amount: 11540,
      type: TransactionType.expense,
      date: DateTime(2025, 5, 18),
    ),
    Transaction(
      id: 't14',
      category: 'Lottery',
      amount: 3460,
      type: TransactionType.expense,
      date: DateTime(2025, 5, 20),
    ),
    Transaction(
      id: 't15',
      category: 'Salary',
      amount: 700000,
      type: TransactionType.income,
      date: DateTime(2025, 5, 25),
    ),
    Transaction(
      id: 't16',
      category: 'Part-Time',
      amount: 30000,
      type: TransactionType.income,
      date: DateTime(2025, 5, 28),
    ),
  ];

  void addTransaction(Transaction transaction) {
    state = [...state, transaction];
  }

  void removeTransaction(String id) {
    state = state.where((t) => t.id != id).toList();
  }

  // In a real app, you would fetch/save from/to Firestore here
  // Future<void> fetchTransactions() async { ... }
  // Future<void> saveTransaction(Transaction transaction) async { ... }
}