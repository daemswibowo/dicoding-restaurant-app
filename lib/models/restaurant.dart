import 'dart:convert';
import 'package:restaurant_app/models/menu.dart';

class Restaurant {
  final String id;
  final String name;
  final String description;
  final String pictureId;
  final String city;
  final num rating;
  final Menu menus;

  Restaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.rating,
    required this.menus,
  });

  factory Restaurant.fromJson(Map<String, dynamic> restaurant) => Restaurant(
    id: restaurant['id'],
    name: restaurant['name'],
    description: restaurant['description'],
    pictureId: restaurant['pictureId'],
    city: restaurant['city'],
    rating: restaurant['rating'],
    menus: Menu.fromJson(restaurant['menus']),
  );
}

List<Restaurant> parseRestaurants(String? json) {
  if (json == null) {
    return [];
  }

  final List parsed = jsonDecode(json);
  return parsed.map((json) => Restaurant.fromJson(json)).toList();
}