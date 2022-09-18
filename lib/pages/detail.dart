import 'package:flutter/material.dart';
import 'package:restaurant_app/models/restaurant.dart';
import 'package:restaurant_app/utils/image_util.dart';
import 'package:restaurant_app/widgets/atoms/menu_title.dart';
import 'package:restaurant_app/widgets/organisms/menu_list.dart';

class RestaurantDetailPage extends StatelessWidget {
  static const name = '/detail';

  final Restaurant restaurant;

  const RestaurantDetailPage({Key? key, required this.restaurant})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final menus = restaurant.menus;

    return Scaffold(
      appBar: AppBar(
        title: Text(restaurant.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Hero(
                tag: restaurant.pictureId,
                child: Image.network(
                    generateImageUrl(restaurant.pictureId, 'medium'))),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    restaurant.name,
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const Padding(padding: EdgeInsets.all(2)),
                  Text(
                    "🧭 ${restaurant.city}",
                    style: const TextStyle(fontSize: 12),
                  ),
                  const Padding(padding: EdgeInsets.all(8)),
                  Text(
                    restaurant.description,
                    style: const TextStyle(fontSize: 12),
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Padding(padding: EdgeInsets.all(8)),
                  const MenuTitle(title: 'Foods'),
                  const Padding(padding: EdgeInsets.all(4)),
                  MenuList(
                      items: restaurant.menus != null
                          ? restaurant.menus?.foods
                          : []),
                  const Padding(padding: EdgeInsets.all(8)),
                  const MenuTitle(title: 'Drinks'),
                  const Padding(padding: EdgeInsets.all(4)),
                  MenuList(
                      items: restaurant.menus != null
                          ? restaurant.menus?.drinks
                          : []),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
