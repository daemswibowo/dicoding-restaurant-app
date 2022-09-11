import 'package:flutter/material.dart';
import 'package:restaurant_app/models/restaurant.dart';
import 'package:restaurant_app/widgets/organisms/restaurant_list.dart';

class HomePage extends StatefulWidget {
  static const name = '/home';

  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const ListTile(
          title: Text("Restaurant App"),
          subtitle: Text("Recommendation restaurant for you!"),
        ),
      ),
      body: FutureBuilder<String>(
        future: DefaultAssetBundle.of(context)
            .loadString('assets/restaurants.json'),
        builder: (context, snapshot) {
          final List<Restaurant> restaurants = parseRestaurants(snapshot.data);
          return RestaurantList(restaurants: restaurants);
        },
      ),
    );
  }
}
