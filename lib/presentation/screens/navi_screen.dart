// 4. Main Screen with Bottom Navigation
// -----------------------------------------------------------------------------

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:money_manager_app/presentation/screens/add_transaction.dart';
import 'package:money_manager_app/presentation/screens/chart.dart';
import 'package:money_manager_app/presentation/screens/profile.dart';
import 'package:money_manager_app/presentation/screens/record.dart';
import 'package:money_manager_app/provider/common.dart';

class MainScreen extends ConsumerWidget {
  const MainScreen({super.key});

  final List<Widget> _screens = const [
    RecordsScreen(),
    ChartsScreen(),
    // Add other screens like ReportsScreen, MeScreen
    Center(child: Text('Reports Screen')),
    Setting()
    // Center(child: Text('Me Screen')),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(bottomNavIndexProvider);

    return Scaffold(
      body: _screens[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (index) {
          ref.read(bottomNavIndexProvider.notifier).state = index;
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long),
            label: 'Records',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.pie_chart), label: 'Charts'),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Reports',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Me'),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to the new AddTransactionScreen
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const AddTransactionScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}