//Purpose: The home screen of the app, has floating buttons to add and subtract alarms.


//imports for UI
import 'dart:ffi';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:flutter_app/Local_Notification.dart';
import 'package:flutter_app/Adding_Alarm.dart';
//imports for notification function
import 'package:numberpicker/numberpicker.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:sqflite/sqflite.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:flutter/widgets.dart';
import 'Sqlite_Service.dart';
import 'User.dart';




void main() async => runApp (
      MaterialApp(
        title: 'Navigator',
        home: MyDemo(),
      ),
    );

class MyDemo extends StatefulWidget  {
  @override
  MyApp createState() => MyApp();
}


class MyApp extends State<MyDemo>{
  List<int> hours = [];
  List<int> minutes = [];


  Future<int> getHour(int position) async{
    // print(await SqliteService.fetchAlarms());
    AlarmList alarm = await SqliteService.specificIndex(position);
    int user_hour = alarm.hour;
    // print("USER HOUR $user_hour");
    return user_hour;
  }
  Future<int> getMinute(int position) async{
    // print(await SqliteService.fetchAlarms());
    AlarmList alarm = await SqliteService.specificIndex(position);
    int user_minutes = alarm.minutes;
    // print("USER HOUR $user_hour");
    return user_minutes;
  }
  //need to work on length.
  Future<int> Size() async{
    SqliteService.init_();
    int length = (await SqliteService.getSize());
    print("LENGTH $length");
    return length;
  }


  //Testing.
  @override
  void initState() {
    int size = 0;
    Size().then(
            (value){
              size = value;
              print("Size $value");
            }
    );

    for(int i=0; i<size; i++){
      getHour(i).then(
              (value){
            int hour = value;
            hours.add(hour);
          }
      );
    }

    super.initState();
  }





  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: new ThemeData(scaffoldBackgroundColor: const Color(0xffF0EDCC)),
        home: Scaffold(
          appBar: AppBar(
            backgroundColor: const Color(0xff02343F),
            actions: [Icon(Icons.access_alarms)],
            title: Text(
              'Alarm',
              style: TextStyle(color: const Color(0xffF0EDCC)),
            ),
          ),
          body: Container(
            padding: EdgeInsets.all(10),
            child: Stack(
              children: <Widget >[
                ListView.builder(
                    itemCount: hours.length,
                    itemBuilder: (context, position) {
                      //might need to fix the position +1 part.
                    int getHour = hours[position+1];
                    print("Got Hour $getHour Position $position");

                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text(
                          "HI",
                         // getHour.toString(),
                          style: TextStyle(fontSize: 22.0),
                        ),
                      ),
                    );

                  },
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: FloatingActionButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              scrollable: true,
                              title: Text('Add New Alarm'),
                              content:
                                  UpdateText(),
                            );
                          });
                    },
                    backgroundColor: Colors.green,
                    child: const Icon(
                        Icons.add_alarm_rounded), //icon for the screen.
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: FloatingActionButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              scrollable: true,
                              title: Text('Add New Alarm'),
                              content: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Form(
                                  child: Column(
                                    children: <Widget>[
                                      TextFormField(
                                        decoration: InputDecoration(
                                          labelText: 'Name',
                                          icon: Icon(Icons.account_box),
                                        ),
                                      ),
                                      TextFormField(
                                        decoration: InputDecoration(
                                          labelText: 'Email',
                                          icon: Icon(Icons.email),
                                        ),
                                      ),
                                      TextFormField(
                                        decoration: InputDecoration(
                                          labelText: 'Message',
                                          icon: Icon(Icons.message),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              actions: [
                                RaisedButton(
                                    child: Text("Add"),
                                    onPressed: () {

                                    })
                              ],
                            );
                          });
                    },
                    backgroundColor: Colors.green,
                    child: const Icon(Icons.remove), //icon for the screen.
                  ),
                ),
              ],
            ),
          ),
          drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                const DrawerHeader(
                  decoration: BoxDecoration(
                    color: const Color(0xff02343F),
                  ),
                  child: Text(
                    'Options',
                    style: TextStyle(
                        height: 5,
                        fontSize: 30,
                        color: const Color(0xffF0EDCC)),
                  ),
                ),
                ListTile(
                  title: const Text('Item 1'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),

                ListTile(
                  title: const Text('Item 2'),
                  onTap: () {
                    // Update the state of the app
                    // ...
                    // Then close the drawer
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
          bottomNavigationBar: BottomAppBar(
            child: SizedBox(
              height: 70,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                      icon: Icon(
                        Icons.exit_to_app,
                        size: 30, //size of the icon
                        color: Colors.black,
                      ),
                      onPressed: () {
                        SystemNavigator.pop();
                      }),
                ],
              ),
            ),
          ),
        ));
  }
}
