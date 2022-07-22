class Condition {
  String? value;
  dynamic condiRun;

  Condition({this.value, this.condiRun});
  factory Condition.fromJson(Map<String,dynamic> json)=>Condition(value: json["value"],condiRun:json["condiRun"]);
  Map<String, dynamic> toJson() => {"value": value, "condiRun": condiRun};
}
