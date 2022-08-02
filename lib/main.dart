import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/addAlarm.dart';

void main() => runApp(
      MaterialApp(
        title: 'Navigator',
        home: MyApp(),
      ),
    );

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: new ThemeData(scaffoldBackgroundColor: const Color(0xffF0EDCC)),
        home: Scaffold(
          appBar: AppBar(
            backgroundColor: const Color(0xff02343F),
            leading: IconButton(
              icon: Icon(
                Icons.menu,
                size: 50, //size of the icon
                color: Colors.white,
              ),
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
            ),
            actions: [Icon(Icons.access_alarms)],
            title: Text(
              'Alarm',
              style: TextStyle(color: const Color(0xffF0EDCC)),
            ),
          ),
          body: Container(child: Icon(Icons.star)),
          bottomNavigationBar: BottomAppBar(
            child: SizedBox(
              height: 70,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
