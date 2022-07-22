class Message {
  final String topic;
  final Map<String, dynamic> payload;
  Message({required this.payload, required this.topic});
  getTopicMessage(String value) {
    if (value == topic) {
      return payload;
    } else {
      return null;
    }
  }
}
