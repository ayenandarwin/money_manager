// import 'package:flutter/material.dart';
// import 'package:money_manager_app/core/constants/app_color.dart';
// import 'package:money_manager_app/data/model/transaction.dart';

// class TransactionListItem extends StatelessWidget {
//   final Transaction transaction;

//   const TransactionListItem({super.key, required this.transaction});

//   @override
//   Widget build(BuildContext context) {
//     final bool isExpense = transaction.type == TransactionType.expense;
//     final Color amountColor =
//         isExpense ? AppColors.expenseColor : AppColors.incomeColor;
//     final String sign = isExpense ? '-' : '';

//     return Container(
//       color: AppColors.primaryBackground, // နောက်ခံအရောင်
//       padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
//       margin: const EdgeInsets.only(
//         bottom: 1.0,
//       ), // Item တွေကြား နည်းနည်းခြားဖို့
//       child: Row(
//         children: [
//           CircleAvatar(
//             backgroundColor:
//                 AppColors.bottomNavBackground, // Icon ရဲ့ နောက်ခံအရောင်
//             child: Icon(transaction.icon, color: AppColors.secondaryText),
//           ),
//           const SizedBox(width: 12),
//           Expanded(
//             child: Text(
//               transaction.category,
//               style: const TextStyle(
//                 color: AppColors.primaryText,
//                 fontSize: 16,
//               ),
//             ),
//           ),
//           Text(
//             '$sign${transaction.amount}', // Format as currency
//             style: TextStyle(
//               color: amountColor,
//               fontSize: 16,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
