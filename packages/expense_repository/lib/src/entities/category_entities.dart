class CategoryEntity {
  String categoryId;
  String name;
  int todayExpense;
  String icon;
  String color;

  CategoryEntity({
    required this.categoryId,
    required this.name,
    required this.todayExpense,
    required this.icon,
    required this.color,
  });

  Map<
    String,
    dynamic
  >
  toDocument() {
    return {
      'categoryId': categoryId,
      'name': name,
      'todayExpense': todayExpense,
      'icon': icon,
      'color': color,
    };
  }

  static CategoryEntity fromDocument(
    Map<
      String,
      dynamic
    >
    doc,
  ) {
    return CategoryEntity(
      categoryId: doc['categoryId'],
      name: doc['name'],
      todayExpense: doc['todayExpense']?.toInt(),
      icon: doc['icon'],
      color: doc['color'],
    );
  }
}
