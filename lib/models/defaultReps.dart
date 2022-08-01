class DefaultReps {
  late int? id, userLevel, idBodyPart, rep, duration;
  DefaultReps({
    this.id,
    this.idBodyPart,
    this.userLevel,
    this.duration,
    this.rep,
  });

  factory DefaultReps.fromJson(Map<String, dynamic> json) {
    return DefaultReps(
        id: json['id'],
        duration: json['duration'],
        rep: json['rep'],
        userLevel: json['user_level'],
        idBodyPart: json['bodypart_id']);
  }
}
