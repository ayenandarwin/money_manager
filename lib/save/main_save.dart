// // import 'package:flutter/material.dart';
// // import 'package:money_manager_app/presentation/screens/charts/chart_screen.dart';
// // import 'package:money_manager_app/presentation/screens/charts/expense.dart';
// // import 'presentation/screens/home/home_screen.dart';

// // void main() {
// //   runApp(const MyApp());
// // }

// // class MyApp extends StatelessWidget {
// //   const MyApp({super.key});

// //   // This widget is the root of your application.
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       title: 'Flutter Demo',
// //       theme: ThemeData(
// //         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
// //       ),
// //       home: ExpenseChartApp(),
// //     );
// //   }
// // }

// // import 'package:flutter/material.dart';
// // import 'package:flutter_riverpod/flutter_riverpod.dart';
// // import 'package:intl/intl.dart'; // For date formatting
// // import 'package:fl_chart/fl_chart.dart'; // For charts

// // // -----------------------------------------------------------------------------
// // // 1. Models (Data Structures)
// // // -----------------------------------------------------------------------------

// // enum TransactionType { expense, income }

// // class Transaction {
// //   final String id;
// //   final String category;
// //   final double amount;
// //   final TransactionType type;
// //   final DateTime date;
// //   final String? description; // Optional description

// //   Transaction({
// //     required this.id,
// //     required this.category,
// //     required this.amount,
// //     required this.type,
// //     required this.date,
// //     this.description,
// //   });

// //   // Factory constructor to create a Transaction from a map (e.g., from Firestore)
// //   factory Transaction.fromMap(Map<String, dynamic> map) {
// //     return Transaction(
// //       id: map['id'] as String,
// //       category: map['category'] as String,
// //       amount: map['amount'] as double,
// //       type: TransactionType.values.firstWhere(
// //         (e) => e.toString().split('.').last == map['type'],
// //       ),
// //       date: DateTime.parse(
// //         map['date'] as String,
// //       ), // Store date as ISO 8601 string
// //       description: map['description'] as String?,
// //     );
// //   }

// //   // Convert Transaction to a map (e.g., for Firestore)
// //   Map<String, dynamic> toMap() {
// //     return {
// //       'id': id,
// //       'category': category,
// //       'amount': amount,
// //       'type': type.toString().split('.').last, // Store enum as string
// //       'date': date.toIso8601String(), // Store date as ISO 8601 string
// //       'description': description,
// //     };
// //   }
// // }

// // // -----------------------------------------------------------------------------
// // // 2. State Management (Riverpod Providers)
// // // -----------------------------------------------------------------------------

// // // Provider for managing the list of transactions
// // final transactionsProvider =
// //     StateNotifierProvider<TransactionsNotifier, List<Transaction>>((ref) {
// //       return TransactionsNotifier();
// //     });

// // class TransactionsNotifier extends StateNotifier<List<Transaction>> {
// //   TransactionsNotifier()
// //     : super(_initialTransactions); // Initialize with dummy data

// //   // Dummy data for demonstration
// //   static final List<Transaction> _initialTransactions = [
// //     Transaction(
// //       id: 't1',
// //       category: 'Lottery',
// //       amount: 15000,
// //       type: TransactionType.expense,
// //       date: DateTime(2025, 7, 16),
// //     ),
// //     Transaction(
// //       id: 't2',
// //       category: 'Donations',
// //       amount: 60000,
// //       type: TransactionType.expense,
// //       date: DateTime(2025, 7, 16),
// //     ),
// //     Transaction(
// //       id: 't3',
// //       category: 'Lottery',
// //       amount: 10000,
// //       type: TransactionType.income,
// //       date: DateTime(2025, 7, 16),
// //     ),
// //     Transaction(
// //       id: 't4',
// //       category: 'Burger',
// //       amount: 8000,
// //       type: TransactionType.expense,
// //       date: DateTime(2025, 7, 16),
// //     ),
// //     Transaction(
// //       id: 't5',
// //       category: 'Beauty',
// //       amount: 50000,
// //       type: TransactionType.expense,
// //       date: DateTime(2025, 7, 15),
// //     ),
// //     Transaction(
// //       id: 't6',
// //       category: 'Part-Time',
// //       amount: 20000,
// //       type: TransactionType.income,
// //       date: DateTime(2025, 7, 15),
// //     ),
// //     Transaction(
// //       id: 't7',
// //       category: 'Salary',
// //       amount: 700000,
// //       type: TransactionType.income,
// //       date: DateTime(2025, 7, 15),
// //     ),
// //     Transaction(
// //       id: 't8',
// //       category: 'Shopping',
// //       amount: 100000,
// //       type: TransactionType.expense,
// //       date: DateTime(2025, 7, 15),
// //     ),
// //     Transaction(
// //       id: 't9',
// //       category: 'Food',
// //       amount: 200000,
// //       type: TransactionType.expense,
// //       date: DateTime(2025, 7, 15),
// //     ),
// //     // Add some data for May 2025 for chart view
// //     Transaction(
// //       id: 't10',
// //       category: 'Food',
// //       amount: 48030,
// //       type: TransactionType.expense,
// //       date: DateTime(2025, 5, 10),
// //     ),
// //     Transaction(
// //       id: 't11',
// //       category: 'Shopping',
// //       amount: 23090,
// //       type: TransactionType.expense,
// //       date: DateTime(2025, 5, 12),
// //     ),
// //     Transaction(
// //       id: 't12',
// //       category: 'Donations',
// //       amount: 13850,
// //       type: TransactionType.expense,
// //       date: DateTime(2025, 5, 15),
// //     ),
// //     Transaction(
// //       id: 't13',
// //       category: 'Beauty',
// //       amount: 11540,
// //       type: TransactionType.expense,
// //       date: DateTime(2025, 5, 18),
// //     ),
// //     Transaction(
// //       id: 't14',
// //       category: 'Lottery',
// //       amount: 3460,
// //       type: TransactionType.expense,
// //       date: DateTime(2025, 5, 20),
// //     ),
// //     Transaction(
// //       id: 't15',
// //       category: 'Salary',
// //       amount: 700000,
// //       type: TransactionType.income,
// //       date: DateTime(2025, 5, 25),
// //     ),
// //     Transaction(
// //       id: 't16',
// //       category: 'Part-Time',
// //       amount: 30000,
// //       type: TransactionType.income,
// //       date: DateTime(2025, 5, 28),
// //     ),
// //   ];

