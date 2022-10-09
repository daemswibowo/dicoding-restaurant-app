import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/pages/home.dart';
import 'package:restaurant_app/pages/main.dart';
import 'package:restaurant_app/routes.dart';
import 'package:restaurant_app/services/background_service.dart';
import 'package:restaurant_app/services/restaurant_service.dart';
import 'package:restaurant_app/stores/restaurant_store.dart';
import 'package:restaurant_app/stores/setting_store.dart';
import 'package:restaurant_app/styles.dart';
import 'package:restaurant_app/utils/notification_util.dart';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  backgroundService.initializeIsolate();
  if (Platform.isAndroid) {
    await AndroidAlarmManager.initialize();
  }

  await notificationUtil.initNotifications();

  runApp(const RestaurantApp());
}

class RestaurantApp extends StatelessWidget {
  const RestaurantApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
              create: (context) =>
                  RestaurantStore(restaurantService: RestaurantService())),
          ChangeNotifierProvider(create: (context) => SettingStore()),
        ],
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
          initialRoute: MainPage.name,
          routes: routes,
        ));
  }
}
