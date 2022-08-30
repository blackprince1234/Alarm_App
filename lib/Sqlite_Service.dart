//Custom Imports
import 'package:flutter_app/User.dart';

//Functional Imports
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:flutter/widgets.dart';


class SqliteService {
  //creating new Database, creating a new table.
  static void init_() async {
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
  }

  //A method that adds/inserts an Alarm to the list.
  static Future<void> addAlarm(AlarmList Alarm) async {
    final database = openDatabase(
      join(await getDatabasesPath(), 'alarm_database.db'),
      version: 1,
    );
    final db = await database;

    // Query the table for all The Dogs.
    final List<Map<String, dynamic>> maps = await db.query('Alarms');
    await db.insert(
      'Alarms',
      Alarm.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }



  // A method that retrieves all the dogs from the dogs table.
  static Future<List<AlarmList>> fetchAlarms() async {
    final database = openDatabase(
      join(await getDatabasesPath(), 'alarm_database.db'),
      version: 1,
    );

    final db = await database;
    int count = 0;
    // Query the table for all the alarms.
    final List<Map<String, dynamic>> maps = await db.query('Alarms');

    return List.generate(maps.length, (i) {
      return AlarmList(
        id: maps[i]['id'],
        hour: maps[i]['hour'],
        minutes: maps[i]['minute'],
      );
    });
  }



  // A method that retrieves the alarm at specific index.
  static Future<AlarmList> specificIndex(int ID_) async {
    final database = openDatabase(
      join(await getDatabasesPath(), 'alarm_database.db'),
      version: 1,
    );
    final db = await database;
    // Query the table for all the alarms.
    final List<Map<String, dynamic>> maps = await db.query('Alarms');
      return AlarmList(
        id: maps[ID_]['id'],
        hour: maps[ID_]['hour'],
        minutes: maps[ID_]['minute'],
      );
  }
  // A method that retrieves all the dogs from the dogs table.
  static Future<int> getSize() async {
    final database = openDatabase(
      join(await getDatabasesPath(), 'alarm_database.db'),
      version: 1,
    );

    final db = await database;
    int count = 0;
    // Query the table for all the alarms.
    final List<Map<String, dynamic>> maps = await db.query('Alarms');
    int size = maps.length;
    print("LENGTH: $size");
    return maps.length;

  }






//Method used to delete specific alarm from the list.
      // Future<void> deleteAlarm(int id) async {
      //   // Get a reference to the database.
      //   final db = await database;
      //   await db.delete(
      //     'Alarms',
      //     where: 'id = ?',
      //     whereArgs: [id],
      //   );
      // }
    }






