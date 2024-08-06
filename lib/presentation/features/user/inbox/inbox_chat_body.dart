import 'dart:convert';

import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:sondya_app/data/api_constants.dart';
import 'package:sondya_app/data/extra_constants.dart';
import 'package:sondya_app/data/remote/chat.dart';
import 'package:sondya_app/domain/models/chat.dart';
import 'package:sondya_app/domain/providers/chat.provider.dart';
import 'package:sondya_app/utils/dateTime_to_string.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class InboxChatBody extends ConsumerStatefulWidget {
  final String userId;
  final String receiverId;
  final Map<String, dynamic> data;
  const InboxChatBody(
      {super.key,
      required this.userId,
      required this.receiverId,
      required this.data});

  @override
  ConsumerState<InboxChatBody> createState() => _InboxChatBodyState();
}

class _InboxChatBodyState extends ConsumerState<InboxChatBody> {
  late Map<String, dynamic>? chatSender;
  late Map<String, dynamic>? chatReceiver;
  late PostMessageType chatMessage;
  late String _chatId;

  // for websocket connection
  late WebSocketChannel _channel;
  final List<dynamic> _messageHistory = [];
  final String _socketUrl = EnvironmentWebSocketConfig.personal;
  final int _reconnectAttempts = 5;
  final Duration _reconnectInterval = const Duration(seconds: 3);
  int _reconnectCount = 0;
  bool _userStatus = false;
  // websocket ends here

  // Initialize TextEditingController
  final TextEditingController _messageController = TextEditingController();

  // for the chat data
  List<dynamic> chatData = [];
  bool _isInitialFetchDone = false; // Flag to track if initial fetch is done

  @override
  void initState() {
    super.initState();

    // Initialize the variable in initState

    // initialize chat sender variable
    chatSender = widget.data["sender_data"] != null &&
            widget.data["sender_data"].isNotEmpty
        ? widget.data["sender_data"]
        : null;

    // initialize chat receiver variable
    chatReceiver = widget.data["receiver_data"] != null &&
            widget.data["receiver_data"].isNotEmpty
        ? widget.data["receiver_data"]
        : null;

    // initialize chatMessage for sending message
    chatMessage = PostMessageType();

    // Perform initial data fetch
    _fetchInitialData().then((data) {
      // Access data if needed from _fetchInitialData

      // assign chat_id to chatId1
      _chatId = data[0]["chat_id"];

      // Connect to WebSocket
      _connectWebSocket();

      // Initialize join room
      _joinChatInitialize();
    });
  }

