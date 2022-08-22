import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/Local_Notification.dart';
import 'package:flutter_app/Sqlite_Service.dart';

//imports for notification function
import 'package:numberpicker/numberpicker.dart';


import 'package:flutter_local_notifications/flutter_local_notifications.dart'; //for local notifications
import 'package:flutter_app_badger/flutter_app_badger.dart';

import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class LocalNotification{
  static Future<void>  initAll() async {
    await _configureLocalTimeZone();
    await _initializeNotification();

  }

  //functions for local notification
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();


  static Future <void> _initializeNotification() async {
    //android
    const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('@drawable/ic_notification');
    //ios
    const IOSInitializationSettings initializationSettingsIOS = IOSInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );
    //combining
    const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  //location

  static Future<void> _configureLocalTimeZone() async {
    tz.initializeTimeZones();
    final String? timeZoneName = await FlutterNativeTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZoneName!));
  }

  static Future <void> requestPermission() async{
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
      alert: true,
      badge: true,
      sound: true,
    );
  }


  //to Register Message.

  static Future<void> registerMessage({
    required int hour,
    required int minutes,
    required message,
  }) async {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      hour,
      minutes,
    );

    const int insistentFlag = 4;
    await flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      'flutter_local_notifications',
      message,
      scheduledDate,
      NotificationDetails(
        android: AndroidNotificationDetails(
          'channel id',
          'channel name',
          importance: Importance.max,
          additionalFlags: Int32List.fromList(<int>[insistentFlag]),
          priority: Priority.high,
          ongoing: true,
          styleInformation: BigTextStyleInformation(message),
          icon: 'ic_notification',
        ),
        iOS: const IOSNotificationDetails(
          badgeNumber: 1,
        ),
      ),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
      UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }
}