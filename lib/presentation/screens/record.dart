// // -----------------------------------------------------------------------------
// // 5. Records Screen
// // -----------------------------------------------------------------------------

// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:intl/intl.dart';
// import 'package:money_manager_app/data/model/transactions.dart';
// import 'package:money_manager_app/provider/transaction.dart';

// class RecordsScreen extends ConsumerWidget {
//   const RecordsScreen({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final transactions = ref.watch(transactionsProvider);
//     DateTime selectedDate = DateTime.now();

//     final formattedDate = DateFormat('MMM d').format(selectedDate);

//     Future<void> _pickDate() async {
//       final picked = await showDatePicker(
//         context: context,
//         initialDate: selectedDate,
//         firstDate: DateTime.now(),
//         lastDate: DateTime.now().add(const Duration(days: 30)),
//       );

//       if (picked != null && picked != selectedDate) {
//         setState(() => selectedDate = picked);
//       }
//     }

//     // Group transactions by date
//     final Map<DateTime, List<Transaction>> groupedTransactions = {};
//     for (var t in transactions) {
//       final date = DateTime(
//         t.date.year,
//         t.date.month,
//         t.date.day,
//       ); // Normalize date to remove time
//       groupedTransactions.putIfAbsent(date, () => []).add(t);
//     }

//     // Sort dates in descending order
//     final sortedDates =
//         groupedTransactions.keys.toList()..sort((a, b) => b.compareTo(a));

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Money Tracker'),
//         leading: IconButton(
//           icon: const Icon(Icons.menu),
//           onPressed: () {
//             // Handle drawer or menu
//           },
//         ),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.search),
//             onPressed: () {
//               // Handle search
//             },
//           ),
//           IconButton(
//             icon: const Icon(Icons.calendar_today),
//             onPressed: () {
//               // Handle calendar view
//             },
//           ),
//         ],
//       ),
//       body: Column(
//         children: [
//           // Header with current month, expenses, income, balance
//           _buildSummaryHeader(context, ref, transactions),
//           Expanded(
//             child: ListView.builder(
//               itemCount: sortedDates.length,
//               itemBuilder: (context, index) {
//                 final date = sortedDates[index];
//                 final dailyTransactions = groupedTransactions[date]!;

//                 // Calculate daily expenses and income
//                 final dailyExpenses = dailyTransactions
//                     .where((t) => t.type == TransactionType.expense)
//                     .fold(0.0, (sum, t) => sum + t.amount);
//                 final dailyIncome = dailyTransactions
//                     .where((t) => t.type == TransactionType.income)
//                     .fold(0.0, (sum, t) => sum + t.amount);

//                 return Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.symmetric(
//                         horizontal: 16.0,
//                         vertical: 8.0,
//                       ),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             DateFormat('MMM dd, yyyy EEEE').format(date),
//                             style: Theme.of(
//                               context,
//                             ).textTheme.bodyMedium!.copyWith(
//                               color: Colors.grey.shade500,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           Text(
//                             'Expenses: ${NumberFormat.currency(symbol: '', decimalDigits: 0).format(dailyExpenses)} Income: ${NumberFormat.currency(symbol: '', decimalDigits: 0).format(dailyIncome)}',
//                             style: Theme.of(context).textTheme.bodySmall!
//                                 .copyWith(color: Colors.grey.shade500),
//                           ),
//                         ],
//                       ),
//                     ),
//                     ...dailyTransactions.map((transaction) {
//                       return _buildTransactionTile(context, transaction, ref);
//                     }).toList(),
//                     // const Divider(height: 1), // Separator between days
//                   ],
//                 );
//               },
//             ),
//           ),
//           _buildSendAgainAvatars(),
//         ],
//       ),
//     );
//   }

//   Widget _buildSummaryHeader(
//     BuildContext context,
//     WidgetRef ref,
//     List<Transaction> transactions,
//   ) {
//     final currentMonth = DateTime.now().month;
//     final currentYear = DateTime.now().year;

//     final monthlyTransactions =
//         transactions
//             .where(
//               (t) => t.date.month == currentMonth && t.date.year == currentYear,
//             )
//             .toList();