// //   void addTransaction(Transaction transaction) {
// //     state = [...state, transaction];
// //   }

// //   void removeTransaction(String id) {
// //     state = state.where((t) => t.id != id).toList();
// //   }

// //   // In a real app, you would fetch/save from/to Firestore here
// //   // Future<void> fetchTransactions() async { ... }
// //   // Future<void> saveTransaction(Transaction transaction) async { ... }
// // }

// // // Provider for managing the currently selected bottom navigation index
// // final bottomNavIndexProvider = StateProvider<int>((ref) => 0);

// // // Provider for managing the selected month/year for charts
// // final selectedChartDateProvider = StateProvider<DateTime>(
// //   (ref) => DateTime.now(),
// // );

// // // Provider for managing the chart type (Expense/Income)
// // final chartTypeProvider = StateProvider<TransactionType>(
// //   (ref) => TransactionType.expense,
// // );

// // // -----------------------------------------------------------------------------
// // // 3. Main Application Structure
// // // -----------------------------------------------------------------------------

// // void main() {
// //   runApp(
// //     const ProviderScope(
// //       // Wrap the app with ProviderScope for Riverpod
// //       child: MoneyTrackerApp(),
// //     ),
// //   );
// // }

// // class MoneyTrackerApp extends ConsumerWidget {
// //   const MoneyTrackerApp({super.key});

// //   @override
// //   Widget build(BuildContext context, WidgetRef ref) {
// //     return MaterialApp(
// //       title: 'Money Tracker',
// //       debugShowCheckedModeBanner: false,
// //       theme: ThemeData(
// //         // brightness: Brightness.dark, // Dark theme as per UI images
// //         primarySwatch: Colors.yellow, // Primary color for accents
// //         scaffoldBackgroundColor: const Color(0xFF1C1C1C), // Dark background
// //         appBarTheme: const AppBarTheme(
// //           backgroundColor: Color(0xFF1C1C1C),
// //           elevation: 0,
// //           titleTextStyle: TextStyle(
// //             color: Colors.white,
// //             fontSize: 20,
// //             fontWeight: FontWeight.bold,
// //           ),
// //           iconTheme: IconThemeData(color: Colors.white),
// //         ),
// //         bottomNavigationBarTheme: BottomNavigationBarThemeData(
// //           backgroundColor: const Color(0xFF2C2C2C), // Darker bottom nav
// //           selectedItemColor: Colors.yellow.shade700, // Yellow for selected
// //           unselectedItemColor: Colors.grey, // Grey for unselected
// //           type: BottomNavigationBarType.fixed, // Fixed type to show all labels
// //           selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
// //         ),
// //         floatingActionButtonTheme: FloatingActionButtonThemeData(
// //           backgroundColor: Colors.yellow.shade700, // Yellow FAB
// //           foregroundColor: Colors.black, // Black icon on FAB
// //           shape: const CircleBorder(), // Circular FAB
// //         ),
// //         cardTheme: CardTheme(
// //           color: const Color(0xFF2C2C2C), // Darker card background
// //           elevation: 4,
// //           shape: RoundedRectangleBorder(
// //             borderRadius: BorderRadius.circular(12),
// //           ),
// //         ),
// //         textTheme: const TextTheme(
// //           bodyLarge: TextStyle(color: Colors.white),
// //           bodyMedium: TextStyle(color: Colors.white70),
// //           titleLarge: TextStyle(
// //             color: Colors.white,
// //             fontWeight: FontWeight.bold,
// //           ),
// //           titleMedium: TextStyle(color: Colors.white),
// //           labelLarge: TextStyle(color: Colors.white),
// //         ),
// //         dividerColor: Colors.grey.shade800, // Subtle dividers
// //         colorScheme: ColorScheme.fromSwatch(
// //           primarySwatch: Colors.yellow,
// //         ).copyWith(
// //           secondary: Colors.yellow.shade700, // Accent color
// //           background: const Color(0xFF1C1C1C), // Background color
// //         ),
// //       ),
// //       home: const MainScreen(),
// //     );
// //   }
// // }

// // // -----------------------------------------------------------------------------
// // // 4. Main Screen with Bottom Navigation
// // // -----------------------------------------------------------------------------

// // class MainScreen extends ConsumerWidget {
// //   const MainScreen({super.key});

// //   final List<Widget> _screens = const [
// //     RecordsScreen(),
// //     ChartsScreen(),
// //     // Add other screens like ReportsScreen, MeScreen
// //     Center(child: Text('Reports Screen')),
// //     Center(child: Text('Me Screen')),
// //   ];

// //   @override
// //   Widget build(BuildContext context, WidgetRef ref) {
// //     final selectedIndex = ref.watch(bottomNavIndexProvider);

