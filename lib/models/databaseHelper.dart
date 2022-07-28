// ignore_for_file: file_names

import 'dart:io';

import 'package:beefit/models/instruction.dart';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'exercise.dart';

class DatabaseHelper {
  static const _databaseName = 'beefit.db';
  static final _databaseVersion = 1;

  //constructor;
  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  Future<Database> get database async {
    if (null != _database) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  _initDatabase() async {
    var databasePath = await getDatabasesPath();
    String path = join(databasePath, _databaseName);

    //Check existing
    var exists = await databaseExists(path);
    if (!exists) {
      //if not exist
      print("Copy database start");
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {}

      //Copy
      ByteData data = await rootBundle.load(join("assets/db/", _databaseName));
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      //write
      await File(path).writeAsBytes(bytes, flush: true);
    } else {
      print("Open existing database");
    }

    return await openDatabase(path, version: _databaseVersion);
  }

  //CRUD

  //insert
  Future<int> insert(String nameTable, Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(nameTable, row);
  }

  //select all
  Future<List> getAll(String nameTable) async {
    Database db = await instance.database;
    var result = await db.query(nameTable);
    return result.toList();
  }

  //raw
  // Future<int?> getId(String nameTable)async{
  //   Database db = await instance.database;
  //   return Sqflite.firstIntValue(await db.rawQuery('SELECT IdPlan FROM $nameTable'));
  // }

  //update
  Future<int> update(Map<String, dynamic> row, String nameTable) async {
    Database db = await instance.database;
    int id = row['IdPlan'];
    return await db.update(nameTable, row, where: 'IdPlan', whereArgs: [id]);
  }

  //delete
  Future<int> delete(String item, String nameTable) async {
    Database db = await instance.database;
    return await db.delete(nameTable, where: 'img', whereArgs: [item]);
  }

  Future<List<Exercise>> getExercises() async {
    Database? db = await instance.database;
    var data = await db.query("exercises", orderBy: "name");
    List<Exercise> exercises =
        data.isNotEmpty ? data.map((e) => Exercise.fromJson(e)).toList() : [];
    return exercises;
  }

  Future<List<Instruction>> getInstructionsByIdExercise(int id) async {
    Database? db = await instance.database;
    var data = await db
        .query("instruction", where: 'exercise_id = ?', whereArgs: [id]);
    // where: 'exercise_id', whereArgs: [id], orderBy: 'step');
    // await db.rawQuery("select * from instruction where exercise_id = $id");
    List<Instruction> instructions = data.isNotEmpty
        ? data.map((e) => Instruction.fromJson(e)).toList()
        : [];
    return instructions;
  }
}
