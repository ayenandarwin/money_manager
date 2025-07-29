// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:intl/intl.dart';
// import 'package:money_manager_app/data/model/transactions.dart';
// import 'package:money_manager_app/provider/transaction.dart';

// class RCScreen extends ConsumerWidget {
//   const RCScreen({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final transactions = ref.watch(transactionsProvider);

//     return Scaffold(
//       backgroundColor: const Color(0xFFF6F8FA),
//       // bottomNavigationBar: _buildBottomNavBar(),
//       // floatingActionButton: FloatingActionButton(
//       //   onPressed: () {},
//       //   child: const Icon(Icons.add),
//       //   backgroundColor: const Color(0xFF116D6E),
//       // ),
//       // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//       body: SafeArea(
//         child: Column(
//           children: [
//             //  _buildHeader(context),
//             _buildBalanceCard(context, transactions),
//             _buildTransactionHistory(context, transactions),
//             _buildSendAgainAvatars(),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildHeader(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           const Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 "Good afternoon,",
//                 style: TextStyle(color: Colors.grey, fontSize: 14),
//               ),
//               Text(
//                 "Enjelin Morgeana",
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//               ),
//             ],
//           ),
//           IconButton(
//             onPressed: () {},
//             icon: const Icon(Icons.notifications_none),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildBalanceCard(
//     BuildContext context,
//     List<Transaction> transactions,
//   ) {
//     final income = transactions
//         .where((t) => t.type == TransactionType.income)
//         .fold(0.0, (sum, t) => sum + t.amount);
//     final expenses = transactions
//         .where((t) => t.type == TransactionType.expense)
//         .fold(0.0, (sum, t) => sum + t.amount);
//     final balance = income - expenses;

//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//       child: Container(
//         padding: const EdgeInsets.all(20),
//         decoration: BoxDecoration(
//           color: const Color(0xFF116D6E),
//           borderRadius: BorderRadius.circular(20),
//         ),
//         child: Column(
//           children: [
//             Row(
//               children: [
//                 const Text(
//                   "Total Balance",
//                   style: TextStyle(color: Colors.white),
//                 ),
//                 const Spacer(),
//                 Icon(Icons.more_horiz, color: Colors.white.withOpacity(0.8)),
//               ],
//             ),
//             const SizedBox(height: 10),
//             Text(
//               "\$${balance.toStringAsFixed(2)}",
//               style: const TextStyle(
//                 color: Colors.white,
//                 fontSize: 28,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(height: 20),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 _incomeExpenseColumn(
//                   "Income",
//                   income,
//                   Icons.arrow_downward,
//                   Colors.greenAccent,
//                 ),
//                 _incomeExpenseColumn(
//                   "Expenses",
//                   expenses,
//                   Icons.arrow_upward,
//                   Colors.redAccent,
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _incomeExpenseColumn(
//     String title,
//     double amount,
//     IconData icon,
//     Color iconColor,
//   ) {
//     return Row(
//       children: [
//         Icon(icon, color: iconColor),
//         const SizedBox(width: 5),
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               title,
//               style: const TextStyle(color: Colors.white70, fontSize: 12),
//             ),
//             Text(
//               "\$${amount.toStringAsFixed(2)}",
//               style: const TextStyle(
//                 color: Colors.white,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }

//   Widget _buildTransactionHistory(
//     BuildContext context,
//     List<Transaction> transactions,
//   ) {
//     return Expanded(
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 20.0),
//         child: ListView.separated(
//           itemCount: transactions.length,
//           separatorBuilder: (_, __) => const Divider(),
//           itemBuilder: (context, index) {
//             final t = transactions[index];
//             return ListTile(
//               leading: CircleAvatar(
//                 backgroundColor:
//                     t.type == TransactionType.income
//                         ? Colors.greenAccent.withOpacity(0.2)
//                         : Colors.redAccent.withOpacity(0.2),
//                 child: Icon(
//                   t.type == TransactionType.income
//                       ? Icons.call_received
//                       : Icons.call_made,
//                   color:
//                       t.type == TransactionType.income
//                           ? Colors.green
//                           : Colors.red,
//                 ),
//               ),
//               title: Text(t.category),
//               subtitle: Text(DateFormat('MMM dd, yyyy').format(t.date)),
//               trailing: Text(
//                 "${t.type == TransactionType.expense ? '-' : '+'} \$${t.amount.toStringAsFixed(2)}",
//                 style: TextStyle(
//                   color:
//                       t.type == TransactionType.expense
//                           ? Colors.red
//                           : Colors.green,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }

//   Widget _buildSendAgainAvatars() {
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Text(
//             "Send Again",
//             style: TextStyle(fontWeight: FontWeight.bold),
//           ),
//           const SizedBox(height: 10),
//           Row(
//             children: List.generate(5, (index) {
//               return const Padding(
//                 padding: EdgeInsets.only(right: 10),
//                 child: CircleAvatar(
//                   radius: 25,
//                   backgroundImage: AssetImage(
//                     'assets/avatar_placeholder.png',
//                   ), // Replace with real images
//                 ),
//               );
//             }),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildBottomNavBar() {
//     return BottomAppBar(
//       shape: const CircularNotchedRectangle(),
//       notchMargin: 6.0,
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: const [
//           IconButton(icon: Icon(Icons.home), onPressed: null),
//           IconButton(icon: Icon(Icons.bar_chart), onPressed: null),
//           SizedBox(width: 40), // FAB spacing
//           IconButton(icon: Icon(Icons.account_balance_wallet), onPressed: null),
//           IconButton(icon: Icon(Icons.person), onPressed: null),
//         ],
//       ),
//     );
//   }
// }
