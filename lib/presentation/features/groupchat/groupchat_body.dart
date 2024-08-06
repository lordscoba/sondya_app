import 'dart:convert';

import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:sondya_app/data/api_constants.dart';
import 'package:sondya_app/data/extra_constants.dart';
import 'package:sondya_app/data/remote/groupchat.dart';
import 'package:sondya_app/data/remote/profile.dart';
import 'package:sondya_app/domain/providers/groupchat.dart';
import 'package:sondya_app/utils/dateTime_to_string.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class GroupChatBody extends ConsumerStatefulWidget {
  final String groupId;
  final String userId;
  const GroupChatBody({super.key, required this.groupId, required this.userId});

  @override
  ConsumerState<GroupChatBody> createState() => _GroupChatBodyState();
}

class _GroupChatBodyState extends ConsumerState<GroupChatBody> {
  Map<String, dynamic> messageData = {
    "message": "",
    "group_id": "",
    "sender_id": "",
  };

  Map<String, dynamic> profileData = {};

  // for websocket connection
  late WebSocketChannel _channel;
  final List<dynamic> _messageHistory = [];
  final String _socketUrl = EnvironmentWebSocketConfig.groupchat;
  final int _reconnectAttempts = 5;
  final Duration _reconnectInterval = const Duration(seconds: 3);
  int _reconnectCount = 0;
  // websocket ends here

  // for the chat data
  List<dynamic> chatData = [];
  bool _isInitialFetchDone = false; // Flag to track if initial fetch is done

  @override
  void initState() {
    super.initState();

    // Initialize the variable in initState
    messageData["group_id"] = widget.groupId;

    _fetchUserProfile().then((data) {
      profileData = data;
    });

    // Perform initial data fetch
    _fetchInitialData().then((data) {
      // Connect to WebSocket
      _connectWebSocket();

      // Join the chat
      _joinChatInitialize();

      // Update the state with the fetched data
      setState(() {
        if (!_isInitialFetchDone) {
          chatData = data;
          _isInitialFetchDone = true; // Set the flag to true
        }
      });
    });
  }

  // Initialize TextEditingController
  final TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // get the details
    final getGroupChatMessages =
        ref.watch(getGroupchatMessagesProvider(widget.groupId));

    final AsyncValue<Map<String, dynamic>> checkStateMessages =
        ref.watch(sendMessageGroupChatProvider);

    // final AsyncValue<Map<String, dynamic>> checkStateToggeleLike =
    //     ref.watch(toggleLikeButtonGroupChatProvider);

