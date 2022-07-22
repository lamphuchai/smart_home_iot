
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:smart_home_iot/provider/list_room_provider.dart';
import 'package:uuid/uuid.dart';

class MqttServices {
  final MqttServerClient _client = MqttServerClient('10.0.2.2', "");
  late ListRoomProvider? listRoomProvider;
  MqttServices({this.listRoomProvider}) {
    initializedMqtt();
  }
  Future initializedMqtt() async {
    String clientId = const Uuid().v4();
    _client.logging(on: false);
    // _client.useWebSocket = true;
    _client.port = 1883;
    _client.keepAlivePeriod = 20;
    _client.onConnected = onConnected;
    _client.onDisconnected = onDisconnected;
    _client.onUnsubscribed = onUnsubscribed;
    _client.onSubscribed = onSubscribed;
    _client.onSubscribeFail = onSubscribeFail;
    _client.pongCallback = pong;
    final connMessage = MqttConnectMessage()
        .authenticateAs('admin', 'admin')
        .withClientIdentifier(clientId)
        .startClean()
        .withWillQos(MqttQos.atLeastOnce);

    _client.connectionMessage = connMessage;
    return await connectionMqtt();
  }

  Future<bool> connectionMqtt() async {
    try {
      await _client.connect();
      listRoomProvider!.subscribeTopicList();
      return true;
    } catch (e) {
      _client.disconnect();
      print(e.toString());
      return false;
    }
  }

  bool connectedMQTT() {
    if (_client.connectionStatus!.state == MqttConnectionState.connected) {
      return true;
    } else {
      return false;
    }
  }

  void onConnected() {
    print('Connected');
    listenServer();
  }

  void listenServer() async {
    try {
      _client.updates!.listen((List<MqttReceivedMessage<MqttMessage?>>? c) {
        final recMess = c![0].payload as MqttPublishMessage;
        final payload =
            MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
        listRoomProvider!.setMessage({"topic": c[0].topic, "payload": payload});
      });
    } catch (e) {
      print(e.toString());
    }
  }

  void publish({String? message, String? topic}) {
    if (connectedMQTT()) {
      final MqttClientPayloadBuilder builder = MqttClientPayloadBuilder();
      builder.addString(message.toString());
      _client.publishMessage(topic!, MqttQos.exactlyOnce, builder.payload!);
    } else {
      _client.connect();
    }
  }

  void subscribe({String? topic}) {
    if (connectedMQTT()) {
      _client.subscribe(topic!, MqttQos.exactlyOnce);
    } else {
      _client.connect();
    }
  }

  void disconnectMQTT() {
    _client.disconnect();
  }

  void onDisconnected() {
    print('Disconnected');
  }

  void onSubscribed(String topic) {
    print('Subscribed topic: $topic');
  }

  void onSubscribeFail(String topic) {
    print('Failed to subscribe $topic');
  }

  void onUnsubscribed(String? topic) {
    print('Unsubscribed topic: $topic');
  }

  void pong() {
    print('Ping response client callback invoked');
  }
}
