import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/stores/restaurant_store.dart';
import 'package:restaurant_app/widgets/organisms/favourite_list.dart';

class FavouritesPage extends StatelessWidget {
  static const name = '/favourites';

  const FavouritesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final restaurantStore = Provider.of<RestaurantStore>(context, listen: true);

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('Favourites', style: TextStyle(color: Colors.black)),
          backgroundColor: Colors.white,
        ),
        body: FavouriteList(restaurants: restaurantStore.favourites),
    );
  }
}
