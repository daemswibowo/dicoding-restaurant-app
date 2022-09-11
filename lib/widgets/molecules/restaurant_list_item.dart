import 'package:flutter/material.dart';
import 'package:restaurant_app/models/restaurant.dart';
import 'package:restaurant_app/pages/detail.dart';

class RestaurantListItem extends StatelessWidget {
  final Restaurant restaurant;

  const RestaurantListItem({Key? key, required this.restaurant})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      leading: Hero(
        tag: restaurant.pictureId,
        child: Image.network(
          restaurant.pictureId,
          width: 100,
        ),
      ),
      title: Text(restaurant.name),
      subtitle: Text("🧭 ${restaurant.city}\n⭐️ ${restaurant.rating}"),
      onTap: () {
        Navigator.pushNamed(context, RestaurantDetailPage.name,
            arguments: restaurant);
      },
    );
  }
}
