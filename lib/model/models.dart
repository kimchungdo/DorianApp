class SmokeTime {
  final int id;
  final String stringTime;

  SmokeTime({required this.id, required this.stringTime});

  Map<String, dynamic> toMap(){
    return{
      'id' : id,
      'stringTime' : stringTime,
    };
  }
}