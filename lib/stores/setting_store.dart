import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart';
import 'package:restaurant_app/services/background_service.dart';
import 'package:restaurant_app/utils/date_time_util.dart';

class SettingStore extends ChangeNotifier {
  bool _isScheduled = false;

  bool get isScheduled => _isScheduled;

  Future<bool> scheduledRecommendedRestaurant(bool value) async {
    _isScheduled = value;

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isScheduled', value);

    if (_isScheduled) {
      if (kDebugMode) {
        print('Scheduling recommended restaurant activated');
      }
      notifyListeners();
      return await AndroidAlarmManager.periodic(
        const Duration(hours: 24),
        1,
        BackgroundService.notifyRecommendedRestaurantAlarm,
        startAt: DateTimeUtil.format(),
        exact: true,
        wakeup: true,
      );
    } else {
      if (kDebugMode) {
        print('Scheduling recommended restaurant canceled');
      }
      notifyListeners();
      return await AndroidAlarmManager.cancel(1);
    }
  }
}
