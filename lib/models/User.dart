import 'dart:ffi';

class User{
  String? name;
  int? gender;
  int? age;
  double? height;
  double? weight;
  int? bodyStatus;
  int? idTarget;

  User(this.name, this.gender, this.age, this.height, this.weight,
      this.bodyStatus, this.idTarget);

  User.map(dynamic object){
    this.name = object['Name'];
    this.gender = object['Gender'];
    this.age = object['Age'];
    this.height = double.parse(object['Height'].toString());
    this.weight = double.parse(object['Weight'].toString());
    this.bodyStatus = object['BodyStatus'];
    this.idTarget = object['IdTarget'];
  }
}