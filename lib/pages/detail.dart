import 'package:flutter/material.dart';
import 'package:restaurant_app/models/restaurant.dart';
import 'package:restaurant_app/services/restaurant_service.dart';
import 'package:restaurant_app/utils/image_util.dart';
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
  late bool _loading = false;
  late bool _error = false;
  late Restaurant restaurant;

  @override
  void initState() {
    super.initState();
    loadDetail();
  }

  // load restaurant data
  loadDetail() {
    setLoading(true);
    setState(() {
      _error = false;
    });

    restaurantService
        .detail(widget.restaurantId)
        .then((RestaurantDetailResponse response) {
      setState(() {
        restaurant = response.restaurant;
      });
    }).catchError((e) {
      setState(() {
        _error = true;
      });
    }).whenComplete(() => setLoading(false));
  }

  setLoading(bool loading) {
    setState(() {
      _loading = loading;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(_loading
            ? 'Loading...'
            : _error
                ? 'Failed'
                : restaurant.name),
      ),
      body: SingleChildScrollView(
        child: !_loading && !_error
            ? Column(
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
              )
            : const Center(child: Text('Loading')),
      ),
    );
  }
}
