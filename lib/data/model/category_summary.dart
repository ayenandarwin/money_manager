import 'package:flutter/material.dart';

class CategorySummary {
  final String category;
  final IconData icon; // Category icon
  final double percentage;
  final int amount;
  final Color color; // Color for the pie chart slice and legend

  CategorySummary({
    required this.category,
    required this.icon,
    required this.percentage,
    required this.amount,
    required this.color,
  });
}
