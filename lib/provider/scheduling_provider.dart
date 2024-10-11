import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:bfaf_submisi_restaurant_app/utils/background_service.dart';
import 'package:flutter/material.dart';

class SchedulingProvider extends ChangeNotifier{
  bool _isScheduled = false;

  bool get isScheduled => _isScheduled;

  Future<bool> scheduledRestaurant(bool value) async {
    _isScheduled = value;
    if(_isScheduled) {
      print('Scheduled Restaurant');
      notifyListeners();
      return await AndroidAlarmManager.periodic(const Duration(hours: 24), 1, BackgroundService.callback,
        startAt: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 11, 0, 0),
        exact: true,
        wakeup: true,
      );
    } else {
      print('Unscheduled Restaurant');
      notifyListeners();
      return await AndroidAlarmManager.cancel(1);
    }
  }
}