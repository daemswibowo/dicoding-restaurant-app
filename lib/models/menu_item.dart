class MenuItem {
  final String name;

  MenuItem({
    required this.name
  });

  factory MenuItem.fromJson(Map<String, dynamic> food) => MenuItem(
    name: food['name'],
  );
}

List<MenuItem> parseMenuItems(List<dynamic>? foods) {
  if (foods == null) {
    return [];
  }

  return foods.map((food) => MenuItem.fromJson(food)).toList();
}