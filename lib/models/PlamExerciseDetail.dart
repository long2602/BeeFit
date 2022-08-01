class PlanExerciseDetail {
  late int? id, level, type, met, restDuration, rep, duration, isRepCount;
  late String name, description, gif;
  late double? kcal;

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
      this.kcal,
      required this.isRepCount});

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
        kcal: json['kcal'] ?? 0,
        rep: json['rep'],
        duration: json['duration'],
        isRepCount: json['isRepCount']);
  }
}
