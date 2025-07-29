import 'package:flutter/material.dart';
import 'package:money_manager_app/core/constants/app_color.dart';
import 'package:money_manager_app/data/model/category_summary.dart';

class ChartCategoryItem extends StatelessWidget {
  final CategorySummary summary;

  const ChartCategoryItem({super.key, required this.summary});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: AppColors.bottomNavBackground,
                child: Icon(summary.icon, color: AppColors.secondaryText),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  summary.category,
                  style: const TextStyle(
                    color: AppColors.primaryText,
                    fontSize: 16,
                  ),
                ),
              ),
              Text(
                '${summary.percentage.toStringAsFixed(2)}%',
                style: const TextStyle(
                  color: AppColors.secondaryText,
                  fontSize: 14,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                summary.amount.toString(), // Format as currency if needed
                style: const TextStyle(
                  color: AppColors.primaryText,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          // Progress Bar
          LinearProgressIndicator(
            value: summary.percentage / 100, // Normalized to 0.0 to 1.0
            backgroundColor: AppColors.secondaryText.withOpacity(0.3),
            valueColor: AlwaysStoppedAnimation<Color>(summary.color),
            minHeight: 4,
            borderRadius: BorderRadius.circular(2),
          ),
        ],
      ),
    );
  }
}
