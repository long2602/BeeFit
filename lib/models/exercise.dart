class Exercise{
  int? idEx;
  String? nameEx;
  String? desEx;
  String? videoEx;
  String? gifEx;
  String? imgEx;
  int? duration;
  int? level;
  double? calories;

  Exercise(this.idEx, this.nameEx, this.desEx, this.videoEx, this.gifEx,
      this.imgEx, this.duration, this.level, this.calories);

  Exercise.map(dynamic object){
    idEx =object['IdEx'];
    nameEx = object['nameEx'];
    desEx = object['dexEx'];
    videoEx =object['videoEx'];
    gifEx = object['gifEx'];
    desEx = object['dexEx'];
    idEx =object['IdEx'];
    nameEx = object['nameEx'];
    desEx = object['dexEx'];
  }
}