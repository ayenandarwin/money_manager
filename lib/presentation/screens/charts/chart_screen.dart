// // lib/presentation/screens/charts/charts_screen.dart
// import 'package:flutter/material.dart';
// import 'package:money_manager_app/core/constants/app_color.dart';
// import 'package:money_manager_app/data/model/category_summary.dart';
// import 'package:money_manager_app/data/model/transaction.dart';
// import 'package:money_manager_app/presentation/comon_widget/chart_category_item.dart';
// import 'package:money_manager_app/presentation/screens/charts/category_legend.dart';
// import 'package:money_manager_app/presentation/screens/home/widgets/pie_chart';

// class ChartsScreen extends StatefulWidget {
//   const ChartsScreen({super.key});

//   @override
//   State<ChartsScreen> createState() => _ChartsScreenState();
// }

// class _ChartsScreenState extends State<ChartsScreen> {
//   // Dummy Data for demonstration
//   final List<Transaction> _allTransactions = [
//     Transaction(
//       id: 't1',
//       date: DateTime(2025, 5, 1),
//       type: TransactionType.expense,
//       amount: 20000,
//       category: 'Food',
//       icon: Icons.fastfood,
//     ),
//     Transaction(
//       id: 't2',
//       date: DateTime(2025, 5, 5),
//       type: TransactionType.expense,
//       amount: 5000,
//       category: 'Food',
//       icon: Icons.fastfood,
//     ),
//     Transaction(
//       id: 't3',
//       date: DateTime(2025, 5, 10),
//       type: TransactionType.expense,
//       amount: 10000,
//       category: 'Shopping',
//       icon: Icons.shopping_bag,
//     ),
//     Transaction(
//       id: 't4',
//       date: DateTime(2025, 5, 15),
//       type: TransactionType.expense,
//       amount: 2000,
//       category: 'Beauty',
//       icon: Icons.brush,
//     ),
//     Transaction(
//       id: 't5',
//       date: DateTime(2025, 5, 20),
//       type: TransactionType.expense,
//       amount: 15000,
//       category: 'Donations',
//       icon: Icons.favorite,
//     ),
//     Transaction(
//       id: 't6',
//       date: DateTime(2025, 5, 25),
//       type: TransactionType.expense,
//       amount: 8000,
//       category: 'Shopping',
//       icon: Icons.shopping_bag,
//     ),
//     Transaction(
//       id: 't7',
//       date: DateTime(2025, 5, 28),
//       type: TransactionType.expense,
//       amount: 20000,
//       category: 'Donations',
//       icon: Icons.favorite,
//     ),
//     Transaction(
//       id: 't8',
//       date: DateTime(2025, 5, 30),
//       type: TransactionType.expense,
//       amount: 15000,
//       category: 'Other',
//       icon: Icons.category,
//     ),
//     Transaction(
//       id: 't9',
//       date: DateTime(2025, 5, 12),
//       type: TransactionType.expense,
//       amount: 100000,
//       category: 'Food',
//       icon: Icons.fastfood,
//     ),
//     Transaction(
//       id: 't10',
//       date: DateTime(2025, 5, 18),
//       type: TransactionType.expense,
//       amount: 80000,
//       category: 'Shopping',
//       icon: Icons.shopping_bag,
//     ),
//     Transaction(
//       id: 't11',
//       date: DateTime(2025, 5, 22),
//       type: TransactionType.expense,
//       amount: 60000,
//       category: 'Donations',
//       icon: Icons.favorite,
//     ),
//     Transaction(
//       id: 't12',
//       date: DateTime(2025, 5, 26),
//       type: TransactionType.expense,
//       amount: 50000,
//       category: 'Beauty',
//       icon: Icons.brush,
//     ),
//     Transaction(
//       id: 't13',
//       date: DateTime(2025, 5, 29),
//       type: TransactionType.expense,
//       amount: 15000,
//       category: 'Lottery',
//       icon: Icons.casino,
//     ),
//     // ... more dummy data
//   ];

//   String _selectedPeriod =
//       'This Month'; // 'This Month', 'Last Month', 'May 2025', '2025'
//   bool _isMonthView = true; // Toggle between Month and Year

//   List<CategorySummary> _getCategorySummaries() {
//     // Filter transactions based on selected period
//     List<Transaction> filteredTransactions =
//         _allTransactions.where((t) {
//           if (_selectedPeriod == 'This Month') {
//             return t.date.month == DateTime.now().month &&
//                 t.date.year == DateTime.now().year;
//           } else if (_selectedPeriod == 'Last Month') {
//             // Calculate last month
//             DateTime now = DateTime.now();
//             DateTime lastMonth = DateTime(now.year, now.month - 1, 1);
//             return t.date.month == lastMonth.month &&
//                 t.date.year == lastMonth.year;
//           } else if (_selectedPeriod.contains('2025') &&
//               _selectedPeriod.length == 4) {
//             // Specific Year
//             return t.date.year == int.parse(_selectedPeriod);
//           } else if (_selectedPeriod.contains('2025')) {
//             // Specific Month (e.g., 'May 2025')
//             String monthName = _selectedPeriod.split(' ')[0];
//             int monthNum = _getMonthNumber(monthName);
//             return t.date.month == monthNum && t.date.year == 2025;
//           }
//           return false; // Default
//         }).toList();

