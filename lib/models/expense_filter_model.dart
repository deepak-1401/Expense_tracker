class ExpenseFilter {
  final String? period;
  final List<
    String
  >
  paymentMethods;
  final String? sortBy;

  const ExpenseFilter({
    this.period,
    this.paymentMethods = const [],
    this.sortBy,
  });
}
