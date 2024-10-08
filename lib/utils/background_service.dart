import 'dart:ui';
import 'dart:isolate';
import 'package:bfaf_submisi_restaurant_app/data/model/restaurant_list.dart';
import 'package:bfaf_submisi_restaurant_app/main.dart';
import 'package:bfaf_submisi_restaurant_app/data/api/api_service.dart';
import 'package:bfaf_submisi_restaurant_app/utils/notification_helper.dart';

final ReceivePort port = ReceivePort();

class BackgroundService {
  static BackgroundService? _instance;
  static String _isolateName = 'isolate';
  static SendPort? _sendPort;

  BackgroundService._internal() {
    _instance = this;
  }

  factory BackgroundService() => _instance ?? BackgroundService._internal();

  void initializeIsolate() {
    IsolateNameServer.registerPortWithName(port.sendPort, _isolateName);
  }

  static Future<void> callback() async {
    print('alarm fired');

    final NotificationHelper notificationHelper = NotificationHelper();
    var result = await ApiService().fetchRestaurantList();
    await notificationHelper.showNotification(flutterLocalNotificationsPlugin, result as RestaurantListSummary);

    _sendPort ??= IsolateNameServer.lookupPortByName(_isolateName);
    _sendPort?.send(null);
  }
}