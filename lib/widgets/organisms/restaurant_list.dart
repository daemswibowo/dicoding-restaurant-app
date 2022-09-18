import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/models/restaurant.dart';
import 'package:restaurant_app/services/restaurant_service.dart';
import 'package:restaurant_app/stores/restaurant_store.dart';
import 'package:restaurant_app/widgets/molecules/restaurant_list_item.dart';

class RestaurantList extends StatefulWidget {
  const RestaurantList({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _RestaurantListState();
}

class _RestaurantListState extends State<RestaurantList> {
  @override
  void initState() {
    super.initState();
    final restaurantStore =
        Provider.of<RestaurantStore>(context, listen: false);

    restaurantService
        .list()
        .then((RestaurantListResponse restaurantListResponse) {
      restaurantStore.setItems(restaurantListResponse.restaurants);
    });
  }

  @override
  Widget build(BuildContext context) {
    final restaurantStore = Provider.of<RestaurantStore>(context, listen: true);
    final restaurants = restaurantStore.items;

    return ListView.builder(
      itemCount: restaurantStore.total,
      itemBuilder: (context, index) {
        return RestaurantListItem(restaurant: restaurants[index]);
      },
    );
  }
}