//     // Group transactions by category and calculate totals
//     Map<String, int> categoryTotals = {};
//     int totalExpenses = 0;

//     for (var t in filteredTransactions.where(
//       (tr) => tr.type == TransactionType.expense,
//     )) {
//       categoryTotals.update(
//         t.category,
//         (value) => value + t.amount,
//         ifAbsent: () => t.amount,
//       );
//       totalExpenses += t.amount;
//     }

//     if (totalExpenses == 0) return []; // Avoid division by zero

//     List<CategorySummary> summaries = [];
//     List<Color> pieColors = [
//       // Defined colors for pie chart
//       Colors.green,
//       Colors.blue,
//       Colors.orange,
//       Colors.purple,
//       Colors.red,
//       Colors.teal,
//       Colors.brown, Colors.pink, Colors.amber, Colors.cyan,
//     ];
//     int colorIndex = 0;

//     // Sort categories by amount descending to match the image
//     List<MapEntry<String, int>> sortedCategories =
//         categoryTotals.entries.toList()
//           ..sort((a, b) => b.value.compareTo(a.value));

//     for (var entry in sortedCategories) {
//       final category = entry.key;
//       final amount = entry.value;
//       final percentage = (amount / totalExpenses) * 100;

//       // Find icon (you might need a map for this if you have many categories)
//       IconData icon = Icons.category; // Default icon
//       if (category == 'Food') icon = Icons.fastfood;
//       if (category == 'Shopping') icon = Icons.shopping_bag;
//       if (category == 'Donations') icon = Icons.favorite;
//       if (category == 'Beauty') icon = Icons.brush;
//       if (category == 'Lottery') icon = Icons.casino;
//       if (category == 'Other') icon = Icons.dashboard;

//       summaries.add(
//         CategorySummary(
//           category: category,
//           icon: icon,
//           percentage: percentage,
//           amount: amount,
//           color: pieColors[colorIndex % pieColors.length], // Assign a color
//         ),
//       );
//       colorIndex++;
//     }

//     return summaries;
//   }

//   int _getMonthNumber(String monthName) {
//     switch (monthName) {
//       case 'Jan':
//         return 1;
//       case 'Feb':
//         return 2;
//       case 'Mar':
//         return 3;
//       case 'Apr':
//         return 4;
//       case 'May':
//         return 5;
//       case 'Jun':
//         return 6;
//       case 'Jul':
//         return 7;
//       case 'Aug':
//         return 8;
//       case 'Sep':
//         return 9;
//       case 'Oct':
//         return 10;
//       case 'Nov':
//         return 11;
//       case 'Dec':
//         return 12;
//       default:
//         return DateTime.now().month;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final List<CategorySummary> categorySummaries = _getCategorySummaries();
//     final int totalExpenses = categorySummaries.fold(
//       0,
//       (sum, item) => sum + item.amount,
//     );

