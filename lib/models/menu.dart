import 'package:restaurant_app/models/menu_item.dart';

class Menu {
  final List<MenuItem> foods;
  final List<MenuItem> drinks;

  Menu({
    required this.foods,
    required this.drinks
  });

  factory Menu.fromJson(Map<String, dynamic> menu) => Menu(
    foods: parseMenuItems(menu['foods']),
    drinks: parseMenuItems(menu['drinks']),
  );
}