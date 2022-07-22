class MessageSensor {
  final int temperature;
  final int humidity;
  MessageSensor({required this.temperature, required this.humidity});
  factory MessageSensor.fromJson(Map<String, dynamic> json) => MessageSensor(
      temperature: json["temperature"], humidity: json["humidity"]);
  MessageSensor copyWith({int? temperature, int? humidity}) => MessageSensor(
      temperature: temperature ?? this.temperature,
      humidity: humidity ?? this.humidity);
}
