import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:restaurant_app/models/restaurant.dart';

class RestaurantStore extends ChangeNotifier {
  late List<Restaurant> _items = [];
  late bool loading = false;

  List<Restaurant> get items => _items;
  int get total => _items.length;

  void setItems(List<Restaurant> newItems) {
    _items = newItems;
    notifyListeners();
  }
}