//     return Scaffold(
//       appBar: AppBar(
//         title: DropdownButtonHideUnderline(
//           child: DropdownButton<String>(
//             value: 'Expenses', // Default value from screenshot
//             icon: const Icon(
//               Icons.keyboard_arrow_down,
//               color: AppColors.primaryText,
//             ),
//             dropdownColor: AppColors.bottomNavBackground,
//             style: const TextStyle(
//               color: AppColors.primaryText,
//               fontSize: 18,
//               fontWeight: FontWeight.bold,
//             ),
//             onChanged: (String? newValue) {
//               // TODO: Handle 'Expenses' vs 'Income' view
//             },
//             items:
//                 const <String>[
//                   'Expenses',
//                   'Income',
//                 ].map<DropdownMenuItem<String>>((String value) {
//                   return DropdownMenuItem<String>(
//                     value: value,
//                     child: Text(value),
//                   );
//                 }).toList(),
//           ),
//         ),
//         centerTitle: true,
//         actions: [
//           Container(
//             margin: const EdgeInsets.symmetric(horizontal: 8.0),
//             padding: const EdgeInsets.all(4.0),
//             decoration: BoxDecoration(
//               color:
//                   AppColors
//                       .bottomNavBackground, // A slightly different background
//               borderRadius: BorderRadius.circular(20.0),
//             ),
//             child: ToggleButtons(
//               isSelected: [_isMonthView, !_isMonthView],
//               onPressed: (int index) {
//                 setState(() {
//                   _isMonthView = index == 0;
//                   // Update _selectedPeriod based on toggle
//                   if (_isMonthView) {
//                     _selectedPeriod = 'This Month';
//                   } else {
//                     _selectedPeriod =
//                         '2025'; // Default to current year for year view
//                   }
//                 });
//               },
//               fillColor: AppColors.accentColor.withOpacity(0.3),
//               selectedColor: AppColors.primaryText,
//               color: AppColors.secondaryText,
//               borderColor: Colors.transparent,
//               selectedBorderColor: Colors.transparent,
//               splashColor: Colors.transparent,
//               highlightColor: Colors.transparent,
//               borderRadius: BorderRadius.circular(20.0),
//               children: const [
//                 Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 12.0),
//                   child: Text('Month', style: TextStyle(fontSize: 13)),
//                 ),
//                 Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 12.0),
//                   child: Text('Year', style: TextStyle(fontSize: 13)),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//       body: Column(
//         children: [
//           // Time Period Selector
//           Container(
//             height: 50, // Height for the horizontal scroll
//             color: AppColors.primaryBackground,
//             child: ListView(
//               scrollDirection: Axis.horizontal,
//               children: [
//                 _buildPeriodTab('2025'),
//                 _buildPeriodTab('May 2025'),
//                 _buildPeriodTab('Last Month'),
//                 _buildPeriodTab('This Month'),
//                 // Add more periods if needed
//               ],
//             ),
//           ),
//           const SizedBox(height: 16),
//           // Pie Chart and Legend
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16.0),
//             child: Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Expanded(
//                   flex: 2,
//                   child: PieChartWidget(
//                     totalAmount: totalExpenses,
//                     categorySummaries: categorySummaries,
//                   ),
//                 ),
//                 Expanded(
//                   flex: 3,
//                   child: CategoryLegend(categorySummaries: categorySummaries),
//                 ),
//               ],
//             ),
//           ),
//           const SizedBox(height: 24),
//           // Detailed Category List
//           Expanded(
//             child: ListView.builder(
//               padding: const EdgeInsets.symmetric(horizontal: 16.0),
//               itemCount: categorySummaries.length,
//               itemBuilder: (context, index) {
//                 return ChartCategoryItem(summary: categorySummaries[index]);
//               },
//             ),
//           ),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           // Handle add new transaction
//         },
//         shape: const CircleBorder(),
//         child: const Icon(Icons.add),
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//       bottomNavigationBar: BottomAppBar(
//         color: AppColors.bottomNavBackground,
//         shape: const CircularNotchedRectangle(),
//         notchMargin: 8.0,
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: [
//             _buildBottomNavItem(0, Icons.assignment, 'Records'),
//             _buildBottomNavItem(
//               1,
//               Icons.bar_chart,
//               'Charts',
//             ), // Charts is selected
//             const SizedBox(width: 48), // Space for the FAB
//             _buildBottomNavItem(2, Icons.description, 'Reports'),
//             _buildBottomNavItem(3, Icons.person, 'Me'),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildPeriodTab(String title) {
//     final bool isSelected = _selectedPeriod == title;
//     return GestureDetector(
//       onTap: () {
//         setState(() {
//           _selectedPeriod = title;
//         });
//       },
//       child: Container(
//         alignment: Alignment.center,
//         padding: const EdgeInsets.symmetric(horizontal: 20.0),
//         decoration: BoxDecoration(
//           color:
//               isSelected
//                   ? AppColors.accentColor.withOpacity(0.3)
//                   : Colors.transparent,
//           borderRadius: BorderRadius.circular(20.0),
//         ),
//         child: Text(
//           title,
//           style: TextStyle(
//             color: isSelected ? AppColors.primaryText : AppColors.secondaryText,
//             fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildBottomNavItem(int index, IconData icon, String label) {
//     // For Bottom Nav Bar, Charts is at index 1
//     final int selectedIndex = 1; // Charts is selected by default in this screen
//     return Expanded(
//       child: InkWell(
//         onTap: () {
//           setState(() {
//             // _currentIndex = index; // If this was a common nav bar
//             // Handle navigation logic here (e.g., Navigator.push to other screens)
//             // if (index == 0) {
//             //   Navigator.pushReplacement(
//             //     context,
//             //     MaterialPageRoute(builder: (context) => const HomeScreen()),
//             //   );
//             // }
//           });
//         },
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(
//               icon,
//               color:
//                   index == selectedIndex
//                       ? AppColors.accentColor
//                       : AppColors.secondaryText,
//             ),
//             Text(
//               label,
//               style: TextStyle(
//                 color:
//                     index == selectedIndex
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
