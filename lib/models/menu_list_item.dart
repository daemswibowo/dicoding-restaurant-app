class MenuListItem {
  final String name;

  MenuListItem({
    required this.name
  });

  factory MenuListItem.fromJson(Map<String, dynamic> food) => MenuListItem(
    name: food['name'],
  );
}

List<MenuListItem> parseMenuListItems(List<dynamic>? foods) {
  if (foods == null) {
    return [];
  }

  return foods.map((food) => MenuListItem.fromJson(food)).toList();
}