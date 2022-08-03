// ignore_for_file: file_names

import 'dart:io';

import 'package:beefit/models/PlamExerciseDetail.dart';
import 'package:beefit/models/challenge.dart';
import 'package:beefit/models/challenge_detail.dart';
import 'package:beefit/models/food_history.dart';
import 'package:beefit/models/instruction.dart';
import 'package:beefit/models/plan.dart';
import 'package:beefit/models/plan_details.dart';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'defaultReps.dart';
import 'exercise.dart';

class DatabaseHelper {
  static const _databaseName = 'beefit.db';
  static final _databaseVersion = 3;

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
  Future<int> update(
      Map<String, dynamic> row, String nameTable, int id, String title) async {
    Database db = await instance.database;
    int id = row[title];
    return await db.update(nameTable, row, where: title, whereArgs: [id]);
  }

  Future<bool> updateRawQuery(
      Map<String, dynamic> row, String nameTable, int id, String title) async {
    Database db = await instance.database;
    try {
      print(row);
      String day = row['date'];
      await db.rawQuery(
          "Update $nameTable SET date = $day, kcal = ${row['kcal']}, status = ${row['status']} where id = $id");
      return true;
    } catch (e) {
      return false;
    }
  }

  //delete
  Future<bool> deleteRaw(int item, String nameTable, String column) async {
    Database db = await instance.database;
    try {
      await db.rawQuery("Delete from $nameTable where $column = $item");
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<List<FoodHistory>> getFoodHistory() async {
    Database? db = await instance.database;
    var data = await db.query("food_history");
    List<FoodHistory> exercises = data.isNotEmpty
        ? data.map((e) => FoodHistory.fromJson(e)).toList()
        : [];
    return exercises;
  }

  Future<List<FoodHistory>> getFoodHistoryByMeal(int idMeal) async {
    Database? db = await instance.database;
    var data =
        await db.rawQuery("Select * from food_history where meal = $idMeal");
    List<FoodHistory> exercises = data.isNotEmpty
        ? data.map((e) => FoodHistory.fromJson(e)).toList()
        : [];
    return exercises;
  }

  Future<List<FoodHistory>> getFoodHistoryByMealAndDay(
      int idMeal, String date) async {
    Database? db = await instance.database;
    var data = await db.rawQuery(
        "Select * from food_history where meal = $idMeal and fday = \"$date\"");
    List<FoodHistory> exercises = data.isNotEmpty
        ? data.map((e) => FoodHistory.fromJson(e)).toList()
        : [];
    return exercises;
  }

  Future<List<FoodHistory>> getFoodHistoryByDay(String date) async {
    Database? db = await instance.database;
    var data =
        await db.rawQuery("Select * from food_history where fday = \"$date\"");
    List<FoodHistory> exercises = data.isNotEmpty
        ? data.map((e) => FoodHistory.fromJson(e)).toList()
        : [];
    return exercises;
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

  Future<List<Exercise>> searchExerciseByName(String keyword) async {
    Database? db = await instance.database;
    var data = await db
        .rawQuery("SELECT * FROM exercises WHERE name LIKE \"$keyword\%\"");
    List<Exercise> exercises =
        data.isNotEmpty ? data.map((e) => Exercise.fromJson(e)).toList() : [];
    return exercises;
  }

  Future<List<Exercise>> getExerciseByBodyPart(int idPart) async {
    Database? db = await instance.database;
    var data = await db.rawQuery(
        "select a.id, a.name, a.description, a.gif , a.level, a.met, a.type , a.rest_duration, a.isRepCount from exercises a join bodyparts_exercises b on a.id = b.exercise_id where b.bodypart_id = $idPart");
    List<Exercise> exercises =
        data.isNotEmpty ? data.map((e) => Exercise.fromJson(e)).toList() : [];
    return exercises;
  }

  Future<List<Exercise>> filterExercise(
      List<int> categories, List<int> levels, List<int> types) async {
    late String category, level, type;
    String optionCategory1 = "",
        optionCategory2 = "",
        optionLevel = "",
        optionType = "",
        optionWhere = "";
    String header =
        "select a.id, a.name, a.description, a.gif , a.level, a.met, a.type , a.rest_duration, a.isRepCount from exercises a";
    Database? db = await instance.database;
    if (categories.isNotEmpty) {
      category = categories.toString().replaceAll('[', '').replaceAll(']', '');
      optionCategory1 = "join bodyparts_exercises b on a.id = b.exercise_id";
      optionCategory2 = "b.bodypart_id in ($category)";
    }
    if (levels.isNotEmpty) {
      level = levels.toString().replaceAll('[', '').replaceAll(']', '');
      optionLevel = "a.level in ($level)";
    }
    if (types.isNotEmpty) {
      type = types.toString().replaceAll('[', '').replaceAll(']', '');
      optionType = "a.type in ($type)";
    }

    if (optionType.isNotEmpty &&
        optionLevel.isNotEmpty &&
        optionCategory2.isNotEmpty) {
      optionWhere = "Where $optionLevel and $optionType and $optionCategory2";
    } else if (optionType.isEmpty &&
        optionCategory2.isEmpty &&
        optionLevel.isNotEmpty) {
      optionWhere = "Where $optionLevel";
    } else if (optionType.isNotEmpty &&
        optionCategory2.isEmpty &&
        optionLevel.isEmpty) {
      optionWhere = "Where $optionType";
    } else if (optionType.isEmpty &&
        optionCategory2.isNotEmpty &&
        optionLevel.isEmpty) {
      optionWhere = "Where $optionCategory2";
    } else if (optionType.isEmpty &&
        optionCategory2.isNotEmpty &&
        optionLevel.isNotEmpty) {
      optionWhere = "Where $optionCategory2 and $optionLevel";
    } else if (optionType.isNotEmpty &&
        optionCategory2.isEmpty &&
        optionLevel.isNotEmpty) {
      optionWhere = "Where $optionType and $optionLevel";
    } else if (optionType.isNotEmpty &&
        optionCategory2.isNotEmpty &&
        optionLevel.isEmpty) {
      optionWhere = "Where $optionType and $optionCategory2";
    }
    var data = await db.rawQuery("$header $optionCategory1 $optionWhere");
    List<Exercise> exercises =
        data.isNotEmpty ? data.map((e) => Exercise.fromJson(e)).toList() : [];
    return exercises;
  }

  Future<List<Plan>> getPlan() async {
    Database? db = await instance.database;
    var data = await db.query("plans");
    List<Plan> plans =
        data.isNotEmpty ? data.map((e) => Plan.fromJson(e)).toList() : [];
    return plans;
  }

  Future<Plan> getPlanById(int id) async {
    Database? db = await instance.database;
    var data = await db.rawQuery(
        "SELECT * from plans where name='Personal Workout Plan' order by id desc limit 1");
    print(data);
    Plan plans = Plan.fromJson(data[0] as Map<String, dynamic>);
    return plans;
  }

  Future<List<PlanDetail>> getPlanDetailById(int id) async {
    Database? db = await instance.database;
    var data =
        await db.rawQuery("Select * from plan_details where plan_id = $id");
    List<PlanDetail> plans =
        data.isNotEmpty ? data.map((e) => PlanDetail.fromJson(e)).toList() : [];
    return plans;
  }

  Future<List<PlanDetail>> getPlanDetailByIdAndWeek(int id, int week) async {
    Database? db = await instance.database;
    var data = await db.rawQuery(
        "Select * from plan_details where plan_id = $id and week = $week");
    List<PlanDetail> plans =
        data.isNotEmpty ? data.map((e) => PlanDetail.fromJson(e)).toList() : [];
    return plans;
  }

  Future<List<PlanExerciseDetail>> getPlanDayByDay(
      int day, int userLevel, int week) async {
    Database? db = await instance.database;
    var data = await db.rawQuery(
        "select c.id, c.name, c.description, c.gif , c.level, c.met, c.type , c.rest_duration, c.isRepCount, e.rep, e.duration , b.kcal, b.id as idPlanDetail" +
            " from plans a join plan_details b on a.id = b.plan_id join exercises c on b.exercise_id = c.id join bodyparts_exercises d on c.id = d.exercise_id join default_reps e on d.bodypart_id = e.bodypart_id" +
            " where b.day = $day and b.week = $week and e.user_level = $userLevel and e.bodypart_id = a.bodypart_id");
    List<PlanExerciseDetail> plans = data.isNotEmpty
        ? data.map((e) => PlanExerciseDetail.fromJson(e)).toList()
        : [];
    return plans;
  }

  Future<List<PlanExerciseDetail>> getPlanDayByDate(String date) async {
    Database? db = await instance.database;
    var data = await db.rawQuery(
        "select c.id, c.name, c.description, c.gif , c.level, c.met, c.type , c.rest_duration, c.isRepCount, e.rep, e.duration , b.kcal, b.id as idPlanDetail" +
            " from plans a join plan_details b on a.id = b.plan_id join exercises c on b.exercise_id = c.id join bodyparts_exercises d on c.id = d.exercise_id join default_reps e on d.bodypart_id = e.bodypart_id" +
            " where b.date = $date");
    List<PlanExerciseDetail> plans = data.isNotEmpty
        ? data.map((e) => PlanExerciseDetail.fromJson(e)).toList()
        : [];
    return plans;
  }

  Future<DefaultReps> getDefaultRepByIdBodyPart(int id, int level) async {
    Database? db = await instance.database;
    var data = await db.rawQuery(
        "select  * from default_reps where bodypart_id = $id and user_level = $level");
    DefaultReps defaultReps = DefaultReps.fromJson(data[0]);
    return defaultReps;
  }

  Future<List<DefaultReps>> getDefaultRepByLevel(int level) async {
    Database? db = await instance.database;
    var data = await db
        .rawQuery("select  * from default_reps where user_level = $level");
    List<DefaultReps> defaultReps = data.isNotEmpty
        ? data.map((e) => DefaultReps.fromJson(e)).toList()
        : [];
    return defaultReps;
  }

  Future<List<DefaultReps>> getDefaultRep() async {
    Database? db = await instance.database;
    var data = await db.rawQuery("select  * from default_reps");
    List<DefaultReps> defaultReps = data.isNotEmpty
        ? data.map((e) => DefaultReps.fromJson(e)).toList()
        : [];
    return defaultReps;
  }

  Future<List<Challenge>> getChallenges() async {
    Database? db = await instance.database;
    var data = await db.query("challenges");
    List<Challenge> plans =
        data.isNotEmpty ? data.map((e) => Challenge.fromJson(e)).toList() : [];
    return plans;
  }

  Future<List<ChallengeDetail>> getChallengeDetailById(
      int id, int level) async {
    Database? db = await instance.database;
    var data = await db.rawQuery(
        "select b.exercise_id, c.name, c.description, c.gif , c.level, c.met, c.type , c.rest_duration, c.isRepCount, e.rep, e.duration , b.id, b.kcal, b.\"date\",b.status " +
            "from challenges a join challenge_details b on a.id = b.challenge_id join exercises c on b.exercise_id = c.id join bodyparts_exercises d on c.id = d.exercise_id join default_reps e on d.bodypart_id = e.bodypart_id " +
            "where challenge_id = $id and e.user_level = $level and a.bodypart_id = e.bodypart_id");
    List<ChallengeDetail> plans = data.isNotEmpty
        ? data.map((e) => ChallengeDetail.fromJson(e)).toList()
        : [];
    return plans;
  }

  //======================================================================================

  Future<bool> generatePlan(
      {required int goalIndex,
      required int bodypartId,
      required int userLevel}) async {
    final db = await instance.database;

    //Warm up exercises
    int absWU = 1;
    List<int> armchestWU = [32, 25, 31, 71];
    List<int> legbuttWU = [1, 43, 42, 70];

    //Main exercises by each level
    List<int> fullbodyEXs = [26, 33]; //Fullbody or cardio exercises

    List<int> absEXs1 = [58, 2, 48, 53, 12, 5, 4, 3, 46];
    List<int> absEXs2 = [13, 10, 6, 7, 11, 15, 16];
    int absEXs3 = 3;

    List<int> armchestEXs1 = [17, 18, 38, 34];
    List<int> armchestEXs2 = [37, 19, 45, 64, 39, 20];
    List<int> armchestEXs3 = [23, 28, 27, 29, 21, 40, 68, 41];

    List<int> legbuttEXs1 = [58, 48, 53, 12, 66, 46, 57, 61, 67];
    List<int> legbuttEXs2 = [59, 54, 47, 44, 55, 56];
    int legbuttEXs3 = 60;

    List<int> shoulderbackEXs1 = [69, 69, 72, 62, 77];
    List<int> shoulderbackEXs2 = [45, 64, 39, 20];
    List<int> shoulderbackEXs3 = [28, 29, 21, 68, 41];

    //Stretch exercises
    List<int> armchestSTs = [22, 8, 30, 36, 35];
    List<int> absSTs = [22, 65, 8];
    List<int> legbuttSTs = [65, 50, 49, 52];
    List<int> shoulderbackSTs = [22, 63, 65, 24, 9];
    List<int> upperSTs = [22, 63, 65, 8, 24, 30, 36, 9, 35];

    var planID = 0;
    bool isDone = false;

    //Add personal plan
    await db!
        .rawInsert(
            "INSERT INTO plans(name, bodypart_id, image, description, user_level) VALUES ('Personal Workout Plan', $bodypartId, 'personal-workout-plan','This personal workout plan is a set of exercises for 4 weeks, we created to help you achieve your goal and your desired physique. Try it out now to see how your body will change.', $userLevel)")
        .then((value) => planID = value);

    if (planID != 0) {
      //Beginner
      if (userLevel == 1) {
        //Lose weight lv1
        if (goalIndex == 0) {
          for (var w = 1; w < 5; w++) {
            for (var d = 1; d < 8; d++) {
              //1 warm up
              await db.rawInsert(
                  "INSERT INTO plan_details(plan_id, week, day, exercise_id)VALUES ($planID, $w, $d, ${(legbuttWU.toList()..shuffle()).first})");
              //2 chest/arm lv1
              await db.rawInsert(
                  "INSERT INTO plan_details(plan_id, week, day, exercise_id)VALUES ($planID, $w, $d, ${(armchestEXs1.toList()..shuffle()).first})");
              await db.rawInsert(
                  "INSERT INTO plan_details(plan_id, week, day, exercise_id)VALUES ($planID, $w, $d, ${(armchestEXs1.toList()..shuffle()).first})");
              //2 abs lv1
              await db.rawInsert(
                  "INSERT INTO plan_details(plan_id, week, day, exercise_id)VALUES ($planID, $w, $d, ${(absEXs1.toList()..shuffle()).first})");
              await db.rawInsert(
                  "INSERT INTO plan_details(plan_id, week, day, exercise_id)VALUES ($planID, $w, $d, ${(absEXs1.toList()..shuffle()).first})");
              //2 back/shoulder lv1
              await db.rawInsert(
                  "INSERT INTO plan_details(plan_id, week, day, exercise_id)VALUES ($planID, $w, $d, ${(shoulderbackEXs1.toList()..shuffle()).first})");
              await db.rawInsert(
                  "INSERT INTO plan_details(plan_id, week, day, exercise_id)VALUES ($planID, $w, $d, ${(shoulderbackEXs1.toList()..shuffle()).first})");
              //1 fullbody
              await db.rawInsert(
                  "INSERT INTO plan_details(plan_id, week, day, exercise_id)VALUES ($planID, $w, $d, ${(fullbodyEXs.toList()..shuffle()).first})");
              //2 leg/butt lv1
              await db.rawInsert(
                  "INSERT INTO plan_details(plan_id, week, day, exercise_id)VALUES ($planID, $w, $d, ${(legbuttEXs1.toList()..shuffle()).first})");
              await db.rawInsert(
                  "INSERT INTO plan_details(plan_id, week, day, exercise_id)VALUES ($planID, $w, $d, ${(legbuttEXs1.toList()..shuffle()).first})");
              //1 arm stretch
              await db.rawInsert(
                  "INSERT INTO plan_details(plan_id, week, day, exercise_id)VALUES ($planID, $w, $d, ${(upperSTs.toList()..shuffle()).first})");
              //1 lower stretch
              await db.rawInsert(
                  "INSERT INTO plan_details(plan_id, week, day, exercise_id)VALUES ($planID, $w, $d, ${(legbuttSTs.toList()..shuffle()).first})");
              //For the rest day
              if (d == 7) {
                await db.rawInsert(
                    "INSERT INTO plan_details(plan_id, week, day, is_restday)VALUES ($planID, $w, 7, 1)");
              }
              isDone = true;
            }
          }
        }
        //Build muscle lv1
        else if (goalIndex == 1) {
          //Arm/chest workout lv1
          if (bodypartId == 1 || bodypartId == 2) {
            for (var w = 1; w < 5; w++) {
              for (var d = 1; d < 8; d++) {
                //1 warm up
                await db.rawInsert(
                    "INSERT INTO plan_details(plan_id, week, day, exercise_id)VALUES ($planID, $w, $d, ${(armchestWU.toList()..shuffle()).first})");
                //2 lv1
                await db.rawInsert(
                    "INSERT INTO plan_details(plan_id, week, day, exercise_id)VALUES ($planID, $w, $d, ${(armchestEXs1.toList()..shuffle()).first})");
                await db.rawInsert(
                    "INSERT INTO plan_details(plan_id, week, day, exercise_id)VALUES ($planID, $w, $d, ${(armchestEXs1.toList()..shuffle()).first})");
                //2 lv2
                await db.rawInsert(
                    "INSERT INTO plan_details(plan_id, week, day, exercise_id)VALUES ($planID, $w, $d, ${(armchestEXs2.toList()..shuffle()).first})");
                await db.rawInsert(
                    "INSERT INTO plan_details(plan_id, week, day, exercise_id)VALUES ($planID, $w, $d, ${(armchestEXs2.toList()..shuffle()).first})");
                //2 lv1
                await db.rawInsert(
                    "INSERT INTO plan_details(plan_id, week, day, exercise_id)VALUES ($planID, $w, $d, ${(armchestEXs1.toList()..shuffle()).first})");
                await db.rawInsert(
                    "INSERT INTO plan_details(plan_id, week, day, exercise_id)VALUES ($planID, $w, $d, ${(armchestEXs1.toList()..shuffle()).first})");
                //1 stretch
                await db.rawInsert(
                    "INSERT INTO plan_details(plan_id, week, day, exercise_id)VALUES ($planID, $w, $d, ${(armchestSTs.toList()..shuffle()).first})");
                //For the rest day
                if (d == 6 || d == 7) {
                  await db.rawInsert(
                      "INSERT INTO plan_details(plan_id, week, day, is_restday)VALUES ($planID, $w, $d, 1)");
                }
                isDone = true;
              }
            }
          }
          //Abs workout lv1
          else if (bodypartId == 3) {
            for (var w = 1; w < 5; w++) {
              for (var d = 1; d < 8; d++) {
                //1 warm up
                await db.rawInsert(
                    "INSERT INTO plan_details(plan_id, week, day, exercise_id)VALUES ($planID, $w, $d, $absWU)");
                //3 lv1
                await db.rawInsert(
                    "INSERT INTO plan_details(plan_id, week, day, exercise_id)VALUES ($planID, $w, $d, ${(absEXs1.toList()..shuffle()).first})");
                await db.rawInsert(
                    "INSERT INTO plan_details(plan_id, week, day, exercise_id)VALUES ($planID, $w, $d, ${(absEXs1.toList()..shuffle()).first})");
                await db.rawInsert(
                    "INSERT INTO plan_details(plan_id, week, day, exercise_id)VALUES ($planID, $w, $d, ${(absEXs1.toList()..shuffle()).first})");
                //2 lv2
                await db.rawInsert(
                    "INSERT INTO plan_details(plan_id, week, day, exercise_id)VALUES ($planID, $w, $d, ${(absEXs2.toList()..shuffle()).first})");
                await db.rawInsert(
                    "INSERT INTO plan_details(plan_id, week, day, exercise_id)VALUES ($planID, $w, $d, ${(absEXs2.toList()..shuffle()).first})");
                //3 lv1
                await db.rawInsert(
                    "INSERT INTO plan_details(plan_id, week, day, exercise_id)VALUES ($planID, $w, $d, ${(absEXs1.toList()..shuffle()).first})");
                await db.rawInsert(
                    "INSERT INTO plan_details(plan_id, week, day, exercise_id)VALUES ($planID, $w, $d, ${(absEXs1.toList()..shuffle()).first})");
                await db.rawInsert(
                    "INSERT INTO plan_details(plan_id, week, day, exercise_id)VALUES ($planID, $w, $d, ${(absEXs1.toList()..shuffle()).first})");
                //1 stretch
                await db.rawInsert(
                    "INSERT INTO plan_details(plan_id, week, day, exercise_id)VALUES ($planID, $w, $d, ${(absSTs.toList()..shuffle()).first})");
                //For the rest day
                if (d == 6 || d == 7) {
                  await db.rawInsert(
                      "INSERT INTO plan_details(plan_id, week, day, is_restday)VALUES ($planID, $w, $d, 1)");
                }
                isDone = true;
              }
            }
          }
          //Leg/butt workout lv1
          else if (bodypartId == 4 || bodypartId == 5) {
            for (var w = 1; w < 5; w++) {
              for (var d = 1; d < 8; d++) {
                //1 warm up
                await db.rawInsert(
                    "INSERT INTO plan_details(plan_id, week, day, exercise_id)VALUES ($planID, $w, $d, ${(legbuttWU.toList()..shuffle()).first})");
                //2 lv1
                await db.rawInsert(
                    "INSERT INTO plan_details(plan_id, week, day, exercise_id)VALUES ($planID, $w, $d, ${(legbuttEXs1.toList()..shuffle()).first})");
                await db.rawInsert(
                    "INSERT INTO plan_details(plan_id, week, day, exercise_id)VALUES ($planID, $w, $d, ${(legbuttEXs1.toList()..shuffle()).first})");
                //2 lv2
                await db.rawInsert(
                    "INSERT INTO plan_details(plan_id, week, day, exercise_id)VALUES ($planID, $w, $d, ${(legbuttEXs2.toList()..shuffle()).first})");
                await db.rawInsert(
                    "INSERT INTO plan_details(plan_id, week, day, exercise_id)VALUES ($planID, $w, $d, ${(legbuttEXs2.toList()..shuffle()).first})");
                //2 lv1
                await db.rawInsert(
                    "INSERT INTO plan_details(plan_id, week, day, exercise_id)VALUES ($planID, $w, $d, ${(legbuttEXs1.toList()..shuffle()).first})");
                await db.rawInsert(
                    "INSERT INTO plan_details(plan_id, week, day, exercise_id)VALUES ($planID, $w, $d, ${(legbuttEXs1.toList()..shuffle()).first})");
                //1 stretch
                await db.rawInsert(
                    "INSERT INTO plan_details(plan_id, week, day, exercise_id)VALUES ($planID, $w, $d, ${(legbuttSTs.toList()..shuffle()).first})");
                //For the rest day
                if (d == 6 || d == 7) {
                  await db.rawInsert(
                      "INSERT INTO plan_details(plan_id, week, day, is_restday)VALUES ($planID, $w, $d, 1)");
                }
                isDone = true;
              }
            }
          }
          //Shoulder/back workout lv1
          else if (bodypartId == 7 || bodypartId == 8) {
            for (var w = 1; w < 5; w++) {
              for (var d = 1; d < 8; d++) {
                //1 warm up
                await db.rawInsert(
                    "INSERT INTO plan_details(plan_id, week, day, exercise_id)VALUES ($planID, $w, $d, ${(armchestWU.toList()..shuffle()).first})");
                //2 lv1
                await db.rawInsert(
                    "INSERT INTO plan_details(plan_id, week, day, exercise_id)VALUES ($planID, $w, $d, ${(shoulderbackEXs1.toList()..shuffle()).first})");
                await db.rawInsert(
                    "INSERT INTO plan_details(plan_id, week, day, exercise_id)VALUES ($planID, $w, $d, ${(shoulderbackEXs1.toList()..shuffle()).first})");
                //2 lv2
                await db.rawInsert(
                    "INSERT INTO plan_details(plan_id, week, day, exercise_id)VALUES ($planID, $w, $d, ${(shoulderbackEXs2.toList()..shuffle()).first})");
                await db.rawInsert(
                    "INSERT INTO plan_details(plan_id, week, day, exercise_id)VALUES ($planID, $w, $d, ${(shoulderbackEXs2.toList()..shuffle()).first})");
                //2 lv1
                await db.rawInsert(
                    "INSERT INTO plan_details(plan_id, week, day, exercise_id)VALUES ($planID, $w, $d, ${(shoulderbackEXs1.toList()..shuffle()).first})");
                await db.rawInsert(
                    "INSERT INTO plan_details(plan_id, week, day, exercise_id)VALUES ($planID, $w, $d, ${(shoulderbackEXs1.toList()..shuffle()).first})");
                //1 stretch
                await db.rawInsert(
                    "INSERT INTO plan_details(plan_id, week, day, exercise_id)VALUES ($planID, $w, $d, ${(shoulderbackSTs.toList()..shuffle()).first})");
                //For the rest day
                if (d == 6 || d == 7) {
                  await db.rawInsert(
                      "INSERT INTO plan_details(plan_id, week, day, is_restday)VALUES ($planID, $w, $d, 1)");
                }
                isDone = true;
              }
            }
          }
          //Full body lv1
          else {
            for (var w = 1; w < 5; w++) {
              for (var d = 1; d < 8; d++) {
                //1 warm up
                await db.rawInsert(
                    "INSERT INTO plan_details(plan_id, week, day, exercise_id)VALUES ($planID, $w, $d, ${(legbuttWU.toList()..shuffle()).first})");
                //2 chest/arm lv1
                await db.rawInsert(
                    "INSERT INTO plan_details(plan_id, week, day, exercise_id)VALUES ($planID, $w, $d, ${(armchestEXs1.toList()..shuffle()).first})");
                await db.rawInsert(
                    "INSERT INTO plan_details(plan_id, week, day, exercise_id)VALUES ($planID, $w, $d, ${(armchestEXs1.toList()..shuffle()).first})");
                //2 abs lv1
                await db.rawInsert(
                    "INSERT INTO plan_details(plan_id, week, day, exercise_id)VALUES ($planID, $w, $d, ${(absEXs1.toList()..shuffle()).first})");
                await db.rawInsert(
                    "INSERT INTO plan_details(plan_id, week, day, exercise_id)VALUES ($planID, $w, $d, ${(absEXs1.toList()..shuffle()).first})");
                //2 back/shoulder lv1
                await db.rawInsert(
                    "INSERT INTO plan_details(plan_id, week, day, exercise_id)VALUES ($planID, $w, $d, ${(shoulderbackEXs1.toList()..shuffle()).first})");
                await db.rawInsert(
                    "INSERT INTO plan_details(plan_id, week, day, exercise_id)VALUES ($planID, $w, $d, ${(shoulderbackEXs1.toList()..shuffle()).first})");
                //2 leg/butt lv1
                await db.rawInsert(
                    "INSERT INTO plan_details(plan_id, week, day, exercise_id)VALUES ($planID, $w, $d, ${(legbuttEXs1.toList()..shuffle()).first})");
                await db.rawInsert(
                    "INSERT INTO plan_details(plan_id, week, day, exercise_id)VALUES ($planID, $w, $d, ${(legbuttEXs1.toList()..shuffle()).first})");
                //1 arm stretch
                await db.rawInsert(
                    "INSERT INTO plan_details(plan_id, week, day, exercise_id)VALUES ($planID, $w, $d, ${(upperSTs.toList()..shuffle()).first})");
                //1 lower stretch
                await db.rawInsert(
                    "INSERT INTO plan_details(plan_id, week, day, exercise_id)VALUES ($planID, $w, $d, ${(legbuttSTs.toList()..shuffle()).first})");
                //For the rest day
                if (d == 6 || d == 7) {
                  await db.rawInsert(
                      "INSERT INTO plan_details(plan_id, week, day, is_restday)VALUES ($planID, $w, $d, 1)");
                }
                isDone = true;
              }
            }
          }
        }
        //Keep fit lv1
        else {
          for (var w = 1; w < 5; w++) {
            for (var d = 1; d < 8; d++) {
              //1 warm up
              await db.rawInsert(
                  "INSERT INTO plan_details(plan_id, week, day, exercise_id)VALUES ($planID, $w, $d, ${(legbuttWU.toList()..shuffle()).first})");
              //2 chest/arm lv1
              await db.rawInsert(
                  "INSERT INTO plan_details(plan_id, week, day, exercise_id)VALUES ($planID, $w, $d, ${(armchestEXs1.toList()..shuffle()).first})");
              await db.rawInsert(
                  "INSERT INTO plan_details(plan_id, week, day, exercise_id)VALUES ($planID, $w, $d, ${(armchestEXs1.toList()..shuffle()).first})");
              //2 abs lv1
              await db.rawInsert(
                  "INSERT INTO plan_details(plan_id, week, day, exercise_id)VALUES ($planID, $w, $d, ${(absEXs1.toList()..shuffle()).first})");
              await db.rawInsert(
                  "INSERT INTO plan_details(plan_id, week, day, exercise_id)VALUES ($planID, $w, $d, ${(absEXs1.toList()..shuffle()).first})");
              //2 back/shoulder lv1
              await db.rawInsert(
                  "INSERT INTO plan_details(plan_id, week, day, exercise_id)VALUES ($planID, $w, $d, ${(shoulderbackEXs1.toList()..shuffle()).first})");
              await db.rawInsert(
                  "INSERT INTO plan_details(plan_id, week, day, exercise_id)VALUES ($planID, $w, $d, ${(shoulderbackEXs1.toList()..shuffle()).first})");
              //1 fullbody
              await db.rawInsert(
                  "INSERT INTO plan_details(plan_id, week, day, exercise_id)VALUES ($planID, $w, $d, ${(fullbodyEXs.toList()..shuffle()).first})");
              //2 leg/butt lv1
              await db.rawInsert(
                  "INSERT INTO plan_details(plan_id, week, day, exercise_id)VALUES ($planID, $w, $d, ${(legbuttEXs1.toList()..shuffle()).first})");
              await db.rawInsert(
                  "INSERT INTO plan_details(plan_id, week, day, exercise_id)VALUES ($planID, $w, $d, ${(legbuttEXs1.toList()..shuffle()).first})");
              //1 upper stretch
              await db.rawInsert(
                  "INSERT INTO plan_details(plan_id, week, day, exercise_id)VALUES ($planID, $w, $d, ${(upperSTs.toList()..shuffle()).first})");
              //1 lower stretch
              await db.rawInsert(
                  "INSERT INTO plan_details(plan_id, week, day, exercise_id)VALUES ($planID, $w, $d, ${(legbuttSTs.toList()..shuffle()).first})");
              //For the rest day
              if (d == 6 || d == 7) {
                await db.rawInsert(
                    "INSERT INTO plan_details(plan_id, week, day, is_restday)VALUES ($planID, $w, $d, 1)");
              }
              isDone = true;
            }
          }
        }
      }
      //Intermediate
      else if (userLevel == 2) {
        //Lose weight lv2
        if (goalIndex == 0) {
          for (var w = 1; w < 5; w++) {
            for (var d = 1; d < 8; d++) {
              //1 warm up
              await db.rawInsert(
                  "INSERT INTO plan_details(plan_id, week, day, exercise_id)VALUES ($planID, $w, $d, ${(legbuttWU.toList()..shuffle()).first})");
              //1 chest/arm lv1
              await db.rawInsert(
                  "INSERT INTO plan_details(plan_id, week, day, exercise_id)VALUES ($planID, $w, $d, ${(armchestEXs1.toList()..shuffle()).first})");
              //1 chest/arm lv2
              await db.rawInsert(
                  "INSERT INTO plan_details(plan_id, week, day, exercise_id)VALUES ($planID, $w, $d, ${(armchestEXs2.toList()..shuffle()).first})");
              //2 abs lv2
              await db.rawInsert(
                  "INSERT INTO plan_details(plan_id, week, day, exercise_id)VALUES ($planID, $w, $d, ${(absEXs2.toList()..shuffle()).first})");
              await db.rawInsert(
                  "INSERT INTO plan_details(plan_id, week, day, exercise_id)VALUES ($planID, $w, $d, ${(absEXs2.toList()..shuffle()).first})");
              //1 back/shoulder lv1
              await db.rawInsert(
                  "INSERT INTO plan_details(plan_id, week, day, exercise_id)VALUES ($planID, $w, $d, ${(shoulderbackEXs1.toList()..shuffle()).first})");
              //1 back/shoulder lv2
              await db.rawInsert(
                  "INSERT INTO plan_details(plan_id, week, day, exercise_id)VALUES ($planID, $w, $d, ${(shoulderbackEXs2.toList()..shuffle()).first})");
              //1 fullbody
              await db.rawInsert(
                  "INSERT INTO plan_details(plan_id, week, day, exercise_id)VALUES ($planID, $w, $d, ${(fullbodyEXs.toList()..shuffle()).first})");
              //1 leg/butt lv1
              await db.rawInsert(
                  "INSERT INTO plan_details(plan_id, week, day, exercise_id)VALUES ($planID, $w, $d, ${(legbuttEXs1.toList()..shuffle()).first})");
              //1 leg/butt lv2
              await db.rawInsert(
                  "INSERT INTO plan_details(plan_id, week, day, exercise_id)VALUES ($planID, $w, $d, ${(legbuttEXs2.toList()..shuffle()).first})");
              //1 upper stretch
              await db.rawInsert(
                  "INSERT INTO plan_details(plan_id, week, day, exercise_id)VALUES ($planID, $w, $d, ${(upperSTs.toList()..shuffle()).first})");
              //1 lower stretch
              await db.rawInsert(
                  "INSERT INTO plan_details(plan_id, week, day, exercise_id)VALUES ($planID, $w, $d, ${(legbuttSTs.toList()..shuffle()).first})");
              //For the rest day
              if (d == 7) {
                await db.rawInsert(
                    "INSERT INTO plan_details(plan_id, week, day, is_restday)VALUES ($planID, $w, 7, 1)");
              }
              isDone = true;
            }
          }
        }
        //Build muscle lv2
        else if (goalIndex == 1) {
          //Arm/chest workout lv2
          if (bodypartId == 1 || bodypartId == 2) {
            for (var w = 1; w < 5; w++) {
              for (var d = 1; d < 8; d++) {
                //1 warm up
                await db.rawInsert(
                    "INSERT INTO plan_details(plan_id, week, day, exercise_id)VALUES ($planID, $w, $d, ${(armchestWU.toList()..shuffle()).first})");
                //2 lv2
                await db.rawInsert(
                    "INSERT INTO plan_details(plan_id, week, day, exercise_id)VALUES ($planID, $w, $d, ${(armchestEXs2.toList()..shuffle()).first})");
                await db.rawInsert(
                    "INSERT INTO plan_details(plan_id, week, day, exercise_id)VALUES ($planID, $w, $d, ${(armchestEXs2.toList()..shuffle()).first})");
                //2 lv3
                await db.rawInsert(
                    "INSERT INTO plan_details(plan_id, week, day, exercise_id)VALUES ($planID, $w, $d, ${(armchestEXs3.toList()..shuffle()).first})");
                await db.rawInsert(
                    "INSERT INTO plan_details(plan_id, week, day, exercise_id)VALUES ($planID, $w, $d, ${(armchestEXs3.toList()..shuffle()).first})");
                //2 lv2
                await db.rawInsert(
                    "INSERT INTO plan_details(plan_id, week, day, exercise_id)VALUES ($planID, $w, $d, ${(armchestEXs2.toList()..shuffle()).first})");
                await db.rawInsert(
                    "INSERT INTO plan_details(plan_id, week, day, exercise_id)VALUES ($planID, $w, $d, ${(armchestEXs2.toList()..shuffle()).first})");
                //1 stretch
                await db.rawInsert(
                    "INSERT INTO plan_details(plan_id, week, day, exercise_id)VALUES ($planID, $w, $d, ${(armchestSTs.toList()..shuffle()).first})");
                //For the rest day
                if (d == 6 || d == 7) {
                  await db.rawInsert(
                      "INSERT INTO plan_details(plan_id, week, day, is_restday)VALUES ($planID, $w, $d, 1)");
                }
                isDone = true;
              }
            }
          }
          //Abs workout lv2
          else if (bodypartId == 3) {
            for (var w = 1; w < 5; w++) {
              for (var d = 1; d < 8; d++) {
                //1 warm up
                await db.rawInsert(
                    "INSERT INTO plan_details(plan_id, week, day, exercise_id)VALUES ($planID, $w, $d, $absWU)");
                //3 lv2
                await db.rawInsert(
                    "INSERT INTO plan_details(plan_id, week, day, exercise_id)VALUES ($planID, $w, $d, ${(absEXs2.toList()..shuffle()).first})");
                await db.rawInsert(
                    "INSERT INTO plan_details(plan_id, week, day, exercise_id)VALUES ($planID, $w, $d, ${(absEXs2.toList()..shuffle()).first})");
                await db.rawInsert(
                    "INSERT INTO plan_details(plan_id, week, day, exercise_id)VALUES ($planID, $w, $d, ${(absEXs2.toList()..shuffle()).first})");
                //2 lv3
                await db.rawInsert(
                    "INSERT INTO plan_details(plan_id, week, day, exercise_id)VALUES ($planID, $w, $d, $absEXs3)");
                await db.rawInsert(
                    "INSERT INTO plan_details(plan_id, week, day, exercise_id)VALUES ($planID, $w, $d, $absEXs3)");
                //3 lv2
                await db.rawInsert(
                    "INSERT INTO plan_details(plan_id, week, day, exercise_id)VALUES ($planID, $w, $d, ${(absEXs2.toList()..shuffle()).first})");
                await db.rawInsert(
                    "INSERT INTO plan_details(plan_id, week, day, exercise_id)VALUES ($planID, $w, $d, ${(absEXs2.toList()..shuffle()).first})");
                await db.rawInsert(
                    "INSERT INTO plan_details(plan_id, week, day, exercise_id)VALUES ($planID, $w, $d, ${(absEXs2.toList()..shuffle()).first})");
                //1 stretch
                await db.rawInsert(
                    "INSERT INTO plan_details(plan_id, week, day, exercise_id)VALUES ($planID, $w, $d, ${(absSTs.toList()..shuffle()).first})");
                //For the rest day
                if (d == 6 || d == 7) {
                  await db.rawInsert(
                      "INSERT INTO plan_details(plan_id, week, day, is_restday)VALUES ($planID, $w, $d, 1)");
                }
                isDone = true;
              }
            }
          }
          //Leg/butt workout lv2
          else if (bodypartId == 4 || bodypartId == 5) {
            for (var w = 1; w < 5; w++) {
              for (var d = 1; d < 8; d++) {
                //1 warm up
                await db.rawInsert(
                    "INSERT INTO plan_details(plan_id, week, day, exercise_id)VALUES ($planID, $w, $d, ${(legbuttWU.toList()..shuffle()).first})");
                //2 lv2
                await db.rawInsert(
                    "INSERT INTO plan_details(plan_id, week, day, exercise_id)VALUES ($planID, $w, $d, ${(legbuttEXs2.toList()..shuffle()).first})");
                await db.rawInsert(
                    "INSERT INTO plan_details(plan_id, week, day, exercise_id)VALUES ($planID, $w, $d, ${(legbuttEXs2.toList()..shuffle()).first})");
                //2 lv3
                await db.rawInsert(
                    "INSERT INTO plan_details(plan_id, week, day, exercise_id)VALUES ($planID, $w, $d, $legbuttEXs3)");
                await db.rawInsert(
                    "INSERT INTO plan_details(plan_id, week, day, exercise_id)VALUES ($planID, $w, $d, $legbuttEXs3)");
                //2 lv2
                await db.rawInsert(
                    "INSERT INTO plan_details(plan_id, week, day, exercise_id)VALUES ($planID, $w, $d, ${(legbuttEXs2.toList()..shuffle()).first})");
                await db.rawInsert(
                    "INSERT INTO plan_details(plan_id, week, day, exercise_id)VALUES ($planID, $w, $d, ${(legbuttEXs2.toList()..shuffle()).first})");
                //1 stretch
                await db.rawInsert(
                    "INSERT INTO plan_details(plan_id, week, day, exercise_id)VALUES ($planID, $w, $d, ${(legbuttSTs.toList()..shuffle()).first})");
                //For the rest day
                if (d == 6 || d == 7) {
                  await db.rawInsert(
                      "INSERT INTO plan_details(plan_id, week, day, is_restday)VALUES ($planID, $w, $d, 1)");
                }
                isDone = true;
              }
            }
          }
          //Shoulder/back workout lv2
          else if (bodypartId == 7 || bodypartId == 8) {
            for (var w = 1; w < 5; w++) {
              for (var d = 1; d < 8; d++) {
                //1 warm up
                await db.rawInsert(
                    "INSERT INTO plan_details(plan_id, week, day, exercise_id)VALUES ($planID, $w, $d, ${(armchestWU.toList()..shuffle()).first})");
                //2 lv2
                await db.rawInsert(
                    "INSERT INTO plan_details(plan_id, week, day, exercise_id)VALUES ($planID, $w, $d, ${(shoulderbackEXs2.toList()..shuffle()).first})");
                await db.rawInsert(
                    "INSERT INTO plan_details(plan_id, week, day, exercise_id)VALUES ($planID, $w, $d, ${(shoulderbackEXs2.toList()..shuffle()).first})");
                //2 lv3
                await db.rawInsert(
                    "INSERT INTO plan_details(plan_id, week, day, exercise_id)VALUES ($planID, $w, $d, ${(shoulderbackEXs3.toList()..shuffle()).first})");
                await db.rawInsert(
                    "INSERT INTO plan_details(plan_id, week, day, exercise_id)VALUES ($planID, $w, $d, ${(shoulderbackEXs3.toList()..shuffle()).first})");
                //2 lv2
                await db.rawInsert(
                    "INSERT INTO plan_details(plan_id, week, day, exercise_id)VALUES ($planID, $w, $d, ${(shoulderbackEXs2.toList()..shuffle()).first})");
                await db.rawInsert(
                    "INSERT INTO plan_details(plan_id, week, day, exercise_id)VALUES ($planID, $w, $d, ${(shoulderbackEXs2.toList()..shuffle()).first})");
                //1 stretch
                await db.rawInsert(
                    "INSERT INTO plan_details(plan_id, week, day, exercise_id)VALUES ($planID, $w, $d, ${(shoulderbackSTs.toList()..shuffle()).first})");
                //For the rest day
                if (d == 6 || d == 7) {
                  await db.rawInsert(
                      "INSERT INTO plan_details(plan_id, week, day, is_restday)VALUES ($planID, $w, $d, 1)");
                }
                isDone = true;
              }
            }
          }
          //Full body lv2
          else {
            for (var w = 1; w < 5; w++) {
              for (var d = 1; d < 8; d++) {
                //1 warm up
                await db.rawInsert(
                    "INSERT INTO plan_details(plan_id, week, day, exercise_id)VALUES ($planID, $w, $d, ${(legbuttWU.toList()..shuffle()).first})");
                //2 chest/arm lv2
                await db.rawInsert(
                    "INSERT INTO plan_details(plan_id, week, day, exercise_id)VALUES ($planID, $w, $d, ${(armchestEXs2.toList()..shuffle()).first})");
                await db.rawInsert(
                    "INSERT INTO plan_details(plan_id, week, day, exercise_id)VALUES ($planID, $w, $d, ${(armchestEXs2.toList()..shuffle()).first})");
                //2 abs lv2
                await db.rawInsert(
                    "INSERT INTO plan_details(plan_id, week, day, exercise_id)VALUES ($planID, $w, $d, ${(absEXs2.toList()..shuffle()).first})");
                await db.rawInsert(
                    "INSERT INTO plan_details(plan_id, week, day, exercise_id)VALUES ($planID, $w, $d, ${(absEXs2.toList()..shuffle()).first})");
                //2 back/shoulder lv2
                await db.rawInsert(
                    "INSERT INTO plan_details(plan_id, week, day, exercise_id)VALUES ($planID, $w, $d, ${(shoulderbackEXs2.toList()..shuffle()).first})");
                await db.rawInsert(
                    "INSERT INTO plan_details(plan_id, week, day, exercise_id)VALUES ($planID, $w, $d, ${(shoulderbackEXs2.toList()..shuffle()).first})");
                //2 leg/butt lv2
                await db.rawInsert(
                    "INSERT INTO plan_details(plan_id, week, day, exercise_id)VALUES ($planID, $w, $d, ${(legbuttEXs2.toList()..shuffle()).first})");
                await db.rawInsert(
                    "INSERT INTO plan_details(plan_id, week, day, exercise_id)VALUES ($planID, $w, $d, ${(legbuttEXs2.toList()..shuffle()).first})");
                //1 arm stretch
                await db.rawInsert(
                    "INSERT INTO plan_details(plan_id, week, day, exercise_id)VALUES ($planID, $w, $d, ${(upperSTs.toList()..shuffle()).first})");
                //1 lower stretch
                await db.rawInsert(
                    "INSERT INTO plan_details(plan_id, week, day, exercise_id)VALUES ($planID, $w, $d, ${(legbuttSTs.toList()..shuffle()).first})");
                //For the rest day
                if (d == 6 || d == 7) {
                  await db.rawInsert(
                      "INSERT INTO plan_details(plan_id, week, day, is_restday)VALUES ($planID, $w, $d, 1)");
                }
                isDone = true;
              }
            }
          }
        }
        //Keep fit lv2
        else {
          for (var w = 1; w < 5; w++) {
            for (var d = 1; d < 8; d++) {
              //1 warm up
              await db.rawInsert(
                  "INSERT INTO plan_details(plan_id, week, day, exercise_id)VALUES ($planID, $w, $d, ${(legbuttWU.toList()..shuffle()).first})");
              //2 chest/arm lv2
              await db.rawInsert(
                  "INSERT INTO plan_details(plan_id, week, day, exercise_id)VALUES ($planID, $w, $d, ${(armchestEXs2.toList()..shuffle()).first})");
              await db.rawInsert(
                  "INSERT INTO plan_details(plan_id, week, day, exercise_id)VALUES ($planID, $w, $d, ${(armchestEXs2.toList()..shuffle()).first})");
              //2 abs lv2
              await db.rawInsert(
                  "INSERT INTO plan_details(plan_id, week, day, exercise_id)VALUES ($planID, $w, $d, ${(absEXs2.toList()..shuffle()).first})");
              await db.rawInsert(
                  "INSERT INTO plan_details(plan_id, week, day, exercise_id)VALUES ($planID, $w, $d, ${(absEXs2.toList()..shuffle()).first})");
              //2 back/shoulder lv2
              await db.rawInsert(
                  "INSERT INTO plan_details(plan_id, week, day, exercise_id)VALUES ($planID, $w, $d, ${(shoulderbackEXs2.toList()..shuffle()).first})");
              await db.rawInsert(
                  "INSERT INTO plan_details(plan_id, week, day, exercise_id)VALUES ($planID, $w, $d, ${(shoulderbackEXs2.toList()..shuffle()).first})");
              //1 fullbody
              await db.rawInsert(
                  "INSERT INTO plan_details(plan_id, week, day, exercise_id)VALUES ($planID, $w, $d, ${(fullbodyEXs.toList()..shuffle()).first})");
              //2 leg/butt lv2
              await db.rawInsert(
                  "INSERT INTO plan_details(plan_id, week, day, exercise_id)VALUES ($planID, $w, $d, ${(legbuttEXs2.toList()..shuffle()).first})");
              await db.rawInsert(
                  "INSERT INTO plan_details(plan_id, week, day, exercise_id)VALUES ($planID, $w, $d, ${(legbuttEXs2.toList()..shuffle()).first})");
              //1 upper stretch
              await db.rawInsert(
                  "INSERT INTO plan_details(plan_id, week, day, exercise_id)VALUES ($planID, $w, $d, ${(upperSTs.toList()..shuffle()).first})");
              //1 lower stretch
              await db.rawInsert(
                  "INSERT INTO plan_details(plan_id, week, day, exercise_id)VALUES ($planID, $w, $d, ${(legbuttSTs.toList()..shuffle()).first})");
              //For the rest day
              if (d == 6 || d == 7) {
                await db.rawInsert(
                    "INSERT INTO plan_details(plan_id, week, day, is_restday)VALUES ($planID, $w, $d, 1)");
              }
              isDone = true;
            }
          }
        }
      }
      //Advanced
      else {
        //Lose weight lv3
        if (goalIndex == 0) {
          for (var w = 1; w < 5; w++) {
            for (var d = 1; d < 8; d++) {
              //1 warm up
              await db.rawInsert(
                  "INSERT INTO plan_details(plan_id, week, day, exercise_id)VALUES ($planID, $w, $d, ${(legbuttWU.toList()..shuffle()).first})");
              //1 chest/arm lv2
              await db.rawInsert(
                  "INSERT INTO plan_details(plan_id, week, day, exercise_id)VALUES ($planID, $w, $d, ${(armchestEXs2.toList()..shuffle()).first})");
              //1 chest/arm lv3
              await db.rawInsert(
                  "INSERT INTO plan_details(plan_id, week, day, exercise_id)VALUES ($planID, $w, $d, ${(armchestEXs3.toList()..shuffle()).first})");
              //2 abs lv3
              await db.rawInsert(
                  "INSERT INTO plan_details(plan_id, week, day, exercise_id)VALUES ($planID, $w, $d, $absEXs3)");
              await db.rawInsert(
                  "INSERT INTO plan_details(plan_id, week, day, exercise_id)VALUES ($planID, $w, $d, $absEXs3})");
              //1 back/shoulder lv2
              await db.rawInsert(
                  "INSERT INTO plan_details(plan_id, week, day, exercise_id)VALUES ($planID, $w, $d, ${(shoulderbackEXs2.toList()..shuffle()).first})");
              //1 back/shoulder lv3
              await db.rawInsert(
                  "INSERT INTO plan_details(plan_id, week, day, exercise_id)VALUES ($planID, $w, $d, ${(shoulderbackEXs3.toList()..shuffle()).first})");
              //1 fullbody
              await db.rawInsert(
                  "INSERT INTO plan_details(plan_id, week, day, exercise_id)VALUES ($planID, $w, $d, ${(fullbodyEXs.toList()..shuffle()).first})");
              //1 leg/butt lv2
              await db.rawInsert(
                  "INSERT INTO plan_details(plan_id, week, day, exercise_id)VALUES ($planID, $w, $d, ${(legbuttEXs2.toList()..shuffle()).first})");
              //1 leg/butt lv3
              await db.rawInsert(
                  "INSERT INTO plan_details(plan_id, week, day, exercise_id)VALUES ($planID, $w, $d, $legbuttEXs3)");
              //1 upper stretch
              await db.rawInsert(
                  "INSERT INTO plan_details(plan_id, week, day, exercise_id)VALUES ($planID, $w, $d, ${(upperSTs.toList()..shuffle()).first})");
              //1 lower stretch
              await db.rawInsert(
                  "INSERT INTO plan_details(plan_id, week, day, exercise_id)VALUES ($planID, $w, $d, ${(legbuttSTs.toList()..shuffle()).first})");
              //For the rest day
              if (d == 7) {
                await db.rawInsert(
                    "INSERT INTO plan_details(plan_id, week, day, is_restday)VALUES ($planID, $w, 7, 1)");
              }
              isDone = true;
            }
          }
        }
        //Build muscle lv3
        else if (goalIndex == 1) {
          //Arm/chest workout lv3
          if (bodypartId == 1 || bodypartId == 2) {
            for (var w = 1; w < 5; w++) {
              for (var d = 1; d < 8; d++) {
                //1 warm up
                await db.rawInsert(
                    "INSERT INTO plan_details(plan_id, week, day, exercise_id)VALUES ($planID, $w, $d, ${(armchestWU.toList()..shuffle()).first})");
                //1 lv2
                await db.rawInsert(
                    "INSERT INTO plan_details(plan_id, week, day, exercise_id)VALUES ($planID, $w, $d, ${(armchestEXs2.toList()..shuffle()).first})");
                //4 lv3
                await db.rawInsert(
                    "INSERT INTO plan_details(plan_id, week, day, exercise_id)VALUES ($planID, $w, $d, ${(armchestEXs3.toList()..shuffle()).first})");
                await db.rawInsert(
                    "INSERT INTO plan_details(plan_id, week, day, exercise_id)VALUES ($planID, $w, $d, ${(armchestEXs3.toList()..shuffle()).first})");
                await db.rawInsert(
                    "INSERT INTO plan_details(plan_id, week, day, exercise_id)VALUES ($planID, $w, $d, ${(armchestEXs3.toList()..shuffle()).first})");
                await db.rawInsert(
                    "INSERT INTO plan_details(plan_id, week, day, exercise_id)VALUES ($planID, $w, $d, ${(armchestEXs3.toList()..shuffle()).first})");
                //1 lv2
                await db.rawInsert(
                    "INSERT INTO plan_details(plan_id, week, day, exercise_id)VALUES ($planID, $w, $d, ${(armchestEXs2.toList()..shuffle()).first})");
                //1 stretch
                await db.rawInsert(
                    "INSERT INTO plan_details(plan_id, week, day, exercise_id)VALUES ($planID, $w, $d, ${(armchestSTs.toList()..shuffle()).first})");
                //For the rest day
                if (d == 6 || d == 7) {
                  await db.rawInsert(
                      "INSERT INTO plan_details(plan_id, week, day, is_restday)VALUES ($planID, $w, $d, 1)");
                }
                isDone = true;
              }
            }
          }
          //Abs workout lv3
          else if (bodypartId == 3) {
            for (var w = 1; w < 5; w++) {
              for (var d = 1; d < 8; d++) {
                //1 warm up
                await db.rawInsert(
                    "INSERT INTO plan_details(plan_id, week, day, exercise_id)VALUES ($planID, $w, $d, $absWU)");
                //1 lv2
                await db.rawInsert(
                    "INSERT INTO plan_details(plan_id, week, day, exercise_id)VALUES ($planID, $w, $d, ${(absEXs2.toList()..shuffle()).first})");
                //6 lv3
                await db.rawInsert(
                    "INSERT INTO plan_details(plan_id, week, day, exercise_id)VALUES ($planID, $w, $d, $absEXs3)");
                await db.rawInsert(
                    "INSERT INTO plan_details(plan_id, week, day, exercise_id)VALUES ($planID, $w, $d, $absEXs3)");
                await db.rawInsert(
                    "INSERT INTO plan_details(plan_id, week, day, exercise_id)VALUES ($planID, $w, $d, $absEXs3)");
                await db.rawInsert(
                    "INSERT INTO plan_details(plan_id, week, day, exercise_id)VALUES ($planID, $w, $d, $absEXs3)");
                await db.rawInsert(
                    "INSERT INTO plan_details(plan_id, week, day, exercise_id)VALUES ($planID, $w, $d, $absEXs3)");
                await db.rawInsert(
                    "INSERT INTO plan_details(plan_id, week, day, exercise_id)VALUES ($planID, $w, $d, $absEXs3)");
                //1 lv2
                await db.rawInsert(
                    "INSERT INTO plan_details(plan_id, week, day, exercise_id)VALUES ($planID, $w, $d, ${(absEXs2.toList()..shuffle()).first})");
                //1 stretch
                await db.rawInsert(
                    "INSERT INTO plan_details(plan_id, week, day, exercise_id)VALUES ($planID, $w, $d, ${(absSTs.toList()..shuffle()).first})");
                //For the rest day
                if (d == 6 || d == 7) {
                  await db.rawInsert(
                      "INSERT INTO plan_details(plan_id, week, day, is_restday)VALUES ($planID, $w, $d, 1)");
                }
                isDone = true;
              }
            }
          }
          //Leg/butt workout lv3
          else if (bodypartId == 4 || bodypartId == 5) {
            for (var w = 1; w < 5; w++) {
              for (var d = 1; d < 8; d++) {
                //1 warm up
                await db.rawInsert(
                    "INSERT INTO plan_details(plan_id, week, day, exercise_id)VALUES ($planID, $w, $d, ${(legbuttWU.toList()..shuffle()).first})");
                //1 lv2
                await db.rawInsert(
                    "INSERT INTO plan_details(plan_id, week, day, exercise_id)VALUES ($planID, $w, $d, ${(legbuttEXs2.toList()..shuffle()).first})");
                //4 lv3
                await db.rawInsert(
                    "INSERT INTO plan_details(plan_id, week, day, exercise_id)VALUES ($planID, $w, $d, $legbuttEXs3)");
                await db.rawInsert(
                    "INSERT INTO plan_details(plan_id, week, day, exercise_id)VALUES ($planID, $w, $d, $legbuttEXs3)");
                await db.rawInsert(
                    "INSERT INTO plan_details(plan_id, week, day, exercise_id)VALUES ($planID, $w, $d, $legbuttEXs3)");
                await db.rawInsert(
                    "INSERT INTO plan_details(plan_id, week, day, exercise_id)VALUES ($planID, $w, $d, $legbuttEXs3)");
                //1 lv2
                await db.rawInsert(
                    "INSERT INTO plan_details(plan_id, week, day, exercise_id)VALUES ($planID, $w, $d, ${(legbuttEXs2.toList()..shuffle()).first})");
                //1 stretch
                await db.rawInsert(
                    "INSERT INTO plan_details(plan_id, week, day, exercise_id)VALUES ($planID, $w, $d, ${(legbuttSTs.toList()..shuffle()).first})");
                //For the rest day
                if (d == 6 || d == 7) {
                  await db.rawInsert(
                      "INSERT INTO plan_details(plan_id, week, day, is_restday)VALUES ($planID, $w, $d, 1)");
                }
                isDone = true;
              }
            }
          }
          //Shoulder/back workout lv3
          else if (bodypartId == 7 || bodypartId == 8) {
            for (var w = 1; w < 5; w++) {
              for (var d = 1; d < 8; d++) {
                //1 warm up
                await db.rawInsert(
                    "INSERT INTO plan_details(plan_id, week, day, exercise_id)VALUES ($planID, $w, $d, ${(armchestWU.toList()..shuffle()).first})");
                //1 lv2
                await db.rawInsert(
                    "INSERT INTO plan_details(plan_id, week, day, exercise_id)VALUES ($planID, $w, $d, ${(shoulderbackEXs2.toList()..shuffle()).first})");
                //4 lv3
                await db.rawInsert(
                    "INSERT INTO plan_details(plan_id, week, day, exercise_id)VALUES ($planID, $w, $d, ${(shoulderbackEXs3.toList()..shuffle()).first})");
                await db.rawInsert(
                    "INSERT INTO plan_details(plan_id, week, day, exercise_id)VALUES ($planID, $w, $d, ${(shoulderbackEXs3.toList()..shuffle()).first})");
                await db.rawInsert(
                    "INSERT INTO plan_details(plan_id, week, day, exercise_id)VALUES ($planID, $w, $d, ${(shoulderbackEXs3.toList()..shuffle()).first})");
                await db.rawInsert(
                    "INSERT INTO plan_details(plan_id, week, day, exercise_id)VALUES ($planID, $w, $d, ${(shoulderbackEXs3.toList()..shuffle()).first})");
                //1 lv2
                await db.rawInsert(
                    "INSERT INTO plan_details(plan_id, week, day, exercise_id)VALUES ($planID, $w, $d, ${(shoulderbackEXs2.toList()..shuffle()).first})");
                //1 stretch
                await db.rawInsert(
                    "INSERT INTO plan_details(plan_id, week, day, exercise_id)VALUES ($planID, $w, $d, ${(shoulderbackSTs.toList()..shuffle()).first})");
                //For the rest day
                if (d == 6 || d == 7) {
                  await db.rawInsert(
                      "INSERT INTO plan_details(plan_id, week, day, is_restday)VALUES ($planID, $w, $d, 1)");
                }
                isDone = true;
              }
            }
          }
          //Full body lv3
          else {
            for (var w = 1; w < 5; w++) {
              for (var d = 1; d < 8; d++) {
                //1 warm up
                await db.rawInsert(
                    "INSERT INTO plan_details(plan_id, week, day, exercise_id)VALUES ($planID, $w, $d, ${(legbuttWU.toList()..shuffle()).first})");
                //2 chest/arm lv3
                await db.rawInsert(
                    "INSERT INTO plan_details(plan_id, week, day, exercise_id)VALUES ($planID, $w, $d, ${(armchestEXs3.toList()..shuffle()).first})");
                await db.rawInsert(
                    "INSERT INTO plan_details(plan_id, week, day, exercise_id)VALUES ($planID, $w, $d, ${(armchestEXs3.toList()..shuffle()).first})");
                //2 abs lv3
                await db.rawInsert(
                    "INSERT INTO plan_details(plan_id, week, day, exercise_id)VALUES ($planID, $w, $d, $absEXs3)");
                await db.rawInsert(
                    "INSERT INTO plan_details(plan_id, week, day, exercise_id)VALUES ($planID, $w, $d, $absEXs3)");
                //2 back/shoulder lv3
                await db.rawInsert(
                    "INSERT INTO plan_details(plan_id, week, day, exercise_id)VALUES ($planID, $w, $d, ${(shoulderbackEXs3.toList()..shuffle()).first})");
                await db.rawInsert(
                    "INSERT INTO plan_details(plan_id, week, day, exercise_id)VALUES ($planID, $w, $d, ${(shoulderbackEXs3.toList()..shuffle()).first})");
                //2 leg/butt lv3
                await db.rawInsert(
                    "INSERT INTO plan_details(plan_id, week, day, exercise_id)VALUES ($planID, $w, $d, $legbuttEXs3)");
                await db.rawInsert(
                    "INSERT INTO plan_details(plan_id, week, day, exercise_id)VALUES ($planID, $w, $d, $legbuttEXs3)");
                //1 arm stretch
                await db.rawInsert(
                    "INSERT INTO plan_details(plan_id, week, day, exercise_id)VALUES ($planID, $w, $d, ${(upperSTs.toList()..shuffle()).first})");
                //1 lower stretch
                await db.rawInsert(
                    "INSERT INTO plan_details(plan_id, week, day, exercise_id)VALUES ($planID, $w, $d, ${(legbuttSTs.toList()..shuffle()).first})");
                //For the rest day
                if (d == 6 || d == 7) {
                  await db.rawInsert(
                      "INSERT INTO plan_details(plan_id, week, day, is_restday)VALUES ($planID, $w, $d, 1)");
                }
                isDone = true;
              }
            }
          }
        }
        //Keep fit lv3
        else {
          for (var w = 1; w < 5; w++) {
            for (var d = 1; d < 8; d++) {
              //1 warm up
              await db.rawInsert(
                  "INSERT INTO plan_details(plan_id, week, day, exercise_id)VALUES ($planID, $w, $d, ${(legbuttWU.toList()..shuffle()).first})");
              //2 chest/arm lv3
              await db.rawInsert(
                  "INSERT INTO plan_details(plan_id, week, day, exercise_id)VALUES ($planID, $w, $d, ${(armchestEXs3.toList()..shuffle()).first})");
              await db.rawInsert(
                  "INSERT INTO plan_details(plan_id, week, day, exercise_id)VALUES ($planID, $w, $d, ${(armchestEXs3.toList()..shuffle()).first})");
              //2 abs lv3
              await db.rawInsert(
                  "INSERT INTO plan_details(plan_id, week, day, exercise_id)VALUES ($planID, $w, $d, $absEXs3)");
              await db.rawInsert(
                  "INSERT INTO plan_details(plan_id, week, day, exercise_id)VALUES ($planID, $w, $d, $absEXs3)");
              //2 back/shoulder lv3
              await db.rawInsert(
                  "INSERT INTO plan_details(plan_id, week, day, exercise_id)VALUES ($planID, $w, $d, ${(shoulderbackEXs3.toList()..shuffle()).first})");
              await db.rawInsert(
                  "INSERT INTO plan_details(plan_id, week, day, exercise_id)VALUES ($planID, $w, $d, ${(shoulderbackEXs3.toList()..shuffle()).first})");
              //1 fullbody
              await db.rawInsert(
                  "INSERT INTO plan_details(plan_id, week, day, exercise_id)VALUES ($planID, $w, $d, ${(fullbodyEXs.toList()..shuffle()).first})");
              //2 leg/butt lv3
              await db.rawInsert(
                  "INSERT INTO plan_details(plan_id, week, day, exercise_id)VALUES ($planID, $w, $d, $legbuttEXs3)");
              await db.rawInsert(
                  "INSERT INTO plan_details(plan_id, week, day, exercise_id)VALUES ($planID, $w, $d, $legbuttEXs3)");
              //1 upper stretch
              await db.rawInsert(
                  "INSERT INTO plan_details(plan_id, week, day, exercise_id)VALUES ($planID, $w, $d, ${(upperSTs.toList()..shuffle()).first})");
              //1 lower stretch
              await db.rawInsert(
                  "INSERT INTO plan_details(plan_id, week, day, exercise_id)VALUES ($planID, $w, $d, ${(legbuttSTs.toList()..shuffle()).first})");
              //For the rest day
              if (d == 6 || d == 7) {
                await db.rawInsert(
                    "INSERT INTO plan_details(plan_id, week, day, is_restday)VALUES ($planID, $w, $d, 1)");
              }
              isDone = true;
            }
          }
        }
      }
    } else {
      print("Something wrong with query or variables. Check them!");
      isDone = false;
    }
    return isDone;
  }
}
