import 'package:beefit/models/nutrition/Ingredient.dart';
import 'dart:convert';

class FoodHistory {
  late int? id, meal, idPlanDetail;
  late String date, time;
  late Ingredient ingredient;

  FoodHistory({
    this.id,
    this.meal,
    required this.time,
    required this.date,
    required this.ingredient,
    this.idPlanDetail,
  });

  factory FoodHistory.fromJson(Map<String, dynamic> jsonMap) {
    String map = jsonMap['ingredient'];
    Ingredient _ingredient = Ingredient.fromMap(json.decode(map));
    return FoodHistory(
      time: jsonMap['ftime'],
      date: jsonMap['fday'],
      ingredient: _ingredient,
      id: jsonMap['idfood'],
      idPlanDetail: jsonMap['id_planDetail'],
      meal: jsonMap['meal'],
    );
  }
}
