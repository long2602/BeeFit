class Exercise {
  late int? id, level, type, met, restDuration;
  late String name, description, gif;

  Exercise(
      {this.id,
      required this.name,
      required this.description,
      required this.gif,
      required this.level,
      required this.type,
      required this.met,
      required this.restDuration});

  factory Exercise.fromJson(Map<String, dynamic> json) {
    return Exercise(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        gif: json["gif"],
        level: json["level"],
        type: json["type"],
        met: json["met"],
        restDuration: json["rest_duration"]);
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "description": description,
      "gif": gif,
      "level": level,
      "type": type,
      "met": met,
      "rest_duration": restDuration
    };
  }
}