// //     return Scaffold(
// //       body: _screens[selectedIndex],
// //       bottomNavigationBar: BottomNavigationBar(
// //         currentIndex: selectedIndex,
// //         onTap: (index) {
// //           ref.read(bottomNavIndexProvider.notifier).state = index;
// //         },
// //         items: const [
// //           BottomNavigationBarItem(
// //             icon: Icon(Icons.receipt_long),
// //             label: 'Records',
// //           ),
// //           BottomNavigationBarItem(icon: Icon(Icons.pie_chart), label: 'Charts'),
// //           BottomNavigationBarItem(
// //             icon: Icon(Icons.bar_chart),
// //             label: 'Reports',
// //           ),
// //           BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Me'),
// //         ],
// //       ),
// //       floatingActionButton: FloatingActionButton(
// //         onPressed: () {
// //           // Handle adding a new transaction
// //           _showAddTransactionDialog(context, ref);
// //         },
// //         child: const Icon(Icons.add),
// //       ),
// //       floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
// //     );
// //   }

// //   void _showAddTransactionDialog(BuildContext context, WidgetRef ref) {
// //     final TextEditingController categoryController = TextEditingController();
// //     final TextEditingController amountController = TextEditingController();
// //     TransactionType selectedType = TransactionType.expense;
// //     DateTime selectedDate = DateTime.now();

// //     showModalBottomSheet(
// //       context: context,
// //       isScrollControlled: true, // Allow content to scroll if keyboard appears
// //       builder: (BuildContext bc) {
// //         return Padding(
// //           padding: EdgeInsets.only(
// //             bottom: MediaQuery.of(bc).viewInsets.bottom,
// //             left: 20,
// //             right: 20,
// //             top: 20,
// //           ),
// //           child: StatefulBuilder(
// //             builder: (BuildContext context, StateSetter setState) {
// //               return Column(
// //                 mainAxisSize: MainAxisSize.min,
// //                 children: <Widget>[
// //                   Text(
// //                     'Add New Transaction',
// //                     style: Theme.of(context).textTheme.titleLarge,
// //                   ),
// //                   const SizedBox(height: 20),
// //                   Row(
// //                     children: [
// //                       Expanded(
// //                         child: RadioListTile<TransactionType>(
// //                           title: const Text('Expense'),
// //                           value: TransactionType.expense,
// //                           groupValue: selectedType,
// //                           onChanged: (TransactionType? value) {
// //                             setState(() {
// //                               selectedType = value!;
// //                             });
// //                           },
// //                           activeColor: Colors.yellow.shade700,
// //                         ),
// //                       ),
// //                       Expanded(
// //                         child: RadioListTile<TransactionType>(
// //                           title: const Text('Income'),
// //                           value: TransactionType.income,
// //                           groupValue: selectedType,
// //                           onChanged: (TransactionType? value) {
// //                             setState(() {
// //                               selectedType = value!;
// //                             });
// //                           },
// //                           activeColor: Colors.yellow.shade700,
// //                         ),
// //                       ),
// //                     ],
// //                   ),
// //                   TextField(
// //                     controller: categoryController,
// //                     decoration: InputDecoration(
// //                       labelText: 'Category',
// //                       filled: true,
// //                       fillColor: Colors.grey.shade800,
// //                       border: OutlineInputBorder(
// //                         borderRadius: BorderRadius.circular(8),
// //                         borderSide: BorderSide.none,
// //                       ),
// //                     ),
// //                     style: const TextStyle(color: Colors.white),
// //                   ),
// //                   const SizedBox(height: 10),
// //                   TextField(
// //                     controller: amountController,
// //                     keyboardType: TextInputType.number,
// //                     decoration: InputDecoration(
// //                       labelText: 'Amount',
// //                       filled: true,
// //                       fillColor: Colors.grey.shade800,
// //                       border: OutlineInputBorder(
// //                         borderRadius: BorderRadius.circular(8),
// //                         borderSide: BorderSide.none,
// //                       ),
// //                     ),
// //                     style: const TextStyle(color: Colors.white),
// //                   ),
// //                   const SizedBox(height: 10),
// //                   ListTile(
// //                     title: Text(
// //                       'Date: ${DateFormat('yyyy-MM-dd').format(selectedDate)}',
// //                       style: const TextStyle(color: Colors.white),
// //                     ),
// //                     trailing: const Icon(
// //                       Icons.calendar_today,
// //                       color: Colors.white,
// //                     ),
// //                     onTap: () async {
// //                       final DateTime? picked = await showDatePicker(
// //                         context: context,
// //                         initialDate: selectedDate,
// //                         firstDate: DateTime(2000),
// //                         lastDate: DateTime(2101),
// //                         builder: (context, child) {
// //                           return Theme(
// //                             data: Theme.of(context).copyWith(
// //                               colorScheme: ColorScheme.dark(
// //                                 primary:
// //                                     Colors
// //                                         .yellow
// //                                         .shade700, // Header background color
// //                                 onPrimary: Colors.black, // Header text color
// //                                 surface: const Color(
// //                                   0xFF2C2C2C,
// //                                 ), // Calendar background color
// //                                 onSurface: Colors.white, // Calendar text color
// //                               ),
// //                               textButtonTheme: TextButtonThemeData(
// //                                 style: TextButton.styleFrom(
// //                                   foregroundColor:
// //                                       Colors
// //                                           .yellow
// //                                           .shade700, // Button text color
// //                                 ),
// //                               ),
// //                             ),
// //                             child: child!,
// //                           );
// //                         },
// //                       );
// //                       if (picked != null && picked != selectedDate) {
// //                         setState(() {
// //                           selectedDate = picked;
// //                         });
// //                       }
// //                     },
// //                   ),
// //                   const SizedBox(height: 20),
// //                   SizedBox(
// //                     width: double.infinity,
// //                     child: ElevatedButton(
// //                       onPressed: () {
// //                         if (categoryController.text.isNotEmpty &&
// //                             amountController.text.isNotEmpty) {
// //                           final newTransaction = Transaction(
// //                             id:
// //                                 DateTime.now().millisecondsSinceEpoch
// //                                     .toString(),
// //                             category: categoryController.text,
// //                             amount: double.parse(amountController.text),
// //                             type: selectedType,
// //                             date: selectedDate,
// //                           );
// //                           ref
// //                               .read(transactionsProvider.notifier)
// //                               .addTransaction(newTransaction);
// //                           Navigator.pop(context);
// //                         }
// //                       },
// //                       child: const Text('Add Transaction'),
// //                     ),
// //                   ),
// //                   const SizedBox(height: 10),
// //                 ],
// //               );
// //             },
// //           ),
// //         );
// //       },
// //     );
// //   }
// // }

