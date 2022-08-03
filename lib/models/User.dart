import 'dart:ffi';

class User {
  String? name;
  bool? gender;
  int? age;
  int? height;
  int? weight;
  int? goal;
  int? level;
  double? bmi;
  double? bmr;
  int? muscleId;
  int? mainPlan;

  User(
      {this.name,
      this.gender,
      this.age,
      this.height,
      this.weight,
      this.goal,
      this.level,
      this.bmr,
      this.bmi,
      this.muscleId,
      this.mainPlan});
}
