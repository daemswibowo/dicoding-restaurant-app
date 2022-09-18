import 'package:flutter/material.dart';
import '../widgets/organisms/restaurant_list.dart';

class HomePage extends StatelessWidget {
  static const name = '/home';

  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const ListTile(
          title: Text("Restaurant App"),
          subtitle: Text("Recommendation restaurant for you!"),
        ),
      ),
      body: const RestaurantList(),
    );
  }
}
