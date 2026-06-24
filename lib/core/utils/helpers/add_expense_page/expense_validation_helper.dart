class ExpenseValidationHelper {
  static String? validate({
    required String amountText,
    required dynamic selectedCategory,
    required String paymentMethod,
  }) {
    final amount = double.tryParse(
      amountText.trim(),
    );

    if (amountText.trim().isEmpty) {
      return 'Please enter amount';
    }

    if (amount ==
            null ||
        amount <=
            0) {
      return 'Please enter a valid amount';
    }

    if (selectedCategory ==
        null) {
      return 'Please select a category';
    }

    if (paymentMethod.isEmpty) {
      return 'Please select payment method';
    }

    return null;
  }
}