  @override
  Widget build(BuildContext context) {
    // this helps to get get messages state
    final getChats = ref.watch(
      getMessagesProvider(
        (receiverId: widget.receiverId, senderId: widget.userId),
      ),
    );

    // this helps to get get message state
    final AsyncValue<Map<String, dynamic>> checkState =
        ref.watch(postMessagesProvider);
    return SingleChildScrollView(
      child: Center(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              context.canPop()
                  ? Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.arrow_back),
                        ),
                      ],
                    )
                  : const SizedBox(),
              const SizedBox(height: 10.0),
              const Text(
                "Inbox",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10.0),
              Container(
                height: MediaQuery.of(context).size.height * 0.6,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                        ),
                        borderRadius: const BorderRadiusDirectional.only(
                          topStart: Radius.circular(10),
                          topEnd: Radius.circular(10),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: NetworkImage(chatReceiver != null &&
                                        chatReceiver!["image"] != null &&
                                        chatReceiver!["image"].length > 0
                                    ? chatReceiver!["image"][0]["url"]
                                    : networkImagePlaceholder),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10.0),
                          Column(
                            children: [
                              Text(chatReceiver != null &&
                                      chatReceiver!["username"] != null &&
                                      chatReceiver!["username"].isNotEmpty
                                  ? chatReceiver!["username"] ?? "Unknown"
                                  : "Unknown"),
                              _userStatus
                                  ? const Row(
                                      children: [
                                        Icon(Icons.circle,
                                            color: Colors.green, size: 10),
                                        SizedBox(width: 5.0),
                                        Text("Active now"),
                                      ],
                                    )
                                  : const Row(
                                      children: [
                                        Icon(Icons.circle,
                                            color: Colors.red, size: 10),
                                        SizedBox(width: 5.0),
                                        Text("Offline"),
                                      ],
                                    ),
                            ],
                          ),
                          const Spacer(),
                          const Icon(Icons.delete),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5.0),
                        child: Column(
                          children: [
                            if (chatData.isEmpty)
                              const Center(
                                child:
                                    Text("This is a new chat. No messages yet"),
                              ),
                            if (getChats.isLoading)
                              const Center(
                                child: CupertinoActivityIndicator(
                                  radius: 50,
                                ),
                              ),
                            if (chatData.isNotEmpty)
                              ConstrainedBox(
                                constraints: BoxConstraints(
                                    minHeight: 60,
                                    maxHeight:
                                        MediaQuery.of(context).size.height *
                                            0.44),
                                child: ListView.separated(
                                  reverse: true,
                                  shrinkWrap: true,
                                  itemCount: chatData.length,
                                  itemBuilder: (context, index) {
                                    if (chatData[index]["sender_id"]["_id"] ==
                                        widget.userId) {
                                      return ChatSnippet2(
                                        text: chatData[index]["message"],
                                        time: sondyaFormattedDate(
                                            chatData[index]["createdAt"]),
                                      );
                                    }
                                    return ChatSnippet(
                                      text: chatData[index]["message"],
                                      image: chatReceiver != null &&
                                              chatReceiver!["image"] != null &&
                                              chatReceiver!["image"].length > 0
                                          ? chatReceiver!["image"][0]["url"]
                                          : networkImagePlaceholder,
                                      time: sondyaFormattedDate(
                                          chatData[index]["createdAt"]),
                                    );
                                  },
                                  separatorBuilder: (context, index) {
                                    return const SizedBox(
                                      height: 10,
                                    );
                                  },
                                ),
                              )
                          ],
                        ),
                      ),
                    ),
                    TextField(
                      controller: _messageController,
                      decoration: InputDecoration(
                        hintText: "Type your message...",
                        suffixIcon: chatMessage.messageText != null &&
                                chatMessage.messageText != ""
                            ? IconButton(
                                onPressed: () {
                                  if (chatMessage.messageText != null &&
                                      chatMessage.messageText != "") {
                                    _sendMessage(chatMessage.messageText!);
                                    // print(chatMessage.toJson());
                                    ref
                                        .read(postMessagesProvider.notifier)
                                        .postMessages(chatMessage.toJson());

                                    // Clear the TextField
                                    _messageController.clear();
                                    chatMessage.messageText = "";
                                  }
                                },
                                icon: checkState.isLoading
                                    ? const CupertinoActivityIndicator(
                                        radius: 10,
                                      )
                                    : const Icon(Icons.send),
                              )
                            : IconButton(
                                onPressed: () {
                                  AnimatedSnackBar.rectangle(
                                    'Error',
                                    "Attachment coming soon",
                                    type: AnimatedSnackBarType.warning,
                                    brightness: Brightness.light,
                                  ).show(
                                    context,
                                  );
                                },
                                icon: const Icon(Icons.attach_file_outlined),
                              ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          chatMessage.messageText = value;
                          chatMessage.senderId = widget.userId;
                          chatMessage.receiverId = widget.receiverId;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _connectWebSocket() {
    _channel = WebSocketChannel.connect(Uri.parse(_socketUrl));

    _channel.stream.listen(
      (message) {
        final newMessage = jsonDecode(message);
        if (newMessage["meta"] != null &&
            newMessage["meta"] == "user_status" &&
            newMessage["user_id"] == widget.receiverId) {
          setState(() {
            if (newMessage["status"] == "offline") {
              _userStatus = false;
            } else if (newMessage["status"] == "online") {
              _userStatus = true;
            }
          });
        }

        if (_chatId.isNotEmpty &&
            newMessage["chat_id"] != null &&
            newMessage["chat_id"] == _chatId) {
          setState(() {
            _messageHistory.add(newMessage);
            chatData = [newMessage, ...chatData];
            print(chatData.length);
          });
        }
      },
      onDone: () {
        if (_reconnectCount < _reconnectAttempts) {
          _reconnectCount++;
          Future.delayed(_reconnectInterval, _connectWebSocket);
        }
      },
      onError: (error) {
        if (_reconnectCount < _reconnectAttempts) {
          _reconnectCount++;
          Future.delayed(_reconnectInterval, _connectWebSocket);
        }
      },
    );
  }

  void _sendMessage(String text) {
    if (chatMessage.messageText != null && chatMessage.messageText != "") {
      DateTime now = DateTime.now().toUtc();
      String isoDate = DateFormat("yyyy-MM-ddTHH:mm:ss.SSS'Z'").format(now);
      final defaultMessage = jsonEncode({
        "meta": "echo_payload",
        "sender_id": widget.userId,
        "receiver_id": widget.receiverId,
        "payload": {
          "chat_id": _chatId,
          "sender_id": {
            "_id": widget.userId,
            "first_name":
                chatSender != null && chatSender!["first_name"].isNotEmpty
                    ? chatSender!["first_name"]
                    : chatData[0]["sender_id"]["first_name"] ?? "nil",
            "last_name":
                chatSender != null && chatSender!["last_name"].isNotEmpty
                    ? chatSender!["last_name"]
                    : chatData[0]["sender_id"]["last_name"] ?? "nil",
            "username": chatSender != null && chatSender!["username"].isNotEmpty
                ? chatSender!["username"]
                : chatData[0]["sender_id"]["username"] ?? "nil",
            "email": chatSender != null && chatSender!["email"].isNotEmpty
                ? chatSender!["email"]
                : chatData[0]["sender_id"]["email"] ?? "nil",
          },
          "message": text,
          "createdAt": isoDate,
          "updatedAt": isoDate
        }
      });
      _channel.sink.add(defaultMessage);
    }
  }

  void _joinChatInitialize() {
    if (_chatId.isNotEmpty && widget.userId != "") {
      final defaultMessage = jsonEncode({
        "meta": "join_conversation",
        "room_id": _chatId,
        "sender_id": widget.userId,
      });
      _channel.sink.add(defaultMessage);
    }
  }

  Future<List<dynamic>> _fetchInitialData() async {
    try {
      final getChats = ref.read(getMessagesProvider(
        (receiverId: widget.receiverId, senderId: widget.userId),
      ).future);

      return await getChats.then((data3) {
        setState(() {
          if (!_isInitialFetchDone) {
            _chatId = data3[0]["chat_id"];
            chatData = data3.reversed.toList();

            _isInitialFetchDone = true; // Set the flag to true
          }
        });

        return data3;
      });
    } catch (error) {
      print(error);
      // Handle the error case by returning an empty list or rethrowing the error.
      // return [];

      // Or, if you want to rethrow the error:
      rethrow;
    }
  }

  @override
  void dispose() {
    _channel.sink.close();
    _messageController.dispose();
    super.dispose();
  }
}

class ChatSnippet extends StatelessWidget {
  final String? text;
  final String? time;
  final String? image;
  const ChatSnippet({super.key, required this.text, this.time, this.image});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 35,
          height: 35,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                image ?? networkImagePlaceholder,
              ),
              fit: BoxFit.cover,
            ),
            color: Colors.grey,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 3.0),
        Container(
          padding: const EdgeInsets.all(10.0),
          width: 300,
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              SizedBox(
                width: 260,
                child: Text(
                  text ?? "Unknown",
                  style: const TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
              const SizedBox(height: 5.0),
              Align(
                alignment: Alignment.bottomRight,
                child: SizedBox(
                  width: 120,
                  child: Text(
                    time ?? "unknown",
                    style: const TextStyle(fontSize: 10, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ChatSnippet2 extends StatelessWidget {
  final String? text;
  final String? time;
  const ChatSnippet2({super.key, required this.text, this.time});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      width: 350,
      decoration: BoxDecoration(
        color: const Color(0xFFEDB842),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: SizedBox(
              width: 260,
              child: Text(
                text ?? "Unknown",
                style: const TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ),
          const SizedBox(height: 5.0),
          Align(
            alignment: Alignment.bottomRight,
            child: SizedBox(
              width: 120,
              child: Text(
                time ?? "unknown",
                style: const TextStyle(fontSize: 10, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
