import 'package:flutter/material.dart';

const iconMap = {
  "home": Icons.home,
  "food": Icons.fastfood,
  "shopping": Icons.shopping_cart,
  "travel": Icons.flight,
};

IconData getIconFromString(String name) => iconMap[name] ?? Icons.help;