// // // -----------------------------------------------------------------------------
// // // 5. Records Screen
// // // -----------------------------------------------------------------------------

// // class RecordsScreen extends ConsumerWidget {
// //   const RecordsScreen({super.key});

// //   @override
// //   Widget build(BuildContext context, WidgetRef ref) {
// //     final transactions = ref.watch(transactionsProvider);

// //     // Group transactions by date
// //     final Map<DateTime, List<Transaction>> groupedTransactions = {};
// //     for (var t in transactions) {
// //       final date = DateTime(
// //         t.date.year,
// //         t.date.month,
// //         t.date.day,
// //       ); // Normalize date to remove time
// //       groupedTransactions.putIfAbsent(date, () => []).add(t);
// //     }

// //     // Sort dates in descending order
// //     final sortedDates =
// //         groupedTransactions.keys.toList()..sort((a, b) => b.compareTo(a));

// //     return Scaffold(
// //       appBar: AppBar(
// //         title: const Text('Money Tracker'),
// //         leading: IconButton(
// //           icon: const Icon(Icons.menu),
// //           onPressed: () {
// //             // Handle drawer or menu
// //           },
// //         ),
// //         actions: [
// //           IconButton(
// //             icon: const Icon(Icons.search),
// //             onPressed: () {
// //               // Handle search
// //             },
// //           ),
// //           IconButton(
// //             icon: const Icon(Icons.calendar_today),
// //             onPressed: () {
// //               // Handle calendar view
// //             },
// //           ),
// //         ],
// //       ),
// //       body: Column(
// //         children: [
// //           // Header with current month, expenses, income, balance
// //           _buildSummaryHeader(context, ref, transactions),
// //           Expanded(
// //             child: ListView.builder(
// //               itemCount: sortedDates.length,
// //               itemBuilder: (context, index) {
// //                 final date = sortedDates[index];
// //                 final dailyTransactions = groupedTransactions[date]!;

// //                 // Calculate daily expenses and income
// //                 final dailyExpenses = dailyTransactions
// //                     .where((t) => t.type == TransactionType.expense)
// //                     .fold(0.0, (sum, t) => sum + t.amount);
// //                 final dailyIncome = dailyTransactions
// //                     .where((t) => t.type == TransactionType.income)
// //                     .fold(0.0, (sum, t) => sum + t.amount);

// //                 return Column(
// //                   crossAxisAlignment: CrossAxisAlignment.start,
// //                   children: [
// //                     Padding(
// //                       padding: const EdgeInsets.symmetric(
// //                         horizontal: 16.0,
// //                         vertical: 8.0,
// //                       ),
// //                       child: Column(
// //                         crossAxisAlignment: CrossAxisAlignment.start,
// //                         children: [
// //                           Text(
// //                             DateFormat('MMM dd, yyyy EEEE').format(date),
// //                             style: Theme.of(
// //                               context,
// //                             ).textTheme.bodyMedium!.copyWith(
// //                               color: Colors.grey.shade400,
// //                               fontWeight: FontWeight.bold,
// //                             ),
// //                           ),
// //                           Text(
// //                             'Expenses: ${NumberFormat.currency(symbol: '', decimalDigits: 0).format(dailyExpenses)} Income: ${NumberFormat.currency(symbol: '', decimalDigits: 0).format(dailyIncome)}',
// //                             style: Theme.of(context).textTheme.bodySmall!
// //                                 .copyWith(color: Colors.grey.shade500),
// //                           ),
// //                         ],
// //                       ),
// //                     ),
// //                     ...dailyTransactions.map((transaction) {
// //                       return _buildTransactionTile(context, transaction, ref);
// //                     }).toList(),
// //                     const Divider(height: 1), // Separator between days
// //                   ],
// //                 );
// //               },
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }

// //   Widget _buildSummaryHeader(
// //     BuildContext context,
// //     WidgetRef ref,
// //     List<Transaction> transactions,
// //   ) {
// //     final currentMonth = DateTime.now().month;
// //     final currentYear = DateTime.now().year;

// //     final monthlyTransactions =
// //         transactions
// //             .where(
// //               (t) => t.date.month == currentMonth && t.date.year == currentYear,
// //             )
// //             .toList();

// //     final totalExpenses = monthlyTransactions
// //         .where((t) => t.type == TransactionType.expense)
// //         .fold(0.0, (sum, t) => sum + t.amount);
// //     final totalIncome = monthlyTransactions
// //         .where((t) => t.type == TransactionType.income)
// //         .fold(0.0, (sum, t) => sum + t.amount);
// //     final balance = totalIncome - totalExpenses;

