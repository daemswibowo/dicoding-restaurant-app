import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:notification_permissions/notification_permissions.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/stores/setting_store.dart';

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
                    final notificationStatus = await NotificationPermissions.getNotificationPermissionStatus();
                    if (kDebugMode) {
                      print(
                          'permission notificationStatus: ${notificationStatus.name}');
                    }

                    if (value && notificationStatus.name != 'granted') {
                      // request notification permission
                      await NotificationPermissions.requestNotificationPermissions(
                          iosSettings: const NotificationSettingsIos(
                              sound: true, badge: true, alert: true));
                    }

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
