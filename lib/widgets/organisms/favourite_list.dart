import 'package:flutter/material.dart';
import 'package:restaurant_app/models/restaurant.dart';
import 'package:restaurant_app/pages/search.dart';
import 'package:restaurant_app/widgets/molecules/restaurant_list_item.dart';

class FavouriteList extends StatelessWidget {
  final List<Restaurant> restaurants;

  const FavouriteList({super.key, required this.restaurants});

  @override
  Widget build(BuildContext context) {
    if (restaurants.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(8),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text('Feel lonely here :('),
              TextButton.icon(
                  onPressed: () =>
                      Navigator.pushNamed(context, SearchPage.name),
                  icon: const Icon(Icons.search),
                  label: const Text('Find your favourite one'))
            ],
          ),
        ),
      );
    } else {
      return ListView.builder(
        itemCount: restaurants.length,
        padding: const EdgeInsets.all(0),
        itemBuilder: (context, index) {
          return RestaurantListItem(restaurant: restaurants[index]);
        },
      );
    }
  }
}
