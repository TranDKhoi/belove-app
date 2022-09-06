import 'package:belove_app/app/global_data/global_key.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class PushNotificationService {
  PushNotificationService._();
  static final ins = PushNotificationService._();
  static final _notification = FlutterLocalNotificationsPlugin();

  Future<void> initialize() async {
    const androidSetting =
    AndroidInitializationSettings("@drawable/ic_stat_sms");
    var iosSetting = IOSInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
        onDidReceiveLocalNotification: _onDidReceiveLocalNotification);
    final settings = InitializationSettings(
        android: androidSetting, iOS: iosSetting);
    await _notification.initialize(
        settings, onSelectNotification: onSelectNotification);
  }

  Future showMessageNotification({
    int id = 0,
    String? title,
    String? body,
    String? payload,
  }) async {
    final details = await _notificationDetails();
    return _notification.show(id, title, body, details,
        payload: payload);
  }

  Future<NotificationDetails> _notificationDetails() async {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        "channel id",
        "channel name",
        channelDescription: "channel des",
        priority: Priority.max,
        importance: Importance.max,
        playSound: true,
      ),
      iOS: IOSNotificationDetails(),
    );
  }

  void _onDidReceiveLocalNotification(int id, String? title, String? body,
      String? payload) {
    print("id: $id");
  }

  void onSelectNotification(String? payload) {
    navigatorKey.currentState?.pushNamed(payload!);
  }
}
