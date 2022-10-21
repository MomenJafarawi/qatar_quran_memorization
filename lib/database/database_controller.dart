import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBController {
  static DBController? _instance;
  late Database _database;

  DBController._();

  factory DBController() {
    return _instance ??= DBController._();
  }

  Database get database => _database;

  Future<void> initDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, 'quran_db.sql');
    _database = await openDatabase(path,
        version: 1, onOpen: (Database database) {},
        onCreate: (Database database, int version) async {
      await database.execute('CREATE TABLE users('
          'id INTEGER PRIMARY KEY AUTOINCREMENT,'
          'name TEXT NOT NULL,'
          'identification_number INTEGER NOT NULL,'
          'group_name TEXT NOT NULL,'
          'password TEXT NOT NULL'
          ')');

      await database.execute('CREATE TABLE students ('
          'id INTEGER PRIMARY KEY AUTOINCREMENT,'
          'student_name TEXT NOT NULL,'
          'arrived_to TEXT NOT NULL,'
          'level TEXT NOT NULL,'
          'average REAL NOT NULL,'
          'date_of_birthday TEXT NOT NULL,'
          'identification INTEGER NOT NULL,'
          'address TEXT NOT NULL,'
          'phone_number INTEGER NOT NULL,'
          'parent_phone_number INTEGER NOT NULL,'
          'user_id INTEGER,'
          'FOREIGN KEY (user_id) references users(id)'
          ')');
    },
        onUpgrade: (Database database, int oldversion, int newversion) {},
        onDowngrade: (Database database, int oldversion, int newversion) {});
  }
}