// //     return Container(
// //       padding: const EdgeInsets.all(16.0),
// //       color:
// //           Theme.of(
// //             context,
// //           ).appBarTheme.backgroundColor, // Use app bar background
// //       child: Column(
// //         children: [
// //           Row(
// //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //             children: [
// //               DropdownButton<String>(
// //                 value: DateFormat('MMM yyyy').format(DateTime.now()),
// //                 dropdownColor: Theme.of(context).cardTheme.color,
// //                 style: Theme.of(context).textTheme.titleLarge!.copyWith(
// //                   color: Colors.white,
// //                   fontSize: 16,
// //                 ),
// //                 icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
// //                 onChanged: (String? newValue) {
// //                   // Handle month change
// //                 },
// //                 items:
// //                     <String>[
// //                       DateFormat('MMM yyyy').format(DateTime.now()),
// //                       'Jul 2024',
// //                       'Jun 2024',
// //                     ] // Dummy months
// //                     .map<DropdownMenuItem<String>>((String value) {
// //                       return DropdownMenuItem<String>(
// //                         value: value,
// //                         child: Text(value),
// //                       );
// //                     }).toList(),
// //               ),
// //               Row(
// //                 children: [
// //                   Column(
// //                     crossAxisAlignment: CrossAxisAlignment.end,
// //                     children: [
// //                       Text(
// //                         'Expenses',
// //                         style: Theme.of(context).textTheme.bodyMedium!.copyWith(
// //                           color: Colors.redAccent,
// //                         ),
// //                       ),
// //                       Text(
// //                         NumberFormat.currency(
// //                           symbol: '',
// //                           decimalDigits: 0,
// //                         ).format(totalExpenses),
// //                         style: Theme.of(context).textTheme.titleMedium!
// //                             .copyWith(color: Colors.redAccent),
// //                       ),
// //                     ],
// //                   ),
// //                   const SizedBox(width: 16),
// //                   Column(
// //                     crossAxisAlignment: CrossAxisAlignment.end,
// //                     children: [
// //                       Text(
// //                         'Income',
// //                         style: Theme.of(context).textTheme.bodyMedium!.copyWith(
// //                           color: Colors.greenAccent,
// //                         ),
// //                       ),
// //                       Text(
// //                         NumberFormat.currency(
// //                           symbol: '',
// //                           decimalDigits: 0,
// //                         ).format(totalIncome),
// //                         style: Theme.of(context).textTheme.titleMedium!
// //                             .copyWith(color: Colors.greenAccent),
// //                       ),
// //                     ],
// //                   ),
// //                   const SizedBox(width: 16),
// //                   Column(
// //                     crossAxisAlignment: CrossAxisAlignment.end,
// //                     children: [
// //                       Text(
// //                         'Balance',
// //                         style: Theme.of(context).textTheme.bodyMedium!.copyWith(
// //                           color: Colors.yellow.shade700,
// //                         ),
// //                       ),
// //                       Text(
// //                         NumberFormat.currency(
// //                           symbol: '',
// //                           decimalDigits: 0,
// //                         ).format(balance),
// //                         style: Theme.of(context).textTheme.titleMedium!
// //                             .copyWith(color: Colors.yellow.shade700),
// //                       ),
// //                     ],
// //                   ),
// //                 ],
// //               ),
// //             ],
// //           ),
// //           const SizedBox(height: 10),
// //           // Alert message
// //           Card(
// //             color: Colors.red.shade900.withOpacity(0.3),
// //             shape: RoundedRectangleBorder(
// //               borderRadius: BorderRadius.circular(8),
// //             ),
// //             child: Padding(
// //               padding: const EdgeInsets.all(8.0),
// //               child: Row(
// //                 children: [
// //                   Icon(
// //                     Icons.info_outline,
// //                     color: Colors.red.shade300,
// //                     size: 20,
// //                   ),
// //                   const SizedBox(width: 8),
// //                   Expanded(
// //                     child: Text(
// //                       'After logging in, you can back up your data in real time!',
// //                       style: Theme.of(context).textTheme.bodySmall!.copyWith(
// //                         color: Colors.red.shade200,
// //                       ),
// //                     ),
// //                   ),
// //                 ],
// //               ),
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }

// //   Widget _buildTransactionTile(
// //     BuildContext context,
// //     Transaction transaction,
// //     WidgetRef ref,
// //   ) {
// //     return Card(
// //       margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
// //       child: ListTile(
// //         leading: CircleAvatar(
// //           backgroundColor:
// //               transaction.type == TransactionType.expense
// //                   ? Colors.red.shade700.withOpacity(0.2)
// //                   : Colors.green.shade700.withOpacity(0.2),
// //           child: Icon(
// //             _getCategoryIcon(transaction.category),
// //             color:
// //                 transaction.type == TransactionType.expense
// //                     ? Colors.redAccent
// //                     : Colors.greenAccent,
// //           ),
// //         ),
// //         title: Text(
// //           transaction.category,
// //           style: Theme.of(
// //             context,
// //           ).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),
// //         ),
// //         subtitle: Text(
// //           transaction.description ??
// //               DateFormat('dd MMM').format(transaction.date),
// //           style: Theme.of(
// //             context,
// //           ).textTheme.bodyMedium!.copyWith(color: Colors.grey.shade400),
// //         ),
// //         trailing: Text(
// //           '${transaction.type == TransactionType.expense ? '-' : '+'}${NumberFormat.currency(symbol: '', decimalDigits: 0).format(transaction.amount)}',
// //           style: Theme.of(context).textTheme.titleMedium!.copyWith(
// //             color:
// //                 transaction.type == TransactionType.expense
// //                     ? Colors.redAccent
// //                     : Colors.greenAccent,
// //             fontWeight: FontWeight.bold,
// //           ),
// //         ),
// //         onLongPress: () {
// //           // Option to delete transaction
// //           showDialog(
// //             context: context,
// //             builder:
// //                 (ctx) => AlertDialog(
// //                   title: const Text('Delete Transaction?'),
// //                   content: Text(
// //                     'Are you sure you want to delete ${transaction.category} transaction of ${NumberFormat.currency(symbol: '', decimalDigits: 0).format(transaction.amount)}?',
// //                   ),
// //                   actions: [
// //                     TextButton(
// //                       onPressed: () => Navigator.of(ctx).pop(),
// //                       child: const Text('Cancel'),
// //                     ),
// //                     TextButton(
// //                       onPressed: () {
// //                         ref
// //                             .read(transactionsProvider.notifier)
// //                             .removeTransaction(transaction.id);
// //                         Navigator.of(ctx).pop();
// //                       },
// //                       child: const Text(
// //                         'Delete',
// //                         style: TextStyle(color: Colors.red),
// //                       ),
// //                     ),
// //                   ],
// //                 ),
// //           );
// //         },
// //       ),
// //     );
// //   }

