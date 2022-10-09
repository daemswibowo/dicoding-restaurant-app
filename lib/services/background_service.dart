import 'dart:convert';
import 'dart:isolate';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:restaurant_app/services/restaurant_service.dart';
import 'package:restaurant_app/utils/notification_util.dart';

import '../models/restaurant.dart';

final ReceivePort port = ReceivePort();

class BackgroundService {
  static BackgroundService? _instance;
  static const String _isolateName = 'isolate';
  static SendPort? _uiSendPort;

  BackgroundService._internal() {
    _instance = this;
  }

  factory BackgroundService() => _instance ?? BackgroundService._internal();

  void initializeIsolate() {
    IsolateNameServer.registerPortWithName(
      port.sendPort,
      _isolateName,
    );
  }

  static Future<void> notifyRecommendedRestaurantAlarm() async {
    if (kDebugMode) {
      print('Recommended restaurant alarm fired!');
    }

    try {
      final Restaurant restaurant =
          await restaurantService.getRandomRestaurant();
      await notificationUtil.showNotification(
          '1', 'channel_01', 'restaurant channel',
          title: restaurant.name,
          body: restaurant.description,
          payload: json.encode(restaurant.toJson()));

      if (kDebugMode) {
        print('Recommended restaurant notified!');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Failed to notify recommended restaurant');
        print(e);
      }
    }

    _uiSendPort ??= IsolateNameServer.lookupPortByName(_isolateName);
    _uiSendPort?.send(null);
  }

  Future<void> someTask() async {
    print('Updated data from the background isolate');
  }
}

final BackgroundService backgroundService = BackgroundService();
