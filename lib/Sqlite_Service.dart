// import 'package:flutter_app/User.dart';
// import 'package:sqflite/sqflite.dart';
// import 'package:path/path.dart';
// import 'package:flutter/widgets.dart';
//
// class SqliteService {
//
//
//
//
//
//     static void init_() async{
//       WidgetsFlutterBinding.ensureInitialized();
//       final database = openDatabase(
//         join(await getDatabasesPath(), 'alarm_database.db'),
//
//           onCreate: (db, version) {
//       return db.execute(
//       "CREATE TABLE dogs(id INTEGER PRIMARY KEY, hour INTEGER, minute INTEGER)",
//       );
//       },
//       version: 1,
//       );
//     }
//
//
//     //Method to add another Alarm.
//      Future<void> addAlarm(AlarmList simple_alarm) async {
//       final Database db = await database;
//       await db.insert(
//         'Alarms',
//         simple_alarm.toMap(),
//         conflictAlgorithm: ConflictAlgorithm.replace,
//       );
//     }
//
//
//     // A method that retrieves all the dogs from the dogs table.
//     Future<List<AlarmList>> fetchAlarms() async {
//       // Get a reference to the database.
//       final db = await database;
//
//       // Query the table for all The Dogs.
//       final List<Map<String, dynamic>> maps = await db.query('Alarms');
//
//       // Convert the List<Map<String, dynamic> into a List<Dog>.
//       return List.generate(maps.length, (i) {
//         return AlarmList(
//           id: maps[i]['id'],
//           hour: maps[i]['name'],
//           minutes: maps[i]['age'],
//         );
//       });
//     }
//
//
//
//     //Method used to delete specific alarm from the list.
//     Future<void> deleteAlarm(int id) async {
//       // Get a reference to the database.
//       final db = await database;
//       await db.delete(
//         'Alarms',
//         where: 'id = ?',
//         whereArgs: [id],
//       );
//     }
//
//   }
//
