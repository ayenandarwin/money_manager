import 'package:flutter/material.dart';
import 'package:money_manager_app/core/constants/app_color.dart';

class SummarySection extends StatelessWidget {
  final String currentMonth;
  final String currentYear;
  final int expenses;
  final int income;
  final int balance;

  const SummarySection({
    super.key,
    required this.currentMonth,
    required this.currentYear,
    required this.expenses,
    required this.income,
    required this.balance,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      color: AppColors.primaryBackground, 
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                currentYear,
                style: const TextStyle(
                  fontSize: 16,
                  color: AppColors.secondaryText,
                ),
              ),
              const SizedBox(width: 8),
              DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: currentMonth,
                  icon: const Icon(
                    Icons.keyboard_arrow_down,
                    color: AppColors.primaryText,
                  ),
                  dropdownColor: AppColors.bottomNavBackground,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryText,
                  ),
                  onChanged: (String? newValue) {
                  },
                  items:
                      <String>[
                        'Jan',
                        'Feb',
                        'Mar',
                        'Apr',
                        'May',
                        'Jun',
                        'Jul',
                        'Aug',
                        'Sep',
                        'Oct',
                        'Nov',
                        'Dec',
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildSummaryItem('Expenses', expenses, AppColors.expenseColor),
              _buildSummaryItem('Income', income, AppColors.incomeColor),
              _buildSummaryItem('Balance', balance, AppColors.primaryText),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryItem(String title, int amount, Color color) {
    return Column(
      children: [
        Text(
          title,
          style: const TextStyle(color: AppColors.secondaryText, fontSize: 14),
        ),
        const SizedBox(height: 4),
        Text(
          '$amount', // Format as currency if needed
          style: TextStyle(
            color: color,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