    return SingleChildScrollView(
      child: Center(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10.0),
          height: MediaQuery.of(context).size.height * 0.8,
          child: Column(
            children: [
              context.canPop()
                  ? Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          onPressed: () {
                            // ignore: unused_result
                            ref.refresh(memberJoinGroupChatProvider);
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.arrow_back),
                        ),
                        const Text(
                          "Group Chat",
                          style: TextStyle(
                            fontSize: 24.0,
                          ),
                        ),
                      ],
                    )
                  : const SizedBox(),
              const SizedBox(height: 10.0),
              GestureDetector(
                onTap: () {
                  // ignore: unused_result
                  ref.refresh(memberJoinGroupChatProvider);
                  context.push("/group/chat/details/${widget.groupId}",
                      extra: profileData);
                },
                behavior: HitTestBehavior.translucent,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GroupChatTopRow(
                      id: widget.groupId,
                    ),
                    const Icon(
                      Icons.chevron_right_rounded,
                      size: 50.0,
                      color: Colors.grey,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10.0),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.6,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (chatData.isEmpty)
                      const Center(
                        child: Text("This is a new chat. No messages yet"),
                      ),
                    if (getGroupChatMessages.isLoading)
                      const Center(
                        child: CupertinoActivityIndicator(
                          radius: 50,
                        ),
                      ),
                    if (chatData.isNotEmpty)
                      Expanded(
                        child: ListView.separated(
                          reverse: true,
                          shrinkWrap: true,
                          itemCount: chatData.length,
                          itemBuilder: (context, index) {
                            if (chatData[index]["isMe"]) {
                              return GroupChatSnippet2(
                                text: chatData[index]["message"],
                                time: sondyaFormattedDate(
                                    chatData[index]["createdAt"]),
                              );
                            }
                            return GestureDetector(
                              onDoubleTap: () {
                                _goToUserChat(
                                    widget.userId,
                                    chatData[index]["sender_id"],
                                    chatData[index]["sender"]);
                              },
                              onLongPress: () {
                                _goToUserChat(
                                    widget.userId,
                                    chatData[index]["sender_id"],
                                    chatData[index]["sender"]);
                              },
                              behavior: HitTestBehavior.translucent,
                              child: GroupChatSnippet(
                                text: chatData[index]["message"],
                                senderName:
                                    "${chatData[index]["sender"]["first_name"] ?? ""} ${chatData[index]["sender"]["last_name"] ?? ""}",
                                image: chatData[index]["image"] != null &&
                                        chatData[index]["image"].isNotEmpty
                                    ? chatData[index]["image"][0]["url"]
                                    : networkImagePlaceholder,
                                time: sondyaFormattedDate(
                                    chatData[index]["createdAt"]),
                              ),
                            );
                          },
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 10.0),
                        ),
                      ),
                    const SizedBox(height: 2.0),
                    TextField(
                      controller: _messageController,
                      decoration: InputDecoration(
                        hintText: "Type your message...",
                        suffixIcon: IconButton(
                          onPressed: () async {
                            if (messageData["message"].isNotEmpty) {
                              _sendMessage(messageData["message"]);
                              ref.invalidate(sendMessageGroupChatProvider);

                              await ref
                                  .read(sendMessageGroupChatProvider.notifier)
                                  .sendMessage(
                                    messageData,
                                  );

                              // Clear the TextField
                              _messageController.clear();
                              messageData["message"] = "";
                            } else {
                              AnimatedSnackBar.rectangle(
                                'Error',
                                "Please enter a message",
                                type: AnimatedSnackBarType.warning,
                                brightness: Brightness.light,
                              ).show(
                                context,
                              );
                            }
                          },
                          icon: checkStateMessages.isLoading
                              ? const CupertinoActivityIndicator(
                                  radius: 10,
                                )
                              : const Icon(Icons.send),
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          messageData["message"] = value;
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

  void _goToUserChat(String? senderId, String? receiverId,
      Map<String, dynamic>? receiverData) {
    context.push('/inbox/chat/${receiverId ?? "nil"}/${senderId ?? "nil"}',
        extra: {"sender_data": profileData, "receiver_data": receiverData});
  }

  void _connectWebSocket() {
    _channel = WebSocketChannel.connect(Uri.parse(_socketUrl));

    _channel.stream.listen(
      (message) {
        final newMessage = jsonDecode(message);

        if (messageData["group_id"].isNotEmpty &&
            newMessage["chat_id"] != null &&
            newMessage["chat_id"] == messageData["group_id"]) {
          final String senderid = newMessage["sender_id"]["_id"];
          final Map<String, dynamic> sender = newMessage["sender_id"];
          setState(() {
            newMessage["isMe"] = senderid == widget.userId;
            newMessage["sender"] = sender;
            newMessage["sender_id"] = senderid;
            newMessage["group_id"] = newMessage["chat_id"];

            // remove chat_id key from newMessage
            newMessage.remove("chat_id");

            _messageHistory.add(newMessage);
            chatData = [newMessage, ...chatData];
            // print(chatData.length);
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
    if (messageData["message"] != null && messageData["message"].isNotEmpty) {
      DateTime now = DateTime.now().toUtc();
      String isoDate = DateFormat("yyyy-MM-ddTHH:mm:ss.SSS'Z'").format(now);
      final defaultMessage = jsonEncode({
        "meta": "echo_payload",
        "user_id": widget.userId,
        "room_id": widget.groupId,
        "message": text,
        "payload": {
          "chat_id": widget.groupId,
          "sender_id": {
            "_id": widget.userId,
            "first_name": profileData["first_name"].isNotEmpty
                ? profileData["first_name"]
                : "nil",
            "last_name": profileData["last_name"].isNotEmpty
                ? profileData["last_name"]
                : "nil",
            "username": profileData["username"].isNotEmpty
                ? profileData["username"]
                : "nil",
            "email":
                profileData["email"].isNotEmpty ? profileData["email"] : "nil",
            "image": profileData["image"]
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
    if (widget.groupId.isNotEmpty && widget.userId != "") {
      final defaultMessage = jsonEncode({
        "meta": "join_conversation",
        "room_id": widget.groupId,
        "sender_id": widget.userId,
        "message": "",
      });
      _channel.sink.add(defaultMessage);
    }
  }

  Future<List<dynamic>> _fetchInitialData() async {
    try {
      final getGroupChatMessages =
          ref.read(getGroupchatMessagesProvider(widget.groupId).future);

      return await getGroupChatMessages.then((groupData) {
        return groupData;
      });
    } catch (error) {
      // print(error);
      // Or, if you want to rethrow the error:
      rethrow;
    }
  }

  Future<Map<String, dynamic>> _fetchUserProfile() async {
    try {
      final getProfileData = ref.read(getProfileByIdProvider.future);

      return await getProfileData.then((profileData) {
        Map<String, dynamic> filteredProfileData = {
          'first_name': profileData['first_name'],
          'last_name': profileData['last_name'],
          'username': profileData['username'],
          'email': profileData['email'],
          'image': profileData['image'],
          "_id": profileData['_id'],
        };
        return filteredProfileData;
      });
    } catch (error) {
      // print(error);
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

class GroupChatSnippet extends StatelessWidget {
  final String? senderName;
  final String? text;
  final String? time;
  final String? image;
  const GroupChatSnippet(
      {super.key, this.senderName, required this.text, this.time, this.image});

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
                image!,
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
                  senderName ?? "Unknown",
                  style: const TextStyle(fontSize: 12, color: Colors.white54),
                ),
              ),
              const SizedBox(height: 5.0),
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
                    style: const TextStyle(fontSize: 10, color: Colors.white54),
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

class GroupChatSnippet2 extends StatelessWidget {
  final String? text;
  final String? time;
  const GroupChatSnippet2({super.key, required this.text, this.time});

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

class GroupChatTopRow extends ConsumerWidget {
  final String id;
  const GroupChatTopRow({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final getGroupchatMembers =
        ref.watch(getGroupchatMembersProvider((groupId: id, search: "")));

    return getGroupchatMembers.when(
      data: (data) {
        return SizedBox(
          height: 60,
          width: MediaQuery.of(context).size.width * 0.8,
          child: Stack(
            clipBehavior: Clip.none,
            children: <Widget>[
              ...data.take(5).toList().map<Widget>(
                (e) {
                  return Positioned(
                    left: (data.indexOf(e) * 20).toDouble(),
                    child: CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(
                        e["image"] != null && e["image"].isNotEmpty
                            ? e["image"][0]["url"]
                            : networkImagePlaceholder,
                      ),
                    ),
                  );
                },
              ),
              Positioned(
                bottom: 20,
                left: data.length * 20,
                child: Text(
                  data.length > 5 ? "+${data.length - 5}" : "",
                  style: const TextStyle(
                      fontSize: 18.0,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        );
      },
      error: (error, stackTrace) => Text(error.toString()),
      loading: () => const CupertinoActivityIndicator(
        radius: 20,
      ),
    );
  }
}
