import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

const dbName = 'dev.db';

class SqfliteClient {
  SqfliteClient._();

  static SqfliteClient? _instance;
  static late final Database database;

  factory SqfliteClient() {
    _instance ??= SqfliteClient._();
    return _instance!;
  }

  FutureOr<Database> initDatabase() async {
    database = await openDatabase(
      version: 1,
      join(await getDatabasesPath(), dbName),
      onOpen: (db) {},
      onCreate: (db, version) {
        db.execute('CREATE TABLE dog (id INTEGER PRIMARY KEY, name TEXT)');
        db.execute('''
              CREATE TABLE if not exist user (id INTEGER PRIMARY KEY, name TEXT)
            ''');
        db.insert('dog', {
          'id': 0,
          'name': 'jon',
        }, conflictAlgorithm: ConflictAlgorithm.replace);
      },
    );
    return database;
  }
}
