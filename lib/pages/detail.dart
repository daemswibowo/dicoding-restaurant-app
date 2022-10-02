import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/stores/restaurant_store.dart';
import 'package:restaurant_app/utils/image_util.dart';
import 'package:restaurant_app/widgets/atoms/expandable_text.dart';
import 'package:restaurant_app/widgets/atoms/menu_title.dart';
import 'package:restaurant_app/widgets/molecules/no_internet_alert.dart';
import 'package:restaurant_app/widgets/organisms/menu_list.dart';
import 'package:skeleton_loader/skeleton_loader.dart';

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
  loadDetail() async {
    final restaurantStore =
        await Provider.of<RestaurantStore>(context, listen: false);
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
            ? Expanded(child: MoleculeNoInternetAlert(onTryAgain: loadDetail))
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
                            AtomExpandableText(
                              text: restaurant.description,
                              maxLines: 4,
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
                  )
                : buildDetailSkeletonLoader(),
      ),
    );
  }
}

SingleChildScrollView buildDetailSkeletonLoader() {
  return SingleChildScrollView(
      padding: const EdgeInsets.all(0),
      child: SkeletonLoader(
        builder: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 200,
              color: Colors.white,
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.only(left: 8, right: 8),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Card(
                      child: SizedBox(width: 200, height: 12),
                    ),
                    Card(
                      child: SizedBox(width: 100, height: 12),
                    ),
                    SizedBox(height: 16),
                    Card(
                      child: SizedBox(width: double.infinity, height: 12),
                    ),
                    Card(
                      child: SizedBox(width: 200, height: 12),
                    ),
                    Card(
                      child: SizedBox(width: 210, height: 12),
                    ),
                    SizedBox(height: 16),
                  ]),
            ),
          ],
        ),
        items: 1,
        period: const Duration(seconds: 2),
        highlightColor: Colors.white,
        direction: SkeletonDirection.ltr,
      ));
}
