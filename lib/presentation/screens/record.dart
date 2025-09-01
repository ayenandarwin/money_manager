import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:money_manager_app/data/model/transaction.dart';
import 'package:money_manager_app/model/dashboard.dart';
import 'package:money_manager_app/provider/dashboard_provider.dart';
import 'package:money_manager_app/provider/transaction.dart';

class RecordsScreen extends ConsumerStatefulWidget {
  const RecordsScreen({super.key});

  @override
  ConsumerState<RecordsScreen> createState() => _RecordsScreenState();
}

class _RecordsScreenState extends ConsumerState<RecordsScreen> {
  DateTime selectedDate = DateTime.now();

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null && picked != selectedDate) {
      setState(() => selectedDate = picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    //final transactions = ref.watch(transactionsProvider);
    final formattedDate = DateFormat('MMM d').format(selectedDate);
    final dashboardAsync = ref.watch(dashboardDataProvider);

    // Group transactions by date
    final Map<DateTime, List<Transaction>> groupedTransactions = {};
    // for (var t in transactions) {
    //   final date = DateTime(t.date.year, t.date.month, t.date.day);
    //   groupedTransactions.putIfAbsent(date, () => []).add(t);
    // }


    final transactionsAsync = ref.watch(transactionDataProvider);
    transactionsAsync.when(
      data: (transactions) {
        final Map<DateTime, List<Transaction>> groupedTransactions = {};
        for (var t in transactions) {
          final date = DateTime(t.date.year, t.date.month, t.date.day);
          groupedTransactions.putIfAbsent(date, () => []).add(t);
        }

        // now you can use groupedTransactions safely
      },
      loading: () => CircularProgressIndicator(),
      error: (err, stack) => Text('Error: $err'),
    );


    final sortedDates =
        groupedTransactions.keys.toList()..sort((a, b) => b.compareTo(a));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Money Tracker'),
        leading: IconButton(icon: const Icon(Icons.menu), onPressed: () {}),
        centerTitle: true,
        actions: [
          IconButton(icon: const Icon(Icons.search), onPressed: () {}),
          // IconButton(
          //   icon: const Icon(Icons.calendar_today),
          //   onPressed: _pickDate,
          // ),
        ],
      ),
      body: dashboardAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('Error: $error')),
        data: (dashboard) {
          final summary = dashboard.summary;
          final weekly = dashboard.weeklyChart;

          return Column(
            children: [
              transactionsAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, _) => Center(child: Text('Error: $err')),
      data: (transactions) {
        final formattedDate = DateFormat.yMMMd().format(DateTime.now());

        return Column(
          children: [
            _buildSummaryHeader(
              context,
              ref,
              transactions,
              formattedDate,
              summary,
            ),
          ],
        );
      },
    ),
          
              Expanded(
  child: transactionsAsync.when(
    data: (transactions) {
      final Map<DateTime, List<Transaction>> groupedTransactions = {};
      for (var t in transactions) {
        final date = DateTime(t.date.year, t.date.month, t.date.day);
        groupedTransactions.putIfAbsent(date, () => []).add(t);
      }

      final sortedDates = groupedTransactions.keys.toList()
        ..sort((a, b) => b.compareTo(a));

      return ListView.builder(
        itemCount: sortedDates.length,
        itemBuilder: (context, index) {
          final date = sortedDates[index];
          final dailyTransactions = groupedTransactions[date]!;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Date header
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Text(
                  DateFormat('MMM d, yyyy').format(date),
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Colors.grey.shade500,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),

              // Transactions
              ...dailyTransactions.map(
                (t) => _buildTransactionTile(context, t, ref),
              ),
            ],
          );
        },
      );
    },
    loading: () => const Center(child: CircularProgressIndicator()),
    error: (err, stack) => Center(child: Text('Error: $err')),
  ),
),

              _buildSendAgainAvatars(),
            ],
          );
        },
      ),
    );
  }

  Widget _buildSummaryHeader(
    BuildContext context,
    WidgetRef ref,
    List<Transaction> transactions,
    String formattedDate,
    Summary summary,
  ) {
    final currentMonth = selectedDate.month;
    final currentYear = selectedDate.year;

    final monthlyTransactions =
        transactions
            .where(
              (t) => t.date.month == currentMonth && t.date.year == currentYear,
            )
            .toList();

    final totalExpenses = monthlyTransactions
        .where((t) => t.type == TransactionType.expense)
        .fold(0.0, (sum, t) => sum + t.amount);
    final totalIncome = monthlyTransactions
        .where((t) => t.type == TransactionType.income)
        .fold(0.0, (sum, t) => sum + t.amount);
    final balance = totalIncome - totalExpenses;

    return Container(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16, top: 16),
      // color: Theme.of(context).appBarTheme.backgroundColor,
      child: Column(
        children: [
          GestureDetector(
            onTap: _pickDate,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  formattedDate,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Icon(Icons.keyboard_arrow_down, color: Colors.black),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 10),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xFF116D6E),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      'Total Balance',
                      style: Theme.of(
                        context,
                      ).textTheme.bodyLarge!.copyWith(color: Colors.white),
                    ),
                    const Spacer(),
                    Icon(
                      Icons.more_horiz,
                      color: Colors.white.withOpacity(0.8),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  NumberFormat.currency(symbol: '', decimalDigits: 0).format(
                    // balance
                    summary.totalBalance,
                  ),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildStatBlock(
                      Icons.arrow_downward,
                      "Expenses",
                      summary.totalExpense,
                      // totalExpenses,
                      Colors.redAccent,
                    ),
                    _buildStatBlock(
                      Icons.arrow_upward,
                      "Income",
                      summary.totalIncome,
                      //totalIncome,
                      Colors.greenAccent,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatBlock(
    IconData icon,
    String label,
    // double amount,
    int amount,
    Color color,
  ) {
    return Row(
      children: [
        Icon(icon, color: color),
        const SizedBox(width: 5),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: TextStyle(color: Colors.white, fontSize: 12)),
            Text(
              NumberFormat.currency(
                symbol: '',
                decimalDigits: 0,
              ).format(amount),
              style: const TextStyle(
                fontSize: 14,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTransactionTile(
    BuildContext context,
    Transaction transaction,
    WidgetRef ref,
  ) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor:
            transaction.type == TransactionType.expense
                ? Colors.red.shade100
                : Colors.green.shade100,
        child: Icon(
          _getCategoryIcon(transaction.category),
          color:
              transaction.type == TransactionType.expense
                  ? Colors.redAccent
                  : Colors.greenAccent,
        ),
      ),
      title: Text(
        transaction.category,
        style: Theme.of(
          context,
        ).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        transaction.description ??
            DateFormat('dd MMM').format(transaction.date),
        style: Theme.of(
          context,
        ).textTheme.bodyMedium!.copyWith(color: Colors.grey.shade400),
      ),
      trailing: Text(
        '${transaction.type == TransactionType.expense ? '-' : '+'}${NumberFormat.currency(symbol: '', decimalDigits: 0).format(transaction.amount)}',
        style: Theme.of(context).textTheme.titleMedium!.copyWith(
          color:
              transaction.type == TransactionType.expense
                  ? Colors.redAccent
                  : Colors.greenAccent,
          fontWeight: FontWeight.bold,
        ),
      ),
      onLongPress: () {
        showDialog(
          context: context,
          builder:
              (ctx) => AlertDialog(
                title: const Text('Delete Transaction?'),
                content: Text(
                  'Are you sure you want to delete ${transaction.category} transaction of ${transaction.amount}?',
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(ctx).pop(),
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () {
                      ref
                          .read(transactionsProvider.notifier)
                          .removeTransaction(transaction.id);
                      Navigator.of(ctx).pop();
                    },
                    child: const Text(
                      'Delete',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ],
              ),
        );
      },
    );
  }

  IconData _getCategoryIcon(String category) {
    switch (category.toLowerCase()) {
      case 'food':
        return Icons.fastfood;
      case 'shopping':
        return Icons.shopping_bag;
      case 'donations':
        return Icons.favorite;
      case 'salary':
        return Icons.account_balance_wallet;
      case 'travel':
        return Icons.flight;
      case 'education':
        return Icons.school;
      case 'entertainment':
        return Icons.movie;
      default:
        return Icons.category;
    }
  }

  Widget _buildSendAgainAvatars() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                "Send Again",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              Text('see all', style: TextStyle(color: Colors.black54)),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: List.generate(
              5,
              (index) => const Padding(
                padding: EdgeInsets.only(right: 12),
                child: CircleAvatar(
                  radius: 26.5,
                  backgroundImage: AssetImage('assets/images/rose.jpg'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// final dashboardProviders = FutureProvider<DashboardData>((ref) async {
//   return await DashboardService.fetchDashboardData();
// });

class RecordsScreens extends ConsumerWidget {
  const RecordsScreens({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dashboardAsync = ref.watch(dashboardDataProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Money Dashboard'),
        centerTitle: true,
        backgroundColor: Colors.teal.shade700,
      ),
      body: dashboardAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('Error: $error')),
        data: (dashboard) {
          final summary = dashboard.summary;
          final weekly = dashboard.weeklyChart;

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _buildSummaryCard(summary),
                  const SizedBox(height: 20),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      weekly.period,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  ListView.builder(
                    itemCount: weekly.data.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final entry = weekly.data[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        child: ListTile(
                          title: Text(entry.date),
                          subtitle: Text(
                            'Income: ${entry.income} | Expense: ${entry.expense}',
                          ),
                          trailing: Text(
                            'Balance: ${entry.balance}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.teal,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSummaryCard(Summary summary) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.teal.shade700,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Text(
            'Total Balance',
            style: const TextStyle(color: Colors.white, fontSize: 18),
          ),
          const SizedBox(height: 8),
          Text(
            NumberFormat.currency(
              symbol: '',
              decimalDigits: 0,
            ).format(summary.totalBalance),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStatTile('Income', summary.totalIncome, Colors.green),
              _buildStatTile('Expense', summary.totalExpense, Colors.red),
              // _buildStatTile('Users', summary.totalUsers, Colors.orange),
            ],
          ),
        ],
      ),
    );
  }

  //double to int
  Widget _buildStatTile(String label, int value, Color color) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(color: color, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 4),
        Text(
          value.toString(),
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}
