import 'package:flutter/material.dart';

class CategoryValidationHelper {
  static String? validate({
    required String categoryName,
    required IconData? selectedIcon,
    required Color? selectedColor,
  }) {
    if (categoryName.trim().isEmpty) {
      return 'Please enter category name';
    }

    if (selectedIcon ==
        null) {
      return 'Please select an icon';
    }

    if (selectedColor ==
        null) {
      return 'Please select a color';
    }

    return null;
  }
}
