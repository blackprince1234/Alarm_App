import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/addAlarm.dart';
import 'package:flutter_app/local_notification.dart';

//imports for notification function
import 'package:numberpicker/numberpicker.dart';


import 'package:flutter_local_notifications/flutter_local_notifications.dart'; //for local notifications
import 'package:flutter_app_badger/flutter_app_badger.dart';

import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;


class UpdateText extends StatefulWidget {
  UpdateTextState createState() => UpdateTextState();
}

class UpdateTextState extends State<UpdateText> with WidgetsBindingObserver{
  String part_of_the_day = 'AM';
  bool is_am = true;      //keeps track of PM/AM

  //initState.
  @override
  void initState() {
    print("Innit state runnning");
    _init();
    super.initState();

  }
  Future<void> _init() async {
    await _configureLocalTimeZone();
    await _initializeNotification();
  }

  //functions for local notification
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();


  Future <void> _initializeNotification() async {
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

  Future<void> _configureLocalTimeZone() async {
    tz.initializeTimeZones();
    final String? timeZoneName = await FlutterNativeTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZoneName!));
  }

  Future <void> requestPermission() async{
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

  Future<void> _registerMessage({
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


  changeText() {
    setState(() {
      if(part_of_the_day == 'AM'){
        part_of_the_day = 'PM';
        is_am = false;
      }
      else{
        part_of_the_day = 'AM';
        is_am = true;
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    int hour = 3;
    int minute = 0;
    return Row(
        children: <Widget> [
          Text(
            part_of_the_day,
          ),
          StatefulBuilder(builder: (context, setState) {
            return NumberPicker(
                infiniteLoop: true,
                //to continuously loop
                selectedTextStyle:
                TextStyle(color: Colors.red),
                value: hour,
                minValue: 1,
                maxValue: 12,
                onChanged: (value){
                  if(value == 11 && hour ==12){
                    changeText();
                  }
                  if(value == 12 && hour == 11){
                    changeText();
                  }
                  setState(() => hour = value);
                }

            );
          }),
          StatefulBuilder(builder: (context, setState) {
            return NumberPicker(
              infiniteLoop: true,
              selectedTextStyle:
              TextStyle(color: Colors.red),
              value: minute,
              minValue: 0,
              maxValue: 59,
              onChanged: (value) =>
                  setState(() => minute = value),
            );
          }),


          //button to set the time. need to change the size.
          RaisedButton(
            child: Text("12"),
            //when the submit button is pressed
            onPressed:() async {

              if(!is_am){
                hour+=12;
              }
              print(is_am);
              print(minute);
              await requestPermission();

              final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
              await _registerMessage(
                hour: hour,
                minutes: minute,
                message: 'Hello, world!',
              );
              print(hour);
              print(minute);
              //registered notification.
            },
          )



        ]

    );

  }
}