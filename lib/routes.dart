import 'package:flutter/material.dart';
import 'package:restaurant_app/pages/detail.dart';
import 'package:restaurant_app/pages/home.dart';
import 'package:restaurant_app/pages/search.dart';

final routes = {
  HomePage.name: (context) => const HomePage(),
  RestaurantDetailPage.name: (context) => RestaurantDetailPage(
      restaurantId: ModalRoute.of(context)?.settings.arguments as String),
  SearchPage.name: (context) => const SearchPage(),
};