// //   IconData _getCategoryIcon(String category) {
// //     switch (category.toLowerCase()) {
// //       case 'food':
// //         return Icons.fastfood;
// //       case 'shopping':
// //         return Icons.shopping_bag;
// //       case 'donations':
// //         return Icons.favorite;
// //       case 'beauty':
// //         return Icons.spa;
// //       case 'lottery':
// //         return Icons.casino;
// //       case 'salary':
// //         return Icons.account_balance_wallet;
// //       case 'part-time':
// //         return Icons.work;
// //       case 'burger':
// //         return Icons.lunch_dining;
// //       default:
// //         return Icons.category;
// //     }
// //   }
// // }

// // // -----------------------------------------------------------------------------
// // // 6. Charts Screen
// // // -----------------------------------------------------------------------------

// // class ChartsScreen extends ConsumerWidget {
// //   const ChartsScreen({super.key});

// //   @override
// //   Widget build(BuildContext context, WidgetRef ref) {
// //     final transactions = ref.watch(transactionsProvider);
// //     final selectedDate = ref.watch(selectedChartDateProvider);
// //     final chartType = ref.watch(chartTypeProvider);

// //     // Filter transactions for the selected month/year
// //     final filteredTransactions =
// //         transactions
// //             .where(
// //               (t) =>
// //                   t.date.month == selectedDate.month &&
// //                   t.date.year == selectedDate.year &&
// //                   t.type == chartType,
// //             )
// //             .toList();

// //     // Group by category and sum amounts
// //     final Map<String, double> categorySums = {};
// //     for (var t in filteredTransactions) {
// //       categorySums.update(
// //         t.category,
// //         (value) => value + t.amount,
// //         ifAbsent: () => t.amount,
// //       );
// //     }

// //     final totalAmount = categorySums.values.fold(
// //       0.0,
// //       (sum, amount) => sum + amount,
// //     );

// //     // Prepare data for PieChart
// //     List<PieChartSectionData> pieChartSections = [];
// //     if (totalAmount > 0) {
// //       categorySums.forEach((category, amount) {
// //         final percentage = (amount / totalAmount) * 100;
// //         pieChartSections.add(
// //           PieChartSectionData(
// //             color: _getCategoryColor(
// //               category,
// //             ), // Assign a color to each category
// //             value: amount,
// //             title: '${percentage.toStringAsFixed(1)}%',
// //             radius: 80,
// //             titleStyle: const TextStyle(
// //               fontSize: 14,
// //               fontWeight: FontWeight.bold,
// //               color: Colors.black, // Text color on pie slices
// //             ),
// //             badgeWidget: _buildCategoryBadge(
// //               category,
// //               amount,
// //             ), // Custom badge for category
// //             badgePositionPercentageOffset: 1.2,
// //           ),
// //         );
// //       });
// //     }

// //     // Sort categories by amount for the list view
// //     final sortedCategories =
// //         categorySums.entries.toList()
// //           ..sort((a, b) => b.value.compareTo(a.value));

// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text(
// //           chartType == TransactionType.expense ? 'Expenses' : 'Income',
// //         ),
// //         actions: [
// //           IconButton(
// //             icon: const Icon(Icons.swap_horiz),
// //             onPressed: () {
// //               // Toggle chart type
// //               ref.read(chartTypeProvider.notifier).state =
// //                   chartType == TransactionType.expense
// //                       ? TransactionType.income
// //                       : TransactionType.expense;
// //             },
// //             tooltip: 'Toggle Expense/Income',
// //           ),
// //         ],
// //       ),
// //       body: Column(
// //         children: [
// //           // Month/Year Selector
// //           _buildChartDateSelector(context, ref, selectedDate),
// //           const SizedBox(height: 20),
// //           // MyPieChart(
// //           //   pieChartSections: pieChartSections,
// //           //   totalAmount: totalAmount,
// //           // ),
// //           // Pie Chart Section
// //           SizedBox(
// //             height: 250,
// //             child: PieChart(
// //               PieChartData(
// //                 sections: pieChartSections,
// //                 centerSpaceRadius: 60,
// //                 sectionsSpace: 2,
// //                 borderData: FlBorderData(show: false),
// //                 // Show total amount in the center
// //                 // centerWidget: Text(
// //                 //   NumberFormat.currency(symbol: '', decimalDigits: 0).format(totalAmount),
// //                 //   style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.white),
// //                 // ),
// //               ),
// //             ),
// //           ),
// //           const SizedBox(height: 20),
// //           // Category List with Progress Bars
// //           Expanded(
// //             child: ListView.builder(
// //               itemCount: sortedCategories.length,
// //               itemBuilder: (context, index) {
// //                 final entry = sortedCategories[index];
// //                 final category = entry.key;
// //                 final amount = entry.value;
// //                 final percentage = (amount / totalAmount) * 100;

