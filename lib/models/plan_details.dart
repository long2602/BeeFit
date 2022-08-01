class PlanDetail {
  late int? id, idExercise;
  late int idPlan, week, day, status, isRestDay;
  late String? date;
  late double? kcal;

  PlanDetail({
    this.id,
    required this.idPlan,
    required this.idExercise,
    required this.week,
    required this.day,
    this.kcal,
    required this.status,
    this.date,
    required this.isRestDay,
  });

  factory PlanDetail.fromJson(Map<String, dynamic> jsonMap) {
    return PlanDetail(
      id: jsonMap['id'],
      idPlan: jsonMap['plan_id'],
      week: jsonMap['week'],
      day: jsonMap['day'],
      idExercise: jsonMap['exercise_id'],
      kcal: jsonMap['kcal'],
      date: jsonMap['date'],
      status: jsonMap['status'],
      isRestDay: jsonMap['is_restday'],
    );
  }
}
