import 'package:flutter/material.dart';
import 'package:restaurant_app/layouts/tab_layout.dart';
import 'package:restaurant_app/pages/favourites.dart';
import 'package:restaurant_app/pages/home.dart';
import 'package:restaurant_app/pages/setting.dart';

class MainPage extends StatelessWidget {
  static const name = '/home';

  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const TabLayout(tabs: [
      Icons.fastfood_outlined,
      Icons.favorite_outlined,
      Icons.settings_outlined,
    ], pages: [
      HomePage(),
      FavouritesPage(),
      SettingPage(),
    ]);
  }
}
