import 'package:flutter/material.dart';

class AppData {
  static const List<Map<String, dynamic>> paymentMethods = [
    {'name': 'Bank', 'icon': Icons.account_balance},
    {'name': 'Cash', 'icon': Icons.payments},
    {'name': 'Wallet', 'icon': Icons.wallet},
    {'name': 'Others', 'icon': Icons.more_horiz},
  ];

  static const List<Map<String, dynamic>> incomeTypes = [
    {'name': 'Salary', 'icon': Icons.account_balance_wallet},
      {'name': 'Investments', 'icon': Icons.trending_up},
      {'name': 'Part-Time', 'icon': Icons.work},
      {'name': 'Bonus', 'icon': Icons.money},
      {'name': 'Game', 'icon': Icons.gamepad},
      {'name': 'Others', 'icon': Icons.more_horiz},
  ];

  static const List<Map<String, dynamic>> expenseTypes = [
    {'name': 'Shopping', 'icon': Icons.shopping_cart},
      {'name': 'Food', 'icon': Icons.fastfood},
      {'name': 'Phone', 'icon': Icons.phone_android},
      {'name': 'Entertainment', 'icon': Icons.movie},
      {'name': 'Education', 'icon': Icons.school},
      {'name': 'Beauty', 'icon': Icons.spa},
      {'name': 'Sports', 'icon': Icons.sports_soccer},
      {'name': 'Social', 'icon': Icons.people},
      {'name': 'Transport', 'icon': Icons.directions_bus},
      {'name': 'Clothing', 'icon': Icons.checkroom},
      {'name': 'Car', 'icon': Icons.directions_car},
      {'name': 'Alcohol', 'icon': Icons.local_bar},
      {'name': 'Cigarettes', 'icon': Icons.smoking_rooms},
      {'name': 'Electronics', 'icon': Icons.devices},
      {'name': 'Travel', 'icon': Icons.flight},
      {'name': 'Health', 'icon': Icons.medical_services},
      {'name': 'Pets', 'icon': Icons.pets},
      {'name': 'Repairs', 'icon': Icons.build},
      {'name': 'Housing', 'icon': Icons.home_work},
      {'name': 'Home', 'icon': Icons.home},
      {'name': 'Gifts', 'icon': Icons.card_giftcard},
      {'name': 'Donations', 'icon': Icons.favorite},
      {'name': 'Lottery', 'icon': Icons.casino},
      {'name': 'Snacks', 'icon': Icons.cookie},
      {'name': 'Kids', 'icon': Icons.child_care},
      {
        'name': 'Vegetables',
        'icon': Icons.local_florist,
      }, // Using flower for vegetables, could be more specific
      {'name': 'Fruits', 'icon': Icons.apple},
      {'name': 'Others', 'icon': Icons.more_horiz},
  ];
}