//     final totalExpenses = monthlyTransactions
//         .where((t) => t.type == TransactionType.expense)
//         .fold(0.0, (sum, t) => sum + t.amount);
//     final totalIncome = monthlyTransactions
//         .where((t) => t.type == TransactionType.income)
//         .fold(0.0, (sum, t) => sum + t.amount);
//     final balance = totalIncome - totalExpenses;

//     return Container(
//       padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
//       color:
//           Theme.of(
//             context,
//           ).appBarTheme.backgroundColor, // Use app bar background
//       child: Column(
//         children: [
//           GestureDetector(
//             onTap: _pickDate,
//             child: Row(
//               children: [
//                 Text(
//                   formattedDate,
//                   style: TextStyle(
//                     color: Constants.whiteblue,
//                     fontSize: 16,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 Icon(Icons.keyboard_arrow_down, color: Constants.whiteblue),
//               ],
//             ),
//           ),
//           // DropdownButton<String>(
//           //   value: DateFormat('MMM yyyy').format(DateTime.now()),
//           //   dropdownColor: Theme.of(context).cardTheme.color,
//           //   style: Theme.of(
//           //     context,
//           //   ).textTheme.titleLarge!.copyWith(color: Colors.black, fontSize: 16),
//           //   icon: const Icon(Icons.arrow_drop_down, color: Colors.black),
//           //   onChanged: (String? newValue) {
//           //     // Handle month change
//           //   },
//           //   items:
//           //       <String>[
//           //         DateFormat('MMM yyyy').format(DateTime.now()),
//           //         'Jul 2024',
//           //         'Jun 2024',
//           //       ] // Dummy months
//           //       .map<DropdownMenuItem<String>>((String value) {
//           //         return DropdownMenuItem<String>(
//           //           value: value,
//           //           child: Text(value),
//           //         );
//           //       }).toList(),
//           // ),
//           Container(
//             padding: const EdgeInsets.all(20),
//             decoration: BoxDecoration(
//               color: const Color(0xFF116D6E),
//               borderRadius: BorderRadius.circular(20),
//             ),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Row(
//                   crossAxisAlignment: CrossAxisAlignment.end,
//                   children: [
//                     Text(
//                       'Total Balance',
//                       style: Theme.of(
//                         context,
//                       ).textTheme.bodyLarge!.copyWith(color: Colors.white),
//                     ),
//                     const Spacer(),
//                     Icon(
//                       Icons.more_horiz,
//                       color: Colors.white.withOpacity(0.8),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 8),
//                 Text(
//                   NumberFormat.currency(
//                     symbol: '',
//                     decimalDigits: 0,
//                   ).format(balance),
//                   style: const TextStyle(
//                     color: Colors.white,
//                     fontSize: 28,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 SizedBox(height: 16),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: [
//                     Row(
//                       children: [
//                         Icon(Icons.arrow_downward, color: Colors.redAccent),
//                         const SizedBox(width: 5),
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.end,
//                           children: [
//                             Text(
//                               'Expenses',
//                               style: Theme.of(context).textTheme.bodyMedium!
//                                   .copyWith(color: Colors.white),
//                             ),
//                             Text(
//                               NumberFormat.currency(
//                                 symbol: '',
//                                 decimalDigits: 0,
//                               ).format(totalExpenses),
//                               style: Theme.of(context).textTheme.titleMedium!
//                                   .copyWith(color: Colors.white),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                     const SizedBox(width: 16),
//                     Row(
//                       children: [
//                         Icon(Icons.arrow_upward, color: Colors.greenAccent),
//                         const SizedBox(width: 5),
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.end,
//                           children: [
//                             Text(
//                               'Income',
//                               style: Theme.of(context).textTheme.bodyMedium!
//                                   .copyWith(color: Colors.white),
//                             ),
//                             Text(
//                               NumberFormat.currency(
//                                 symbol: '',
//                                 decimalDigits: 0,
//                               ).format(totalIncome),
//                               style: Theme.of(context).textTheme.titleMedium!
//                                   .copyWith(color: Colors.white),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//           // const SizedBox(height: 10),
//           // Alert message
//           // Card(
//           //   color: Colors.red.shade900.withOpacity(0.3),
//           //   shape: RoundedRectangleBorder(
//           //     borderRadius: BorderRadius.circular(8),
//           //   ),
//           //   child: Padding(
//           //     padding: const EdgeInsets.all(8.0),
//           //     child: Row(
//           //       children: [
//           //         Icon(
//           //           Icons.info_outline,
//           //           color: Colors.red.shade300,
//           //           size: 20,
//           //         ),
//           //         const SizedBox(width: 8),
//           //         Expanded(
//           //           child: Text(
//           //             'After logging in, you can back up your data in real time!',
//           //             style: Theme.of(context).textTheme.bodySmall!.copyWith(
//           //               color: Colors.red.shade200,
//           //             ),
//           //           ),
//           //         ),
//           //       ],
//           //     ),
//           //   ),
//           // ),
//         ],
//       ),
//     );
//   }

