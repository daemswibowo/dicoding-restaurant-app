import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/stores/restaurant_store.dart';
import 'package:restaurant_app/widgets/atoms/home/list_title.dart';
import 'package:restaurant_app/widgets/molecules/home/app_bar.dart';
import 'package:restaurant_app/widgets/molecules/no_internet_alert.dart';
import '../widgets/organisms/restaurant_list.dart';

class HomePage extends StatelessWidget {
  static const name = '/restaurant';

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
                  ? Expanded(
                      child: MoleculeNoInternetAlert(
                          onTryAgain: restaurantStore.fetchRestaurantList))
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
