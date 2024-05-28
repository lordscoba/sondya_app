import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sondya_app/data/api_constants.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

final chatWebSocketProvider = StreamProvider<List<dynamic>>((ref) async* {
  final wsUrl = Uri.parse(EnvironmentWebSocketConfig.personal);
  final socket = WebSocketChannel.connect(wsUrl);

  await socket.ready;

  ref.onDispose(socket.sink.close);

  final defaultMessage = jsonEncode({
    "meta": "echo_payload",
    "sender_id": "6571cf8a009ed796a706aa1f",
    "receiver_id": "658eafc1f86136f97618ccd2",
    "payload": "whats up1"
  });

  socket.sink.add(defaultMessage);

  ref.onDispose(socket.sink.close);

  var allMessages = const <dynamic>[];

  await for (final message in socket.stream) {
    // A new message has been received. Let's add it to the list of all messages.
    allMessages = [...allMessages, message];
    yield allMessages;
  }
});

// sample
void mainshajjajjajsxtx() {
  final channel = WebSocketChannel.connect(
    Uri.parse('ws://localhost:8080'),
  );

  // Example of sending a Test_echo_terms message
  final testEchoTermsMessage = jsonEncode({
    "meta": "Test_echo_terms",
    "receiver_id": "user456",
    "payload": "Test echo terms message."
  });
  channel.sink.add(testEchoTermsMessage);

  // Example of sending an echo_terms message
  final echoTermsMessage = jsonEncode({
    "meta": "echo_terms",
    "receiver_id": "user456",
    "payload": "Echo terms message."
  });
  channel.sink.add(echoTermsMessage);

  // Example of sending an echo_payload message
  final echoPayloadMessage = jsonEncode({
    "meta": "echo_payload",
    "receiver_id": "user456",
    "payload": "Echo payload message."
  });
  channel.sink.add(echoPayloadMessage);

  // Example of sending a user_online_check message
  final userOnlineCheckMessage =
      jsonEncode({"meta": "user_online_check", "sender_id": "user123"});
  channel.sink.add(userOnlineCheckMessage);

  // Example of sending a new_room_check message
  final newRoomCheckMessage = jsonEncode(
      {"meta": "new_room_check", "sender_id": "user123", "room_id": "room789"});
  channel.sink.add(newRoomCheckMessage);

  // Example of sending a join_conversation message
  final joinConversationMessage = jsonEncode({
    "meta": "join_conversation",
    "sender_id": "user123",
    "room_id": "room789"
  });
  channel.sink.add(joinConversationMessage);

  // Example of sending a join_review_terms_room message
  final joinReviewTermsRoomMessage = jsonEncode({
    "meta": "join_review_terms_room",
    "sender_id": "user123",
    "room_id": "room789"
  });
  channel.sink.add(joinReviewTermsRoomMessage);

  // Example of sending a join_conversations message
  final joinConversationsMessage = jsonEncode({
    "meta": "join_conversations",
    "sender_id": "user123",
    "rooms": ["room789", "room1011"]
  });
  channel.sink.add(joinConversationsMessage);

  // Example of sending a testing_connection message
  final testingConnectionMessage = jsonEncode({
    "meta": "testing_connection",
    "receiver_id": "user456",
    "payload": "Testing connection message."
  });
  channel.sink.add(testingConnectionMessage);

  // Example of sending a default case message
  final defaultMessage = jsonEncode({
    "meta": "some_other_meta",
    "sender_id": "user123",
    "room_id": "room789"
  });
  channel.sink.add(defaultMessage);

  // Listen for responses from the WebSocket server
  channel.stream.listen((message) {
    print('Received: $message');
  });
}