// //                 return Card(
// //                   margin: const EdgeInsets.symmetric(
// //                     horizontal: 16.0,
// //                     vertical: 4.0,
// //                   ),
// //                   child: Padding(
// //                     padding: const EdgeInsets.all(12.0),
// //                     child: Column(
// //                       crossAxisAlignment: CrossAxisAlignment.start,
// //                       children: [
// //                         Row(
// //                           children: [
// //                             CircleAvatar(
// //                               radius: 12,
// //                               backgroundColor: _getCategoryColor(category),
// //                             ),
// //                             const SizedBox(width: 10),
// //                             Text(
// //                               category,
// //                               style: Theme.of(context).textTheme.titleMedium!
// //                                   .copyWith(fontWeight: FontWeight.bold),
// //                             ),
// //                             const Spacer(),
// //                             Text(
// //                               '${percentage.toStringAsFixed(1)}%',
// //                               style: Theme.of(context).textTheme.bodyMedium!
// //                                   .copyWith(color: Colors.grey.shade400),
// //                             ),
// //                             const SizedBox(width: 10),
// //                             Text(
// //                               NumberFormat.currency(
// //                                 symbol: '',
// //                                 decimalDigits: 0,
// //                               ).format(amount),
// //                               style: Theme.of(context).textTheme.titleMedium!
// //                                   .copyWith(fontWeight: FontWeight.bold),
// //                             ),
// //                           ],
// //                         ),
// //                         const SizedBox(height: 8),
// //                         LinearProgressIndicator(
// //                           value: percentage / 100,
// //                           backgroundColor: Colors.grey.shade800,
// //                           color: _getCategoryColor(category),
// //                           minHeight: 5,
// //                           borderRadius: BorderRadius.circular(5),
// //                         ),
// //                       ],
// //                     ),
// //                   ),
// //                 );
// //               },
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }

// //   Widget _buildChartDateSelector(
// //     BuildContext context,
// //     WidgetRef ref,
// //     DateTime selectedDate,
// //   ) {
// //     return Container(
// //       padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
// //       color: Theme.of(context).appBarTheme.backgroundColor,
// //       child: Row(
// //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //         children: [
// //           IconButton(
// //             icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
// //             onPressed: () {
// //               ref.read(selectedChartDateProvider.notifier).state = DateTime(
// //                 selectedDate.year,
// //                 selectedDate.month - 1,
// //                 selectedDate.day,
// //               );
// //             },
// //           ),
// //           Text(
// //             DateFormat('MMM yyyy').format(selectedDate),
// //             style: Theme.of(
// //               context,
// //             ).textTheme.titleLarge!.copyWith(color: Colors.white),
// //           ),
// //           IconButton(
// //             icon: const Icon(Icons.arrow_forward_ios, color: Colors.white),
// //             onPressed: () {
// //               ref.read(selectedChartDateProvider.notifier).state = DateTime(
// //                 selectedDate.year,
// //                 selectedDate.month + 1,
// //                 selectedDate.day,
// //               );
// //             },
// //           ),
// //         ],
// //       ),
// //     );
// //   }

// //   Widget _buildCategoryBadge(String category, double amount) {
// //     return Container(
// //       padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
// //       decoration: BoxDecoration(
// //         color: _getCategoryColor(category),
// //         borderRadius: BorderRadius.circular(8),
// //         border: Border.all(color: Colors.white, width: 1),
// //       ),
// //       child: Text(
// //         category,
// //         style: const TextStyle(
// //           color: Colors.black,
// //           fontSize: 10,
// //           fontWeight: FontWeight.bold,
// //         ),
// //       ),
// //     );
// //   }

// //   Color _getCategoryColor(String category) {
// //     // A simple way to assign consistent colors to categories
// //     final int hash = category.hashCode;
// //     final List<Color> colors = [
// //       Colors.blueAccent,
// //       Colors.greenAccent,
// //       Colors.orangeAccent,
// //       Colors.purpleAccent,
// //       Colors.redAccent,
// //       Colors.tealAccent,
// //       Colors.indigoAccent,
// //       Colors.pinkAccent,
// //       Colors.cyanAccent,
// //       Colors.limeAccent,
// //     ];
// //     return colors[hash % colors.length];
// //   }
// // }

// // // class MyPieChart extends StatelessWidget {
// // //   final List<PieChartSectionData> pieChartSections;
// // //   final double totalAmount;

