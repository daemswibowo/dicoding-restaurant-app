import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/stores/restaurant_store.dart';
import 'package:restaurant_app/stores/setting_store.dart';
import 'package:restaurant_app/widgets/atoms/home/list_title.dart';
import 'package:restaurant_app/widgets/molecules/home/app_bar.dart';
import 'package:restaurant_app/widgets/molecules/no_internet_alert.dart';
import '../widgets/organisms/restaurant_list.dart';

class SettingPage extends StatelessWidget {
  static const name = '/setting';

  const SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('Setting', style: TextStyle(color: Colors.black)),
          backgroundColor: Colors.white,
        ),
        body: ListTile(
          title: const Text('Recommended restaurant'),
          subtitle: const Text('Notify me for recommended restaurant'),
          trailing: Consumer<SettingStore>(
            builder: (context, setting, _) {
              return Switch.adaptive(
                  value: setting.isScheduled,
                  onChanged: (value) async {
                    if (Platform.isAndroid) {
                      final bool result =
                          await setting.scheduledRecommendedRestaurant(value);
                      if (kDebugMode) {
                        print('${value ? 'enable' : 'cancel'}: ${result ? 'success' : 'fail'}');
                      }
                    } else {}
                  });
            },
          ),
        ) // body: RestaurantList(),
        );
  }
}
