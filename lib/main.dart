import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/addAlarm.dart';
//import 'package:numberpicker/numberpicker.dart';

void main() => runApp(
      MaterialApp(
        title: 'Navigator',
        home: MyApp(),
      ),
    );
//asdljkfasd
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
          body:Container(
            padding:EdgeInsets.all(10),
            child:Stack(
              children: <Widget>[
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
                                    child: Text("Submit"),
                                    onPressed: () {
                                      // your code
                                    })
                              ],
                            );
                          });
                    },
                    backgroundColor: Colors.green,
                    child: const Icon(Icons.add_alarm_rounded),      //icon for the screen.
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
                                    child: Text("Submit"),
                                    onPressed: () {
                                      // your code
                                    })
                              ],
                            );
                          });
                    },
                    backgroundColor: Colors.green,
                    child: const Icon(Icons.remove),      //icon for the screen.
                  ),
                  ),
              ],
            ),

          ),

          drawer: Drawer(
            // Add a ListView to the drawer. This ensures the user can scroll
            // through the options in the drawer if there isn't enough vertical
            // space to fit everything.
            child: ListView(
              // Important: Remove any padding from the ListView.
              padding: EdgeInsets.zero,
              children: [
                const DrawerHeader(
                  decoration: BoxDecoration(
                    color: const Color(0xff02343F),
                  ),
                  child: Text(
                      'Options',
                      style: TextStyle(height: 5, fontSize: 30, color:const Color(0xffF0EDCC)),
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
