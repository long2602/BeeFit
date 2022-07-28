class Instruction {
  late int? id;
  late int idExercise, step;
  late String detail;

  Instruction(
      {this.id,
      required this.idExercise,
      required this.detail,
      required this.step});

  factory Instruction.fromJson(Map<String, dynamic> json) {
    return Instruction(
        id: json['id'],
        idExercise: json['exercise_id'],
        detail: json['detail'],
        step: json['step']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'exercise_id': idExercise,
      'step': step,
      'detail': detail
    };
  }
}
