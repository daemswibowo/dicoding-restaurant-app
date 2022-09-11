import 'package:flutter/material.dart';
import 'package:restaurant_app/models/restaurant.dart';
import 'package:restaurant_app/widgets/molecules/restaurant_list_item.dart';

class RestaurantList extends StatelessWidget {
  const RestaurantList({
    Key? key,
    required this.restaurants,
  }) : super(key: key);

  final List<Restaurant> restaurants;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: restaurants.length,
      itemBuilder: (context, index) {
        return RestaurantListItem(restaurant: restaurants[index]);
      },
    );
  }
}
