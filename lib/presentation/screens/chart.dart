import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:money_manager_app/data/model/transaction.dart';
import 'package:money_manager_app/provider/common.dart';
import 'package:money_manager_app/provider/transaction.dart';

class ChartsScreen extends ConsumerWidget {
  const ChartsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final transactions = ref.watch(transactionsProvider);
    final selectedDate = ref.watch(selectedChartDateProvider);
    final chartType = ref.watch(chartTypeProvider);

    // Filter transactions for the selected month/year
    final filteredTransactions =
        transactions
            .where(
              (t) =>
                  t.date.month == selectedDate.month &&
                  t.date.year == selectedDate.year &&
                  t.type == chartType,
            )
            .toList();

    // Group by category and sum amounts
    final Map<String, double> categorySums = {};
    for (var t in filteredTransactions) {
      categorySums.update(
        t.category,
        (value) => value + t.amount,
        ifAbsent: () => t.amount,
      );
    }

    final totalAmount = categorySums.values.fold(
      0.0,
      (sum, amount) => sum + amount,
    );

    // Prepare data for PieChart
    List<PieChartSectionData> pieChartSections = [];
    if (totalAmount > 0) {
      categorySums.forEach((category, amount) {
        final percentage = (amount / totalAmount) * 100;
        pieChartSections.add(
          PieChartSectionData(
            color: _getCategoryColor(
              category,
            ), // Assign a color to each category
            value: amount,
            title: '${percentage.toStringAsFixed(1)}%',
            radius: 80,
            titleStyle: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.black, // Text color on pie slices
            ),
            badgeWidget: _buildCategoryBadge(
              category,
              amount,
            ), // Custom badge for category
            badgePositionPercentageOffset: 1.2,
          ),
        );
      });
    }

    // Sort categories by amount for the list view
    final sortedCategories =
        categorySums.entries.toList()
          ..sort((a, b) => b.value.compareTo(a.value));

    return Scaffold(
      appBar: AppBar(
        title: Text(
          chartType == TransactionType.expense ? 'Expenses' : 'Income',
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.swap_horiz),
            onPressed: () {
              // Toggle chart type
              ref.read(chartTypeProvider.notifier).state =
                  chartType == TransactionType.expense
                      ? TransactionType.income
                      : TransactionType.expense;
            },
            tooltip: 'Toggle Expense/Income',
          ),
        ],
      ),
      body: Column(
        children: [
          // Month/Year Selector
          _buildChartDateSelector(context, ref, selectedDate),
          const SizedBox(height: 20),
          // Pie Chart Section
          SizedBox(
            height: 250,
            child: Stack(
              // Use Stack to place text in the center
              alignment: Alignment.center,
              children: [
                PieChart(
                  PieChartData(
                    sections: pieChartSections,
                    centerSpaceRadius: 50,
                    sectionsSpace: 1.5,
                    borderData: FlBorderData(show: false),
                    // centerWidget is removed from PieChartData
                  ),
                ),
                // Place the total amount text in the center of the Stack
                Text(
                  NumberFormat.currency(
                    symbol: '',
                    decimalDigits: 0,
                  ).format(totalAmount),
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge!.copyWith(color: Colors.black),
                ),
              ],
            ),
          ),
          const SizedBox(height: 35),
          // Category List with Progress Bars
          Expanded(
            child: ListView.builder(
              itemCount: sortedCategories.length,
              itemBuilder: (context, index) {
                final entry = sortedCategories[index];
                final category = entry.key;
                final amount = entry.value;
                final percentage = (amount / totalAmount) * 100;

                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 4.0,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 12,
                              backgroundColor: _getCategoryColor(category),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              category,
                              style: Theme.of(context).textTheme.titleMedium!
                                  .copyWith(fontWeight: FontWeight.bold),
                            ),
                            const Spacer(),
                            Text(
                              '${percentage.toStringAsFixed(1)}%',
                              style: Theme.of(context).textTheme.bodyMedium!
                                  .copyWith(color: Colors.grey.shade400),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              NumberFormat.currency(
                                symbol: '',
                                decimalDigits: 0,
                              ).format(amount),
                              style: Theme.of(context).textTheme.titleMedium!
                                  .copyWith(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        LinearProgressIndicator(
                          value: percentage / 100,
                          backgroundColor: Colors.grey.shade800,
                          color: _getCategoryColor(category),
                          minHeight: 5,
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChartDateSelector(
    BuildContext context,
    WidgetRef ref,
    DateTime selectedDate,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      color: Theme.of(context).appBarTheme.backgroundColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
            onPressed: () {
              ref.read(selectedChartDateProvider.notifier).state = DateTime(
                selectedDate.year,
                selectedDate.month - 1,
                selectedDate.day,
              );
            },
          ),
          Text(
            DateFormat('MMM yyyy').format(selectedDate),
            style: Theme.of(
              context,
            ).textTheme.titleLarge!.copyWith(color: Colors.black),
          ),
          IconButton(
            icon: const Icon(Icons.arrow_forward_ios, color: Colors.black),
            onPressed: () {
              ref.read(selectedChartDateProvider.notifier).state = DateTime(
                selectedDate.year,
                selectedDate.month + 1,
                selectedDate.day,
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryBadge(String category, double amount) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: _getCategoryColor(category),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.white, width: 1),
      ),
      child: Text(
        category,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Color _getCategoryColor(String category) {
    // A simple way to assign consistent colors to categories
    final int hash = category.hashCode;
    final List<Color> colors = [
      Colors.greenAccent,
      Colors.orangeAccent,
      Colors.purpleAccent,
      Colors.redAccent,
      Colors.teal,
      Colors.brown,
      Colors.pinkAccent,
      Colors.limeAccent,
      Colors.blueAccent,
    ];
    return colors[hash % colors.length];
  }
}
