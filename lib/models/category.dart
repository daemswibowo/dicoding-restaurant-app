class Category {
  final String name;

  Category({
    required this.name
  });

  factory Category.fromJson(Map<String, dynamic> category) => Category(
    name: category['name'],
  );
}

List<Category> parseCategories(List<dynamic>? categories) {
  if (categories == null) {
    return [];
  }

  return categories.map((category) => Category.fromJson(category)).toList();
}