import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

var database;

void initBD({Function cb}) async {
  WidgetsFlutterBinding.ensureInitialized();

  database = openDatabase(
    join(await getDatabasesPath(), 'data.db'),
    version: 1,
    onCreate: (db, version) {
      return db.execute("CREATE TABLE IF NOT EXISTS products(key INTEGER PRIMARY KEY, name TEXT, price DOUBLE)");
    },
    onOpen: (_) {
      if (cb is Function) {
        cb();
      }
    }
  );
}