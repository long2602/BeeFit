class PlanExerciseDetail {
  late int? id, level, type, met, restDuration, rep, duration;
  late String name, description, gif;
  late double kcal;

  PlanExerciseDetail(
      {this.id,
      this.level,
      this.type,
      this.met,
      this.restDuration,
      this.rep,
      this.duration,
      required this.name,
      required this.description,
      required this.gif,
      required this.kcal});

  factory PlanExerciseDetail.fromJson(Map<String, dynamic> json) {
    return PlanExerciseDetail(
      id: json["id"],
      name: json["name"],
      description: json["description"],
      gif: json["gif"],
      level: json["level"],
      type: json["type"],
      met: json["met"],
      restDuration: json["rest_duration"],
      kcal: json['kcal'],
      rep: json['rep'],
      duration: json['duration'],
    );
  }
}