//   Widget _buildTransactionTile(
//     BuildContext context,
//     Transaction transaction,
//     WidgetRef ref,
//   ) {
//     return Card(
//       elevation: 0,
//       margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
//       child: ListTile(
//         leading: CircleAvatar(
//           backgroundColor:
//               transaction.type == TransactionType.expense
//                   ? Colors.red.shade700.withOpacity(0.2)
//                   : Colors.green.shade700.withOpacity(0.2),
//           child: Icon(
//             _getCategoryIcon(transaction.category),
//             color:
//                 transaction.type == TransactionType.expense
//                     ? Colors.redAccent
//                     : Colors.greenAccent,
//           ),
//         ),
//         title: Text(
//           transaction.category,
//           style: Theme.of(
//             context,
//           ).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),
//         ),
//         subtitle: Text(
//           transaction.description ??
//               DateFormat('dd MMM').format(transaction.date),
//           style: Theme.of(
//             context,
//           ).textTheme.bodyMedium!.copyWith(color: Colors.grey.shade400),
//         ),
//         trailing: Text(
//           '${transaction.type == TransactionType.expense ? '-' : '+'}${NumberFormat.currency(symbol: '', decimalDigits: 0).format(transaction.amount)}',
//           style: Theme.of(context).textTheme.titleMedium!.copyWith(
//             color:
//                 transaction.type == TransactionType.expense
//                     ? Colors.redAccent
//                     : Colors.greenAccent,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         onLongPress: () {
//           // Option to delete transaction
//           showDialog(
//             context: context,
//             builder:
//                 (ctx) => AlertDialog(
//                   title: const Text('Delete Transaction?'),
//                   content: Text(
//                     'Are you sure you want to delete ${transaction.category} transaction of ${NumberFormat.currency(symbol: '', decimalDigits: 0).format(transaction.amount)}?',
//                   ),
//                   actions: [
//                     TextButton(
//                       onPressed: () => Navigator.of(ctx).pop(),
//                       child: const Text('Cancel'),
//                     ),
//                     TextButton(
//                       onPressed: () {
//                         ref
//                             .read(transactionsProvider.notifier)
//                             .removeTransaction(transaction.id);
//                         Navigator.of(ctx).pop();
//                       },
//                       child: const Text(
//                         'Delete',
//                         style: TextStyle(color: Colors.red),
//                       ),
//                     ),
//                   ],
//                 ),
//           );
//         },
//       ),
//     );
//   }

