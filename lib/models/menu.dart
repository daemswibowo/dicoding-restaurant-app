import 'package:restaurant_app/models/menu_list_item.dart';

class Menu {
  final List<MenuListItem> foods;
  final List<MenuListItem> drinks;

  Menu({
    required this.foods,
    required this.drinks
  });

  factory Menu.fromJson(Map<String, dynamic> menu) => Menu(
    foods: parseMenuListItems(menu['foods']),
    drinks: parseMenuListItems(menu['drinks']),
  );
}