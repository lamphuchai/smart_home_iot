class MessageSwitch {
  final bool switch1;
  final bool switch2;
  final bool switch3;
  MessageSwitch(
      {required this.switch1, required this.switch2, required this.switch3});
  factory MessageSwitch.fromJson(Map<String, dynamic> json) {
    return MessageSwitch(
        switch1: json["switch1"],
        switch2: json["switch2"],
        switch3: json["switch3"]);
  }
  Map<String, dynamic> toJson() =>
      {"switch1": switch1, "switch2": switch2, "switch3": switch3};

  MessageSwitch copyWith({bool? switch1, bool? switch2, bool? switch3}) =>
      MessageSwitch(
          switch1: switch1 ?? this.switch1,
          switch2: switch2 ?? this.switch2,
          switch3: switch3 ?? this.switch3);

  MessageSwitch onAll() =>
      MessageSwitch(switch1: true, switch2: true, switch3: true);

  MessageSwitch onOFF() =>
      MessageSwitch(switch1: false, switch2: false, switch3: false);
}
