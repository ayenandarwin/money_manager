// import 'package:flutter/material.dart';
// import 'package:money_manager_app/core/constants/app_color.dart';
// import 'package:money_manager_app/data/model/transaction.dart';
// import 'package:money_manager_app/main.dart';
// import 'package:money_manager_app/presentation/screens/charts/expense.dart';
// import 'package:money_manager_app/presentation/screens/home/widgets/summary_section.dart';
// import 'package:money_manager_app/presentation/screens/home/widgets/transaction_listview.dart';
// // Dummy Data အတွက်

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   // Dummy Data for demonstration
//   final List<Transaction> _transactions = [
//     Transaction(
//       id: 't1',
//       date: DateTime(2025, 7, 16),
//       type: TransactionType.expense,
//       amount: 15000,
//       category: 'Lottery',
//       icon: Icons.casino,
//     ),
//     Transaction(
//       id: 't2',
//       date: DateTime(2025, 7, 16),
//       type: TransactionType.expense,
//       amount: 60000,
//       category: 'Donations',
//       icon: Icons.favorite_border,
//     ),
//     Transaction(
//       id: 't3',
//       date: DateTime(2025, 7, 16),
//       type: TransactionType.income,
//       amount: 10000,
//       category: 'Lottery',
//       icon: Icons.casino,
//     ),
//     Transaction(
//       id: 't4',
//       date: DateTime(2025, 7, 16),
//       type: TransactionType.expense,
//       amount: 8000,
//       category: 'Burger',
//       icon: Icons.fastfood,
//     ),
//     Transaction(
//       id: 't5',
//       date: DateTime(2025, 7, 15),
//       type: TransactionType.expense,
//       amount: 50000,
//       category: 'bty',
//       icon: Icons.lightbulb,
//     ),
//     Transaction(
//       id: 't6',
//       date: DateTime(2025, 7, 15),
//       type: TransactionType.income,
//       amount: 20000,
//       category: 'PT',
//       icon: Icons.money,
//     ),
//     Transaction(
//       id: 't7',
//       date: DateTime(2025, 7, 15),
//       type: TransactionType.income,
//       amount: 700000,
//       category: 'Salary',
//       icon: Icons.work,
//     ),
//     Transaction(
//       id: 't8',
//       date: DateTime(2025, 7, 15),
//       type: TransactionType.expense,
//       amount: 100000,
//       category: 'Shopping',
//       icon: Icons.shopping_cart,
//     ),
//     Transaction(
//       id: 't9',
//       date: DateTime(2025, 7, 15),
//       type: TransactionType.expense,
//       amount: 200000,
//       category: 'Food',
//       icon: Icons.restaurant,
//     ),
//   ];

//   int _currentIndex = 0; // For Bottom Nav Bar

//   @override
//   Widget build(BuildContext context) {
//     // Responsive Design အတွက် MediaQuery ကို အသုံးပြုနိုင်ပါတယ်
//     final mediaQuery = MediaQuery.of(context);
//     final screenHeight = mediaQuery.size.height;
//     final screenWidth = mediaQuery.size.width;

//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           icon: const Icon(Icons.menu),
//           onPressed: () {
//             // Handle drawer open
//           },
//         ),
//         title: const Text('Money Tracker'),
//         centerTitle: true,
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.search),
//             onPressed: () {
//               // Handle search
//             },
//           ),
//           IconButton(
//             icon: const Icon(Icons.calendar_month),
//             onPressed: () {
//               // Handle calendar
//             },
//           ),
//         ],
//       ),
//       body: Column(
//         children: [
//           // Warning Message
//           Container(
//             width: double.infinity,
//             padding: const EdgeInsets.symmetric(
//               vertical: 8.0,
//               horizontal: 16.0,
//             ),
//             color: AppColors.warningBackground,
//             child: const Text(
//               'After logging in, you can back up your data in real time!',
//               style: TextStyle(color: AppColors.warningText, fontSize: 13),
//               textAlign: TextAlign.center,
//             ),
//           ),
//           // Summary Section
//           SummarySection(
//             currentMonth: 'Jul',
//             currentYear: '2025',
//             expenses: 433000,
//             income: 730000,
//             balance: 297000,
//           ),
//           Expanded(child: TransactionsListView(transactions: _transactions)),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           // Handle add new transaction
//         },
//         shape: const CircleBorder(), // For round button
//         child: const Icon(Icons.add),
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//       bottomNavigationBar: BottomAppBar(
//         color: AppColors.bottomNavBackground,
//         shape: const CircularNotchedRectangle(), // FAB ကြောင့် ကွက်လပ်ချန်ဖို့
//         notchMargin: 8.0,
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: [
//             _buildBottomNavItem(0, Icons.assignment, 'Records'),
//             _buildBottomNavItem(1, Icons.bar_chart, 'Charts'),
//             const SizedBox(width: 48), // Space for the FAB
//             _buildBottomNavItem(2, Icons.description, 'Reports'),
//             _buildBottomNavItem(3, Icons.person, 'Me'),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildBottomNavItem(int index, IconData icon, String label) {
//     return Expanded(
//       child: InkWell(
//         onTap: () {
//           setState(() {
//             _currentIndex = index;
//             // Handle navigation logic here
//           });
//         },
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(
//               icon,
//               color:
//                   _currentIndex == index
//                       ? AppColors.accentColor
//                       : AppColors.secondaryText,
//             ),
//             Text(
//               label,
//               style: TextStyle(
//                 color:
//                     _currentIndex == index
//                         ? AppColors.accentColor
//                         : AppColors.secondaryText,
//                 fontSize: 12,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