//   IconData _getCategoryIcon(String category) {
//     switch (category.toLowerCase()) {
//       case 'food':
//         return Icons.fastfood;
//       case 'shopping':
//         return Icons.shopping_bag;
//       case 'donations':
//         return Icons.favorite;
//       case 'beauty':
//         return Icons.spa;
//       case 'lottery':
//         return Icons.casino;
//       case 'salary':
//         return Icons.account_balance_wallet;
//       case 'part-time':
//         return Icons.work;
//       case 'burger':
//         return Icons.lunch_dining;
//       case 'phone':
//         return Icons.phone_android;
//       case 'entertainment':
//         return Icons.movie;
//       case 'education':
//         return Icons.school;
//       case 'social':
//         return Icons.people;
//       case 'sports':
//         return Icons.sports_soccer;
//       case 'transportation':
//         return Icons.directions_bus;
//       case 'clothing':
//         return Icons.checkroom;
//       case 'car':
//         return Icons.directions_car;
//       case 'alcohol':
//         return Icons.local_bar;
//       case 'cigarettes':
//         return Icons.smoking_rooms;
//       case 'electronics':
//         return Icons.devices;
//       case 'travel':
//         return Icons.flight;
//       case 'health':
//         return Icons.medical_services;
//       case 'pets':
//         return Icons.pets;
//       case 'repairs':
//         return Icons.build;
//       case 'housing':
//         return Icons.home_work;
//       case 'home':
//         return Icons.home;
//       case 'gifts':
//         return Icons.card_giftcard;
//       case 'snacks':
//         return Icons.cookie;
//       case 'kids':
//         return Icons.child_care;
//       case 'vegetables':
//         return Icons
//             .local_florist; // Using flower for vegetables, could be more specific
//       case 'fruits':
//         return Icons.apple;
//       case 'game':
//         return Icons.gamepad;
//       case 'investments':
//         return Icons.trending_up;
//       case 'bonus':
//         return Icons.money;
//       case 'others':
//         return Icons.more_horiz;
//       // 'settings' is not a transaction category, so it's removed from this helper.
//       default:
//         return Icons.category;
//     }
//   }

//   Widget _buildSendAgainAvatars() {
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               const Text(
//                 "Send Again",
//                 style: TextStyle(fontWeight: FontWeight.bold),
//               ),
//               Text('see all'),
//             ],
//           ),

//           const SizedBox(height: 10),
//           Row(
//             children: List.generate(5, (index) {
//               return const Padding(
//                 padding: EdgeInsets.only(right: 12),
//                 child: CircleAvatar(
//                   radius: 26.5,
//                   backgroundImage: AssetImage(
//                     'assets/images/rose.jpg',
//                   ), // Replace with real images
//                 ),
//               );
//             }),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:money_manager_app/data/model/transactions.dart';
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
    final transactions = ref.watch(transactionsProvider);
    final formattedDate = DateFormat('MMM d').format(selectedDate);

    // Group transactions by date
    final Map<DateTime, List<Transaction>> groupedTransactions = {};
    for (var t in transactions) {
      final date = DateTime(t.date.year, t.date.month, t.date.day);
      groupedTransactions.putIfAbsent(date, () => []).add(t);
    }

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
      body: Column(
        children: [
          _buildSummaryHeader(context, ref, transactions, formattedDate),
          Expanded(
            child: ListView.builder(
              itemCount: sortedDates.length,
              itemBuilder: (context, index) {
                final date = sortedDates[index];
                final dailyTransactions = groupedTransactions[date]!;

                final dailyExpenses = dailyTransactions
                    .where((t) => t.type == TransactionType.expense)
                    .fold(0.0, (sum, t) => sum + t.amount);
                final dailyIncome = dailyTransactions
                    .where((t) => t.type == TransactionType.income)
                    .fold(0.0, (sum, t) => sum + t.amount);

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 8.0,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            DateFormat('MMM yyyy EEEE').format(date),
                            style: Theme.of(
                              context,
                            ).textTheme.bodyMedium!.copyWith(
                              color: Colors.grey.shade500,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Expenses: ${NumberFormat.currency(symbol: '', decimalDigits: 0).format(dailyExpenses)} Income: ${NumberFormat.currency(symbol: '', decimalDigits: 0).format(dailyIncome)}',
                            style: Theme.of(context).textTheme.bodySmall!
                                .copyWith(color: Colors.grey.shade500),
                          ),
                        ],
                      ),
                    ),
                    ...dailyTransactions.map(
                      (t) => _buildTransactionTile(context, t, ref),
                    ),
                  ],
                );
              },
            ),
          ),
          _buildSendAgainAvatars(),
        ],
      ),
    );
  }

  Widget _buildSummaryHeader(
    BuildContext context,
    WidgetRef ref,
    List<Transaction> transactions,
    String formattedDate,
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
                  NumberFormat.currency(
                    symbol: '',
                    decimalDigits: 0,
                  ).format(balance),
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
                      totalExpenses,
                      Colors.redAccent,
                    ),
                    _buildStatBlock(
                      Icons.arrow_upward,
                      "Income",
                      totalIncome,
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
    double amount,
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
                ? Colors.red.shade700
                : Colors.green.shade700,
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
