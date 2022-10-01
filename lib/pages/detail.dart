import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/models/restaurant.dart';
import 'package:restaurant_app/services/restaurant_service.dart';
import 'package:restaurant_app/stores/restaurant_store.dart';
import 'package:restaurant_app/utils/image_util.dart';
import 'package:restaurant_app/widgets/atoms/expandable_text.dart';
import 'package:restaurant_app/widgets/atoms/menu_title.dart';
import 'package:restaurant_app/widgets/organisms/menu_list.dart';

class RestaurantDetailPage extends StatefulWidget {
  static const name = '/detail';

  final String restaurantId;

  const RestaurantDetailPage({super.key, required this.restaurantId});

  @override
  State<StatefulWidget> createState() => _RestaurantDetailState();
}

class _RestaurantDetailState extends State<RestaurantDetailPage> {
  @override
  void initState() {
    super.initState();
    loadDetail();
  }

  // load restaurant data
  loadDetail() {
    final restaurantStore =
        Provider.of<RestaurantStore>(context, listen: false);
    restaurantStore.fetchDetail(widget.restaurantId);
  }

  @override
  Widget build(BuildContext context) {
    final restaurantStore = Provider.of<RestaurantStore>(context, listen: true);
    final loading = restaurantStore.loading;
    final error = restaurantStore.error;
    final restaurant = restaurantStore.item;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(loading
            ? 'Loading...'
            : error
                ? 'Failed'
                : restaurant?.name ?? 'hello'),
      ),
      body: SingleChildScrollView(
        child: (error && !loading)
            ? AlertDialog(
                title: const Text("Ouch! Something happen.."),
                content: const Text(
                    'Cannot get data, please check your internet connection'),
                actions: [
                  TextButton(
                      onPressed: () => loadDetail(),
                      child: const Text('Try again'))
                ],
              )
            : !loading && restaurant != null
                ? Column(
                    children: [
                      Hero(
                          tag: restaurant.pictureId,
                          child: Image.network(generateImageUrl(
                              restaurant.pictureId, 'medium'))),
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
                              "🧭 ${restaurant.city} ⭐️ ${restaurant.rating}",
                              style: const TextStyle(fontSize: 12),
                            ),
                            const Padding(padding: EdgeInsets.all(8)),
                            AtomExpandableText(text: restaurant.description, maxLines: 4,),
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
                  )
                : const Center(child: Text('Loading')),
      ),
    );
  }
}