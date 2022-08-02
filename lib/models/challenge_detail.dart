class ChallengeDetail {
  late int? idExercise, idChallenge;
  late int? status, level, met, type, rest, isRep, duration, rep;
  late String? date;
  late double? kcal;
  late String? name, des, gif;

  ChallengeDetail(
      {this.idExercise,
      this.idChallenge,
      this.status,
      this.level,
      this.met,
      this.type,
      this.rest,
      this.isRep,
      this.duration,
      this.rep,
      this.date,
      this.kcal,
      this.name,
      this.des,
      this.gif});

  factory ChallengeDetail.fromJson(Map<String, dynamic> json) {
    return ChallengeDetail(
      rep: json['rep'],
      duration: json['duration'],
      level: json['level'],
      name: json['name'],
      status: json['status'],
      date: json['date'],
      kcal: json['kcal'],
      idExercise: json['exercise_id'],
      des: json['description'],
      gif: json['gif'],
      idChallenge: json['id'],
      isRep: json['isRepCount'],
      met: json['met'],
      rest: json['rest_duration'],
      type: json['type'],
    );
  }
}
