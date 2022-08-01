import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Plan {
  late int? id;
  late int idBodyPart, level;
  late String name, des, img;

  Plan(
      {this.id,
      required this.idBodyPart,
      required this.name,
      required this.des,
      required this.img,
      required this.level});

  factory Plan.fromJson(Map<String, dynamic> jsonMap) {
    return Plan(
      id: jsonMap['id'],
      name: jsonMap['name'],
      idBodyPart: jsonMap['bodypart_id'],
      des: jsonMap['description'],
      img: jsonMap['image'],
      level: jsonMap['user_level'],
    );
  }
}
