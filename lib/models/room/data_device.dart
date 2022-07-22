class DataDevice {
  final Map<String, dynamic>? dataNow;
  final String idData;
  DataDevice({required this.dataNow, required this.idData});
  factory DataDevice.fromJson(Map<String, dynamic> json) {
    return DataDevice(
        dataNow: json["dataNow"] , idData: json["idData"] ?? "");
  }
  Map<String, dynamic> toJson() {
    return {"dataNow": dataNow, "idData": idData};
  }

  DataDevice copyWith({Map<String, dynamic>? dataNow, String? idData}) {
    return DataDevice(
        dataNow: dataNow ?? this.dataNow, idData: idData ?? this.idData);
  }
}
