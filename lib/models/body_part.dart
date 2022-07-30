class BodyPart {
  late int? id;
  late String name, image;

  BodyPart({this.id, required this.name, required this.image});

  factory BodyPart.fromJson(Map<String, dynamic> json) {
    return BodyPart(id: json["id"], name: json["name"], image: json["image"]);
  }

  Map<String, dynamic> toJson() {
    return {"id": id, "name": name, "image": image};
  }
}
