class PlanDetail {
  late int? id;
  late int idPlan, week, day, idExercise, rep, duration, status;
  late String? date;
  late double kcal;

  PlanDetail({
    this.id,
    required this.idPlan,
    required this.idExercise,
    required this.week,
    required this.day,
    required this.rep,
    required this.duration,
    required this.kcal,
    required this.status,
    this.date,
  });

  factory PlanDetail.fromJson(Map<String, dynamic> jsonMap) {
    return PlanDetail(
      id: jsonMap['id'],
      idPlan: jsonMap['plan_id'],
      week: jsonMap['week'],
      day: jsonMap['day'],
      idExercise: jsonMap['exercise_id'],
      rep: jsonMap['rep'],
      duration: jsonMap['duration'],
      kcal: jsonMap['kcal'],
      date: jsonMap['date'],
      status: jsonMap['status'],
    );
  }
}
