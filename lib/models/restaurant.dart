import 'dart:developer';

import 'package:restaurant_app/models/category.dart';
import 'package:restaurant_app/models/menu.dart';

class Restaurant {
  final String id;
  final String name;
  final String description;
  final String pictureId;
  final String city;
  final num rating;
  final Menu? menus;
  final List<Category>? categories;

  Restaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.rating,
    this.menus,
    this.categories,
  });

  factory Restaurant.fromJson(Map<String, dynamic> restaurant) {

    return Restaurant(
      id: restaurant['id'],
      name: restaurant['name'],
      description: restaurant['description'],
      pictureId: restaurant['pictureId'],
      city: restaurant['city'],
      rating: restaurant['rating'],
      menus: restaurant.containsKey('menus')
          ? Menu.fromJson(restaurant['menus'])
          : null,
      categories: restaurant.containsKey('categories') ? parseCategories(
          restaurant['categories']) : restaurant['categories'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "description": description,
      "pictureId": pictureId,
      "city": city,
      "rating": rating,
    };
  }
}

List<Restaurant> parseRestaurants(List<dynamic> restaurants) {
  return restaurants.map((json) => Restaurant.fromJson(json)).toList();
}

class RestaurantListResponse {
  final bool error;
  final String message;
  final int count;
  final List<Restaurant> restaurants;

  RestaurantListResponse({
    required this.error,
    required this.message,
    required this.count,
    required this.restaurants,
  });

  factory RestaurantListResponse.fromJson(Map<String, dynamic> json) =>
      RestaurantListResponse(
        error: json['error'],
        message: json['message'],
        count: json['count'],
        restaurants: parseRestaurants(json['restaurants']),
      );
}

class RestaurantSearchResponse {
  final bool error;
  final int founded;
  final List<Restaurant> restaurants;

  RestaurantSearchResponse({
    required this.error,
    required this.founded,
    required this.restaurants,
  });

  factory RestaurantSearchResponse.fromJson(Map<String, dynamic> json) =>
      RestaurantSearchResponse(
        error: json['error'],
        founded: json['founded'],
        restaurants: parseRestaurants(json['restaurants']),
      );
}

class RestaurantDetailResponse {
  final bool error;
  final String message;
  final Restaurant restaurant;

  RestaurantDetailResponse({
    required this.error,
    required this.message,
    required this.restaurant,
  });

  factory RestaurantDetailResponse.fromJson(Map<String, dynamic> json) =>
      RestaurantDetailResponse(
        error: json['error'],
        message: json['message'],
        restaurant: Restaurant.fromJson(json['restaurant']),
      );
}
