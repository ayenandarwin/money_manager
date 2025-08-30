import 'package:flutter/material.dart';
import 'package:money_manager_app/core/constants/app_color.dart';
import 'package:money_manager_app/data/model/category_summary.dart';

class CategoryLegend extends StatelessWidget {
  final List<CategorySummary> categorySummaries;

  const CategoryLegend({super.key, required this.categorySummaries});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:
          categorySummaries.map((summary) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(summary.colorValue),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '${summary.category} ',
                    style: const TextStyle(
                      color: AppColors.primaryText,
                      fontSize: 13,
                    ),
                  ),
                  Text(
                    '${summary.percentage.toStringAsFixed(2)}%',
                    style: const TextStyle(
                      color: AppColors.secondaryText,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
    );
  }
}
