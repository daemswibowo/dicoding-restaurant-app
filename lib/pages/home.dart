import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/models/restaurant.dart';
import 'package:restaurant_app/services/restaurant_service.dart';
import 'package:restaurant_app/stores/restaurant_store.dart';
import 'package:restaurant_app/widgets/atoms/home/list_title.dart';
import 'package:restaurant_app/widgets/molecules/home/app_bar.dart';
import '../widgets/organisms/restaurant_list.dart';

class HomePage extends StatelessWidget {
  static const name = '/home';

  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final restaurantStore = Provider.of<RestaurantStore>(context, listen: true);
    final restaurants = restaurantStore.items;


    return Scaffold(
      backgroundColor: Colors.white,
      body: NestedScrollView(
          headerSliverBuilder: (context, isScrolled) {
            return [
              const HomeAppBar(),
            ];
          },
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.only(left: 16, right: 16, top: 8),
                child: const ListTitle(),
              ),
              (restaurantStore.error && !restaurantStore.loading)
                  ? AlertDialog(
                      title: const Text("Ouch! Something happen.."),
                      content: const Text(
                          'Cannot get data, please check your internet connection'),
                      actions: [
                        TextButton(
                            onPressed: () => restaurantStore.fetchRestaurantList(),
                            child: const Text('Try again'))
                      ],
                    )
                  : Expanded(
                      child: RestaurantList(
                      restaurants: restaurants,
                      loading: restaurantStore.loading,
                    ))
            ],
          )), // body: RestaurantList(),
    );
  }
}
