// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:money_manager_app/core/constants/app_color.dart';
// import 'package:money_manager_app/data/model/transaction.dart';
// import 'package:money_manager_app/presentation/comon_widget/transaction_listitem.dart';

// class TransactionsListView extends StatelessWidget {
//   final List<Transaction> transactions;

//   const TransactionsListView({super.key, required this.transactions});

//   @override
//   Widget build(BuildContext context) {
//     // Group transactions by date
//     Map<DateTime, List<Transaction>> groupedTransactions = {};
//     for (var transaction in transactions) {
//       DateTime dateOnly = DateTime(
//         transaction.date.year,
//         transaction.date.month,
//         transaction.date.day,
//       );
//       if (!groupedTransactions.containsKey(dateOnly)) {
//         groupedTransactions[dateOnly] = [];
//       }
//       groupedTransactions[dateOnly]!.add(transaction);
//     }

//     // Sort dates in descending order
//     List<DateTime> sortedDates =
//         groupedTransactions.keys.toList()..sort((a, b) => b.compareTo(a));

//     return ListView.builder(
//       itemCount: sortedDates.length,
//       itemBuilder: (context, index) {
//         DateTime date = sortedDates[index];
//         List<Transaction> dailyTransactions = groupedTransactions[date]!;

//         // Calculate daily expenses and income
//         int dailyExpenses = dailyTransactions
//             .where((t) => t.type == TransactionType.expense)
//             .map((t) => t.amount)
//             .fold(0, (sum, item) => sum + item);
//         int dailyIncome = dailyTransactions
//             .where((t) => t.type == TransactionType.income)
//             .map((t) => t.amount)
//             .fold(0, (sum, item) => sum + item);

//         return Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Padding(
//               padding: const EdgeInsets.symmetric(
//                 horizontal: 16.0,
//                 vertical: 8.0,
//               ),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     DateFormat('MMM dd EEEE').format(date),
//                     style: const TextStyle(
//                       color: AppColors.secondaryText,
//                       fontSize: 14,
//                     ),
//                   ),
//                   Text(
//                     'Expenses: $dailyExpenses Income: $dailyIncome', // Format as currency
//                     style: const TextStyle(
//                       color: AppColors.secondaryText,
//                       fontSize: 13,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             // Sort transactions by time if needed, for now just display as is
//             ...dailyTransactions.map((transaction) {
//               return TransactionListItem(transaction: transaction);
//             }).toList(),
//           ],
//         );
//       },
//     );
//   }
// }