// // //   const MyPieChart({
// // //     super.key,
// // //     required this.pieChartSections,
// // //     required this.totalAmount,
// // //   });

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Stack(
// // //       alignment: Alignment.center,
// // //       children: [
// // //         PieChart(
// // //           PieChartData(
// // //             sections: pieChartSections,
// // //             centerSpaceRadius: 60,
// // //             sectionsSpace: 2,
// // //             borderData: FlBorderData(show: false),
// // //           ),
// // //         ),
// // //         Text(
// // //           NumberFormat.currency(
// // //             symbol: '',
// // //             decimalDigits: 0,
// // //           ).format(totalAmount),
// // //           style: Theme.of(
// // //             context,
// // //           ).textTheme.titleLarge!.copyWith(color: Colors.black),
// // //         ),
// // //       ],
// // //     );
// // //   }
// // // }

// // main.dart
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:money_manager_app/presentation/screens/splash.dart';

// void main() async{
//   //  await SystemChrome.setPreferredOrientations([
//   //   DeviceOrientation.portraitUp,
//   //   DeviceOrientation.portraitDown,
//   // ]);
//   runApp(
//     const ProviderScope(
//       // Wrap the app with ProviderScope for Riverpod
//       child: MoneyTrackerApp(),
//     ),
//   );
// }

// class MoneyTrackerApp extends ConsumerWidget {
//   const MoneyTrackerApp({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return GetMaterialApp(
//       title: 'Money Tracker',
//       debugShowCheckedModeBanner: false,
//       theme:
//       // ThemeData(
//       //   primarySwatch: Colors.yellow, // Primary color for accents
//       //   scaffoldBackgroundColor: const Color(0xFF1C1C1C), // Dark background
//       //   appBarTheme: const AppBarTheme(
//       //     backgroundColor: Color(0xFF1C1C1C),
//       //     elevation: 0,
//       //     titleTextStyle: TextStyle(
//       //       color: Colors.white,
//       //       fontSize: 20,
//       //       fontWeight: FontWeight.bold,
//       //     ),
//       //     iconTheme: IconThemeData(color: Colors.white),
//       //   ),
//       //   bottomNavigationBarTheme: BottomNavigationBarThemeData(
//       //     backgroundColor: const Color(0xFF2C2C2C), // Darker bottom nav
//       //     selectedItemColor: Colors.yellow.shade700, // Yellow for selected
//       //     unselectedItemColor: Colors.grey, // Grey for unselected
//       //     type: BottomNavigationBarType.fixed, // Fixed type to show all labels
//       //     selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
//       //   ),
//       //   floatingActionButtonTheme: FloatingActionButtonThemeData(
//       //     backgroundColor: Colors.yellow.shade700, // Yellow FAB
//       //     foregroundColor: Colors.black, // Black icon on FAB
//       //     shape: const CircleBorder(), // Circular FAB
//       //   ),
//       //   cardTheme: CardTheme(
//       //     color: const Color(0xFF2C2C2C), // Darker card background
//       //     elevation: 4,
//       //     shape: RoundedRectangleBorder(
//       //       borderRadius: BorderRadius.circular(12),
//       //     ),
//       //   ),
//       //   textTheme: const TextTheme(
//       //     bodyLarge: TextStyle(color: Colors.white),
//       //     bodyMedium: TextStyle(color: Colors.white70),
//       //     titleLarge: TextStyle(
//       //       color: Colors.white,
//       //       fontWeight: FontWeight.bold,
//       //     ),
//       //     titleMedium: TextStyle(color: Colors.white),
//       //     labelLarge: TextStyle(color: Colors.white),
//       //   ),
//       //   dividerColor: Colors.grey.shade800, // Subtle dividers
//       //   colorScheme: ColorScheme.fromSwatch(
//       //     primarySwatch: Colors.yellow,
//       //   ).copyWith(
//       //     secondary: Colors.yellow.shade700, // Accent color
//       //     background: const Color(0xFF1C1C1C), // Background color
//       //   ),
//       // ),
//       ThemeData(
//         // Primary color for accents - A shade of green/teal as seen in the image for accents
//         primarySwatch: Colors.teal, // This will generate various shades of teal
//         // Scaffold background color - Light grey/white as in the image
//         scaffoldBackgroundColor: const Color(
//           0xFFF0F2F5,
//         ),
//  // A very light grey/off-white

//         appBarTheme: const AppBarTheme(
//           // AppBar background color - White as in the image
//           backgroundColor: Colors.white,
//           elevation: 0, // No shadow for a flat look
//           titleTextStyle: TextStyle(
//             color: Colors.black, // Dark text for app bar title
//             fontSize: 20,
//             fontWeight: FontWeight.bold,
//           ),
//           iconTheme: IconThemeData(
//             color: Colors.black,
//           ), // Dark icons for app bar
//         ),

//         bottomNavigationBarTheme: BottomNavigationBarThemeData(
//           // Bottom nav background - White
//           backgroundColor: Colors.white,
//           // Selected item color - A green/teal shade similar to the income card
//           selectedItemColor: const Color(
//             0xFF116D6E,
//           ), // The teal from your balance card
//           // Unselected item color - Grey for contrast
//           unselectedItemColor: Colors.grey.shade600,
//           type: BottomNavigationBarType.fixed,
//           selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
//         ),

//         floatingActionButtonTheme: FloatingActionButtonThemeData(
//           // FAB background color - Green/Teal from the image
//           backgroundColor: const Color(0xFF116D6E), // Matches the card color
//           foregroundColor: Colors.white, // White icon on FAB
//           shape: const CircleBorder(), // Circular FAB
//         ),

//         cardTheme: CardTheme(
//           // Card background color - White
//           color: Colors.white,
//           elevation: 2, // Slight elevation for cards
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(12),
//           ),
//         ),
//                               textTheme: GoogleFonts.robotoCondensedTextTheme(),


//         // textTheme: const TextTheme(
         

//         //   // Default text colors for various text styles
//         //   bodyLarge: TextStyle(
//         //     color: Colors.black87,
//         //   ), // Darker text for main content
//         //   bodyMedium: TextStyle(
//         //     color: Colors.black54,
//         //   ), // Slightly lighter dark text
//         //   titleLarge: TextStyle(
//         //     color: Colors.black, // Dark for large titles
//         //     fontWeight: FontWeight.bold,
//         //   ),
//         //   titleMedium: TextStyle(color: Colors.black), // Dark for medium titles
//         //   labelLarge: TextStyle(color: Colors.black87), // Dark for labels
//         // ),

//         dividerColor: Colors.grey.shade300, // Light grey dividers

//         colorScheme: ColorScheme.fromSwatch(
//           // Use teal as the primary swatch for the light theme
//           primarySwatch: Colors.teal,
//         ).copyWith(
//           // Accent color - The teal from the balance card/FAB
//           secondary: const Color(0xFF116D6E),
//           // Background color - Consistent with scaffold background
//           background: const Color(0xFFF0F2F5),
//           // Adjust onSurface for text on cards, etc., if needed
//           onSurface: Colors.black87,
//           // Adjust surface for card-like elements
//           surface: Colors.white,
//         ),
//       ),
//       //  home: const MainScreen(),
//       home: const PreScreen(),
//     );
//   }
// }
