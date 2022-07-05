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
    name = object['Name'];
    gender = object['Gender'];
    age = object['Age'];
    height = double.parse(object['Height'].toString());
    weight = double.parse(object['Weight'].toString());
    bodyStatus = object['BodyStatus'];
    idTarget = object['IdTarget'];
  }
}