import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/pages/home.dart';
import 'package:restaurant_app/routes.dart';
import 'package:restaurant_app/services/restaurant_service.dart';
import 'package:restaurant_app/stores/restaurant_store.dart';
import 'package:restaurant_app/styles.dart';

void main() {
  runApp(const RestaurantApp());
}

class RestaurantApp extends StatelessWidget {
  const RestaurantApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => RestaurantStore(restaurantService: RestaurantService()),
      child: MaterialApp(
        title: 'Restaurant App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          colorScheme: Theme.of(context).colorScheme.copyWith(
                primary: primaryColor,
                onPrimary: Colors.black,
                secondary: secondaryColor,
              ),
          textTheme: myTextTheme,
        ),
        initialRoute: HomePage.name,
        routes: routes,
      ),
    );
  }
}
