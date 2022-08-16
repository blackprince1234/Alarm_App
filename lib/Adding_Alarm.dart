//Purpose: The class to manage the functions for number picker (Detects PM/AM)


//Imports for UI's
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//importing other classes
import 'package:flutter_app/Local_Notification.dart';
import 'package:flutter_app/Sqlite_Service.dart';
import 'package:flutter_app/User.dart';
import 'package:flutter/widgets.dart';

//Imports  for notification function
import 'package:numberpicker/numberpicker.dart';
import 'package:flutter_app/Local_Notification.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart'; //for local notifications
import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

//Imports for timezone
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;


class UpdateText extends StatefulWidget {
  UpdateTextState createState() => UpdateTextState();
}


class UpdateTextState extends State<UpdateText> with WidgetsBindingObserver{
  //Class member variables.
  String part_of_the_day = 'AM';  //variable used to keep track of time of the day, setting String accordingly.
  bool is_am = true;              //keeps track of PM/AM



  //InitState function (Acts like a constructor)
  @override
  void initState() {
    LocalNotification.initAll();
    super.initState();
  }


  //Function used to detect PM/AM, based on the user's scrolling
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

  static int hour = 3;   //Default hour set to 3.
  static int minute = 0; //Default minute set to 0.

  @override
  Widget build(BuildContext context) {
    //Default setting



    return Row(
        children: <Widget> [
          Text(
            part_of_the_day,
          ),

          //NumberPicker function -> Used for selecting the hour.
          StatefulBuilder(builder: (context, setState) {
            return NumberPicker(
                infiniteLoop: true,
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

          //NumberPicker function -> Used for selecting the Minutes.
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


          //(UI's for setting the alarm -> need to fix the locations and etc)
          //When the submit button is pressed
          Container(
            height: 48,
            width: 50,
            child: RaisedButton(
              child: Text(
                "Set!",
                style: TextStyle(
                  fontSize: 10,
                ),
              ),
              onPressed:() async {
                //Keeping track of time once the button is pressed & Minor Bugs
                if(!is_am && hour == 12){
                  hour = 12;
                }
                else if(!is_am){
                  hour+=12;
                }
                else if(is_am && hour == 12){
                  hour = 0;
                }
                print(is_am);
                print(hour);
                print(minute);


                //Requesting permission for notifications, registering the message.
                await LocalNotification.requestPermission();
                final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
                await LocalNotification.registerMessage(
                  hour: hour,
                  minutes: minute,
                  message: 'Wake up!',
                );


                //Shared Preferences to keep track of the ID.
                final prefs = await SharedPreferences.getInstance();
                final int counter = (prefs.getInt('counter') ?? 0) + 1;
                prefs.setInt('counter', counter);





                WidgetsFlutterBinding.ensureInitialized();
                final database = openDatabase(
                  join(await getDatabasesPath(), 'alarm_database.db'),

                  onCreate: (db, version) {
                    return db.execute(
                      "CREATE TABLE Alarms(id INTEGER PRIMARY KEY, hour INTEGER, minute INTEGER)",
                    );
                  },
                  version: 1,
                );

                //Method to add another Alarm.
                Future<void> addAlarm(AlarmList simple_alarm) async {
                  final Database db = await database;
                  await db.insert(
                    'Alarms',
                    simple_alarm.toMap(),
                    conflictAlgorithm: ConflictAlgorithm.replace,
                  );
                }


                // A method that retrieves all the dogs from the dogs table.
                Future<List<AlarmList>> fetchAlarms() async {
                  // Get a reference to the database.
                  final db = await database;

                  // Query the table for all The Dogs.
                  final List<Map<String, dynamic>> maps = await db.query('Alarms');

                  // Convert the List<Map<String, dynamic> into a List<Dog>.
                  return List.generate(maps.length, (i) {
                    return AlarmList(
                      id: maps[i]['id'],
                      hour: maps[i]['hour'],
                      minutes: maps[i]['minute'],
                    );
                  });
                }



                //Method used to delete specific alarm from the list.
                Future<void> deleteAlarm(int id) async {
                  final db = await database;
                  await db.delete(
                    'Alarms',
                    where: 'id = ?',
                    whereArgs: [id],
                  );
                }


                var fido = AlarmList(
                  id: counter,
                  hour: hour,
                  minutes: minute,
                );

                await addAlarm(fido);
                print(await fetchAlarms()); // Prints a list that include Fido.

              },
            )
          )





        ]

    );

  }
}

