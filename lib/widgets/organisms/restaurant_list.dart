import 'package:flutter/material.dart';
import 'package:restaurant_app/models/restaurant.dart';
import 'package:restaurant_app/widgets/molecules/restaurant_list_item.dart';
import 'package:skeleton_loader/skeleton_loader.dart';

class RestaurantList extends StatelessWidget {
  final List<Restaurant> restaurants;
  final bool loading;

  const RestaurantList({super.key, required this.restaurants, required this.loading});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    if (loading) {
      return buildRestaurantListSkeleton(screenWidth);
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

  SingleChildScrollView buildRestaurantListSkeleton(double screenWidth) {
    return SingleChildScrollView(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 0),
        child: SkeletonLoader(
          builder: Row(
            children: <Widget>[
              Card(
                child: SizedBox(
                  width: screenWidth * 0.3,
                  height: 68,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Card(
                      child: SizedBox(
                        width: double.infinity,
                        height: 16,
                      ),
                    ),
                    Card(
                      child: SizedBox(
                        width: screenWidth * 0.3,
                        height: 12,
                      ),
                    ),
                    Card(
                      child: SizedBox(
                        width: screenWidth * 0.4,
                        height: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          items: 6,
          period: const Duration(seconds: 2),
          highlightColor: Colors.white,
          direction: SkeletonDirection.ltr,
        ));
  }
}
