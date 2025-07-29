// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:fl_chart/fl_chart.dart';

// class ExpenseChartApp extends StatelessWidget {
//   const ExpenseChartApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return ScreenUtilInit(
//       designSize: const Size(390, 844),
//       builder:
//           (_, __) => const MaterialApp(
//             home: ExpenseChartScreen(),
//             debugShowCheckedModeBanner: false,
//           ),
//     );
//   }
// }

// class ExpenseChartScreen extends StatelessWidget {
//   const ExpenseChartScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       bottomNavigationBar: BottomNavigationBar(
//         backgroundColor: Colors.black,
//         selectedItemColor: Colors.yellow,
//         unselectedItemColor: Colors.white,
//         currentIndex: 1,
//         items: const [
//           BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Records'),
//           BottomNavigationBarItem(icon: Icon(Icons.pie_chart), label: 'Charts'),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.add_circle, size: 35),
//             label: '',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.insert_drive_file),
//             label: 'Reports',
//           ),
//           BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Me'),
//         ],
//       ),
//       body: SafeArea(
//         child: Padding(
//           padding: EdgeInsets.all(16.w),
//           child: Column(
//             children: [
//               // Title and filter
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   const Text(
//                     "Expenses",
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 22,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   DropdownButton<String>(
//                     value: "Month",
//                     dropdownColor: Colors.grey[900],
//                     icon: const Icon(
//                       Icons.keyboard_arrow_down,
//                       color: Colors.white,
//                     ),
//                     items: const [
//                       DropdownMenuItem(
//                         value: "Month",
//                         child: Text(
//                           "Month",
//                           style: TextStyle(color: Colors.white),
//                         ),
//                       ),
//                       DropdownMenuItem(
//                         value: "Year",
//                         child: Text(
//                           "Year",
//                           style: TextStyle(color: Colors.white),
//                         ),
//                       ),
//                     ],
//                     onChanged: (_) {},
//                   ),
//                 ],
//               ),
//               SizedBox(height: 10.h),

//               // Tab section
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: const [
//                   Text("2025", style: TextStyle(color: Colors.white70)),
//                   Text("May 2025", style: TextStyle(color: Colors.white70)),
//                   Text("Last Month", style: TextStyle(color: Colors.white70)),
//                   Text(
//                     "This Month",
//                     style: TextStyle(
//                       color: Colors.yellow,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 20.h),

//               // Pie Chart
//               SizedBox(
//                 height: 180.h,
//                 child: PieChart(
//                   PieChartData(
//                     sections: [
//                       PieChartSectionData(
//                         color: Colors.yellow,
//                         value: 48.03,
//                         title: '',
//                         radius: 50.r,
//                       ),
//                       PieChartSectionData(
//                         color: Colors.lightBlue,
//                         value: 23.09,
//                         title: '',
//                         radius: 50.r,
//                       ),
//                       PieChartSectionData(
//                         color: Colors.pink,
//                         value: 13.85,
//                         title: '',
//                         radius: 50.r,
//                       ),
//                       PieChartSectionData(
//                         color: Colors.teal,
//                         value: 11.54,
//                         title: '',
//                         radius: 50.r,
//                       ),
//                       PieChartSectionData(
//                         color: Colors.green,
//                         value: 3.46,
//                         title: '',
//                         radius: 50.r,
//                       ),
//                     ],
//                     centerSpaceRadius: 40.r,
//                     centerSpaceColor: Colors.black,
//                   ),
//                 ),
//               ),
//               Text(
//                 "433,000",
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 20.sp,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               SizedBox(height: 20.h),

//               // Category details
//               Expanded(
//                 child: ListView(
//                   children: const [
//                     CategoryTile(
//                       name: 'Food',
//                       percent: 48.03,
//                       amount: '208,000',
//                       color: Colors.yellow,
//                       icon: Icons.restaurant,
//                     ),
//                     CategoryTile(
//                       name: 'Shopping',
//                       percent: 23.09,
//                       amount: '100,000',
//                       color: Colors.yellow,
//                       icon: Icons.shopping_cart,
//                     ),
//                     CategoryTile(
//                       name: 'Donations',
//                       percent: 13.85,
//                       amount: '60,000',
//                       color: Colors.yellow,
//                       icon: Icons.favorite,
//                     ),
//                     CategoryTile(
//                       name: 'Beauty',
//                       percent: 11.54,
//                       amount: '50,000',
//                       color: Colors.yellow,
//                       icon: Icons.face,
//                     ),
//                     CategoryTile(
//                       name: 'Lottery',
//                       percent: 3.46,
//                       amount: '15,000',
//                       color: Colors.yellow,
//                       icon: Icons.sports_esports,
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class CategoryTile extends StatelessWidget {
//   final String name;
//   final double percent;
//   final String amount;
//   final Color color;
//   final IconData icon;

//   const CategoryTile({
//     super.key,
//     required this.name,
//     required this.percent,
//     required this.amount,
//     required this.color,
//     required this.icon,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.symmetric(vertical: 8.h),
//       child: Row(
//         children: [
//           CircleAvatar(
//             backgroundColor: color.withOpacity(0.2),
//             child: Icon(icon, color: Colors.white),
//           ),
//           SizedBox(width: 10.w),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   '$name  ${percent.toStringAsFixed(2)}%',
//                   style: const TextStyle(color: Colors.white),
//                 ),
//                 SizedBox(height: 5.h),
//                 LinearProgressIndicator(
//                   value: percent / 100,
//                   color: color,
//                   backgroundColor: Colors.white24,
//                   minHeight: 6.h,
//                 ),
//               ],
//             ),
//           ),
//           SizedBox(width: 10.w),
//           Text(amount, style: const TextStyle(color: Colors.white)),
//         ],
//       ),
//     );
//   }
// }
