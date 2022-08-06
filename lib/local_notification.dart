//final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
//imports for notification function
import 'package:numberpicker/numberpicker.dart';


import 'package:flutter_local_notifications/flutter_local_notifications.dart'; //for local notifications
import 'package:flutter_app_badger/flutter_app_badger.dart';

import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

LocalNotification localNotification = new LocalNotification();


class LocalNotification{
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();




  //Static으로 하면 안됨.
  void requestPermission(){

  }


}
// Future<void> _init() async {
//   await _configureLocalTimeZone();
//   await _initializeNotification();
// }
// @override
// void initState() {
//   //initializing.
//   print("initializing");
//   _init();
//   super.initState();
//
// }
//
//
//
// @override
// void didChangeAppLifecycleState(AppLifecycleState state) {
//   if (state == AppLifecycleState.resumed) {
//     FlutterAppBadger.removeBadge();
//   }
// }
//
//
//
// Future<void> _configureLocalTimeZone() async {
//   tz.initializeTimeZones();
//   final String? timeZoneName = await FlutterNativeTimezone.getLocalTimezone();
//   tz.setLocalLocation(tz.getLocation(timeZoneName!));
// }
//
// //create a new instance, initialize settings

//
//
//
//
//

// //
// Future<void> _registerMessage({
//
//   required int hour,
//   required int minutes,
//   required message,
// }) async {
//   final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
//   tz.TZDateTime scheduledDate = tz.TZDateTime(
//     tz.local,
//     now.year,
//     now.month,
//     now.day,
//     hour,
//     minutes,
//   );
//
//   await _flutterLocalNotificationsPlugin.zonedSchedule(
//     0,
//     'flutter_local_notifications',
//     message,
//     scheduledDate,
//     NotificationDetails(
//       android: AndroidNotificationDetails(
//         'channel id',
//         'channel name',
//         importance: Importance.max,
//         priority: Priority.high,
//         ongoing: true,
//         styleInformation: BigTextStyleInformation(message),
//         icon: 'ic_notification',
//       ),
//       iOS: const IOSNotificationDetails(
//         badgeNumber: 1,
//       ),
//     ),
//     androidAllowWhileIdle: true,
//     uiLocalNotificationDateInterpretation:
//     UILocalNotificationDateInterpretation.absoluteTime,
//     matchDateTimeComponents: DateTimeComponents.time,
//   );
// }