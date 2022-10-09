import 'package:flutter/material.dart';
import 'package:restaurant_app/pages/detail.dart';
import 'package:restaurant_app/pages/main.dart';
import 'package:restaurant_app/pages/search.dart';

final routes = {
  MainPage.name: (context) => const MainPage(),
  RestaurantDetailPage.name: (context) => RestaurantDetailPage(
      restaurantId: ModalRoute.of(context)?.settings.arguments as String),
  SearchPage.name: (context) => const SearchPage(),
};
