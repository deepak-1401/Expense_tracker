import 'package:flutter/material.dart';

class CategoryIconHelper {
  static IconData iconFromName(
    String iconName,
  ) {
    switch (iconName) {
      case 'food':
        return Icons.restaurant;
      case 'shopping':
        return Icons.shopping_bag;
      case 'transport':
        return Icons.directions_car;
      case 'entertainment':
        return Icons.movie;
      case 'health':
        return Icons.favorite;
      case 'education':
        return Icons.school;
      default:
        return Icons.category;
    }
  }
}
