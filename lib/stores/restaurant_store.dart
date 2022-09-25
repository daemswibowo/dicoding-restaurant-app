import 'package:flutter/cupertino.dart';
import 'package:restaurant_app/models/restaurant.dart';

class RestaurantStore extends ChangeNotifier {
  late List<Restaurant> _items = [];

  List<Restaurant> get items => _items;

  int get total => _items.length;

  void setItems(List<Restaurant> newItems) {
    _items = newItems;
    notifyListeners();
  }
}
