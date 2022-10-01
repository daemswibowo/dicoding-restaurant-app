import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/models/restaurant.dart';
import 'package:restaurant_app/services/restaurant_service.dart';
import 'package:restaurant_app/stores/restaurant_store.dart';
import 'package:restaurant_app/widgets/organisms/restaurant_list.dart';

class SearchPage extends StatefulWidget {
  static const name = '/search';

  const SearchPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late String _query = '';

  @override
  void initState() {
    super.initState();
  }

  // load restaurant data
  loadRestaurant() {
    if (_query == '') return false;
    final restaurantStore = Provider.of<RestaurantStore>(context, listen: false);
    restaurantStore.fetchSearchRestaurant(_query);
  }

  @override
  Widget build(BuildContext context) {
    final restaurantStore = Provider.of<RestaurantStore>(context, listen: true);
    final loading = restaurantStore.loading;
    final error = restaurantStore.error;
    final restaurants = restaurantStore.searchItems;

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            backgroundColor: Colors.white,
            shadowColor: Colors.transparent,
            actions: [
              IconButton(
                onPressed: () => loadRestaurant(),
                icon: const Icon(Icons.search),
              )
            ],
            title: TextField(
              onChanged: (value) => setState(() {
                _query = value;
              }),
              decoration: InputDecoration(
                hintText: 'Search restaurant name',
                hintStyle: const TextStyle(
                  color: Colors.black38,
                  fontSize: 14,
                ),
                contentPadding: const EdgeInsets.only(left: 4, right: 8),
                enabledBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(width: 0, color: Colors.transparent),
                    borderRadius: BorderRadius.circular(10.0)),
                filled: true,
                focusedBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(width: 0, color: Colors.transparent),
                    borderRadius: BorderRadius.circular(10.0)),
                fillColor: Colors.white12,
              ),
              autofocus: true,
              style: const TextStyle(
                color: Colors.black,
              ),
            )),
        body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              (error && !loading)
                  ? AlertDialog(
                      title: const Text("Ouch! Something happen.."),
                      content: const Text(
                          'Cannot get data, please check your internet connection'),
                actions: [TextButton(onPressed: () => loadRestaurant(), child: const Text('Try again'))],
              )
                  : Expanded(
                  child: RestaurantList(
                      restaurants: restaurants, loading: loading)),
            ]));
  }
}
