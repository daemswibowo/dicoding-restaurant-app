import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/models/restaurant.dart';
import 'package:restaurant_app/services/restaurant_service.dart';
import 'package:restaurant_app/stores/restaurant_store.dart';
import 'package:restaurant_app/widgets/atoms/home/list_title.dart';
import 'package:restaurant_app/widgets/molecules/home/app_bar.dart';
import '../widgets/organisms/restaurant_list.dart';

class HomePage extends StatefulWidget {
  static const name = '/home';

  const HomePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late bool _loading = false;
  late bool _error = false;

  @override
  void initState() {
    super.initState();
    loadRestaurant();
  }

  // load restaurant data
  loadRestaurant() {
    setLoading(true);
    setState(() {
      _error = false;
    });
    final restaurantStore =
        Provider.of<RestaurantStore>(context, listen: false);

    restaurantService
        .list()
        .then((RestaurantListResponse restaurantListResponse) {
      restaurantStore.setItems(restaurantListResponse.restaurants);
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
              (_error && !_loading)
                  ? AlertDialog(
                      title: const Text("Ouch! Something happen.."),
                      content: const Text(
                          'Cannot get data, please check your internet connection'),
                      actions: [
                        TextButton(
                            onPressed: () => loadRestaurant(),
                            child: const Text('Try again'))
                      ],
                    )
                  : Expanded(
                      child: RestaurantList(
                      restaurants: restaurants,
                      loading: _loading,
                    ))
            ],
          )), // body: RestaurantList(),
    );
  }
}
