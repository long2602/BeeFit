class Challenge {
  late int? id;
  late int bodyPartId;
  late String name, description, image;

  Challenge(
      {this.id,
      required this.name,
      required this.bodyPartId,
      required this.description,
      required this.image});

  factory Challenge.fromJson(Map<String, dynamic> json) {
    return Challenge(
        id: json["id"],
        name: json["name"],
        bodyPartId: json["bodypart_id"],
        description: json["description"],
        image: json["image"]);
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "bodypart_id": bodyPartId,
      "description": description,
      "image": image
    };
  }
}
