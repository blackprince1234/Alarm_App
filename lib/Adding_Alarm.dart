//Purpose: The class to manage the functions for number picker (Detects PM/AM)


//Imports for UI's
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/Local_Notification.dart';

//Imports  for notification function
import 'package:numberpicker/numberpicker.dart';
import 'package:flutter_app/Local_Notification.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart'; //for local notifications
import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';

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



  @override
  Widget build(BuildContext context) {
    //Default setting
    int hour = 3;   //Default hour set to 3.
    int minute = 0; //Default minute set to 0.


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
          RaisedButton(
            child: Text("Set!"),
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

            },
          )



        ]

    );

  }
}