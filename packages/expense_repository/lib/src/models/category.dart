import 'package:expense_repository/src/entities/entities.dart';
// Icon stored as String to match CategoryEntity

class Category {
  String categoryId;
  String name;
  int todayExpense;
  String icon;
  String color;

  Category({
    required this.categoryId,
    required this.name,
    required this.todayExpense,
    required this.icon,
    required this.color,
  });

  static final empty = Category(
    categoryId: '',
    name: '',
    todayExpense: 0,
    icon: '',
    color: '',
  );

  CategoryEntity toEntity() {
    return CategoryEntity(
      categoryId: categoryId,
      name: name,
      todayExpense: todayExpense,
      icon: icon,
      color: color,
    );
  }

  static Category fromEntity(
    CategoryEntity entity,
  ) {
    return Category(
      categoryId: entity.categoryId,
      name: entity.name,
      todayExpense: entity.todayExpense,
      icon: entity.icon,
      color: entity.color,
    );
  }

  //Category({required this.name, required this.icon, required this.color});
}
