import 'dart:convert';
import 'dart:io';

import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:mime/mime.dart';
import 'package:sondya_app/data/api_constants.dart';
import 'package:sondya_app/data/extra_constants.dart';
import 'package:sondya_app/data/legal_mimetypes.dart';
import 'package:sondya_app/data/remote/groupchat.dart';
import 'package:sondya_app/data/remote/profile.dart';
import 'package:sondya_app/domain/models/groupchat.dart';
import 'package:sondya_app/domain/providers/groupchat.dart';
import 'package:sondya_app/presentation/features/groupchat/groupchat_snippet.dart';
import 'package:sondya_app/presentation/widgets/image_selection.dart';
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
  // for groupchat messages
  late GroupChatPostMessageType messageData;

  // for user profile
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

  // Initialize TextEditingController
  final TextEditingController _messageController = TextEditingController();

  @override
  void initState() {
    super.initState();

    messageData = GroupChatPostMessageType();

    // Initialize the variable in initState
    messageData.groupId = widget.groupId;
    messageData.message = '';

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
                              if (chatData[index]["type"] == "image") {
                                return GroupChatImageSnippet2(
                                  isFromWeb:
                                      chatData[index]["isFromWeb"] ?? false,
                                  text: chatData[index]["message"],
                                  time: sondyaFormattedDate(
                                      chatData[index]["createdAt"]),
                                  imageChat: chatData[index]["image"],
                                );
                              }
                              if (chatData[index]["type"] == "file") {
                                // return const SizedBox();
                                return GroupChatFileSnippet2(
                                  isFromWeb:
                                      chatData[index]["isFromWeb"] ?? false,
                                  text: chatData[index]["message"],
                                  time: sondyaFormattedDate(
                                      chatData[index]["createdAt"]),
                                  fileChat: chatData[index]["file"],
                                  fileSize: chatData[index]["file_size"],
                                  fileName: chatData[index]["file_name"],
                                  fileExtension: chatData[index]
                                      ["file_extension"],
                                );
                              }
                              return GroupChatSnippet2(
                                text: chatData[index]["message"],
                                time: sondyaFormattedDate(
                                    chatData[index]["createdAt"]),
                              );
                            }
                            if (chatData[index]["type"] == "image") {
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
                                child: GroupChatImageSnippet(
                                  isFromWeb:
                                      chatData[index]["isFromWeb"] ?? false,
                                  text: chatData[index]["message"],
                                  senderName:
                                      "${chatData[index]["sender"]["first_name"] ?? ""} ${chatData[index]["sender"]["last_name"] ?? ""}",
                                  time: sondyaFormattedDate(
                                      chatData[index]["createdAt"]),
                                  image: chatData[index]["image"] != null &&
                                          chatData[index]["image"].isNotEmpty
                                      ? chatData[index]["image"][0]["url"]
                                      : networkImagePlaceholder,
                                  imageChat: chatData[index]["image"],
                                ),
                              );
                            }
                            if (chatData[index]["type"] == "file") {
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
                                child: GroupChatFileSnippet(
                                  isFromWeb:
                                      chatData[index]["isFromWeb"] ?? false,
                                  text: chatData[index]["message"],
                                  senderName:
                                      "${chatData[index]["sender"]["first_name"] ?? ""} ${chatData[index]["sender"]["last_name"] ?? ""}",
                                  time: sondyaFormattedDate(
                                      chatData[index]["createdAt"]),
                                  image: chatData[index]["image"] != null &&
                                          chatData[index]["image"].isNotEmpty
                                      ? chatData[index]["image"][0]["url"]
                                      : networkImagePlaceholder,
                                  fileChat: chatData[index]["file"],
                                  fileSize: chatData[index]["file_size"],
                                  fileName: chatData[index]["file_name"],
                                  fileExtension: chatData[index]
                                      ["file_extension"],
                                ),
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
                        suffixIcon: messageData.message!.isNotEmpty
                            ? IconButton(
                                onPressed: () async {
                                  if (messageData.message!.isNotEmpty) {
                                    // Send the message through the web socket
                                    _sendMessage(messageData.message!);

                                    // refresh the send message provider
                                    ref.invalidate(
                                        sendMessageGroupChatProvider);

                                    // assign data to message type
                                    messageData.type = "text";

                                    // send message through the api
                                    await ref
                                        .read(sendMessageGroupChatProvider
                                            .notifier)
                                        .sendMessage(
                                          messageData,
                                          "text",
                                        );

                                    // Clear the TextField
                                    _messageController.clear();
                                    messageData.message = "";
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
                              )
                            : IconButton(
                                onPressed: () {
                                  showGeneralDialog(
                                    context: context,
                                    transitionDuration: const Duration(
                                        milliseconds:
                                            100), // Adjust animation duration
                                    transitionBuilder:
                                        (context, a1, a2, widget) {
                                      return FadeTransition(
                                        opacity: CurvedAnimation(
                                            parent: a1, curve: Curves.easeIn),
                                        child: widget,
                                      );
                                    },
                                    barrierLabel: MaterialLocalizations.of(
                                            context)
                                        .modalBarrierDismissLabel, // Optional accessibility label
                                    pageBuilder:
                                        (context, animation1, animation2) {
                                      return SondyaFileAttachmentWidget(
                                        onSetFile: (value) async {
                                          if (value.count > 0 &&
                                              value.files.isNotEmpty) {
                                            // Check if the file size is greater than 3MB
                                            if (_checkFileSizeIsGreaterThan3MB(
                                                value)) {
                                              // ignore: use_build_context_synchronously
                                              AnimatedSnackBar.rectangle(
                                                'Error',
                                                "File size is greater than 3MB(file size should be less than 3MB)",
                                                type: AnimatedSnackBarType
                                                    .warning,
                                                brightness: Brightness.light,
                                              ).show(
                                                context,
                                              );
                                              return;
                                            }

                                            // Send the file through the web socket
                                            _sendFile(value);

                                            // refresh the send message provider
                                            ref.invalidate(
                                                sendMessageGroupChatProvider);

                                            // assign data to message type and message
                                            messageData.file = value;
                                            messageData.message = "file";
                                            messageData.type = "file";

                                            // send message through the api
                                            await ref
                                                .read(
                                                    sendMessageGroupChatProvider
                                                        .notifier)
                                                .sendMessage(
                                                  messageData,
                                                  "file",
                                                );

                                            // Clear the TextField
                                            _messageController.clear();
                                            messageData.message = "";
                                          } else {
                                            AnimatedSnackBar.rectangle(
                                              'Error',
                                              "Please enter a message",
                                              type:
                                                  AnimatedSnackBarType.warning,
                                              brightness: Brightness.light,
                                            ).show(
                                              context,
                                            );
                                          }
                                        },
                                        onSetImage: (value) async {
                                          if (value.path.isNotEmpty) {
                                            // Check if the file size is greater than 3MB
                                            if (await _checkImageSizeIsGreaterThan3MB(
                                                value)) {
                                              // ignore: use_build_context_synchronously
                                              AnimatedSnackBar.rectangle(
                                                'Error',
                                                "File size is greater than 3MB(file size should be less than 3MB)",
                                                type: AnimatedSnackBarType
                                                    .warning,
                                                brightness: Brightness.light,
                                              ).show(
                                                context,
                                              );
                                              return;
                                            }

                                            // Send the image through the web socket
                                            setState(() {
                                              _sendImage(value);
                                            });

                                            // refresh the send message provider
                                            ref.invalidate(
                                                sendMessageGroupChatProvider);

                                            // assign data to message type and message
                                            messageData.image = value;
                                            messageData.message = "image";
                                            messageData.type = "image";

                                            // send message through the api
                                            await ref
                                                .read(
                                                    sendMessageGroupChatProvider
                                                        .notifier)
                                                .sendMessage(
                                                  messageData,
                                                  "image",
                                                );

                                            // Clear the TextField
                                            _messageController.clear();
                                            messageData.message = "";
                                          } else {
                                            AnimatedSnackBar.rectangle(
                                              'Error',
                                              "Please enter a message",
                                              type:
                                                  AnimatedSnackBarType.warning,
                                              brightness: Brightness.light,
                                            ).show(
                                              context,
                                            );
                                          }
                                        },
                                      );
                                    },
                                  );
                                },
                                icon: const Icon(Icons.attach_file_outlined),
                              ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          messageData.message = value;
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

// function to go to user private chat
  void _goToUserChat(String? senderId, String? receiverId,
      Map<String, dynamic>? receiverData) {
    context.push('/inbox/chat/${receiverId ?? "nil"}/${senderId ?? "nil"}',
        extra: {"sender_data": profileData, "receiver_data": receiverData});
  }

// function to connect to the web socket and receive messages
  void _connectWebSocket() {
    _channel = WebSocketChannel.connect(Uri.parse(_socketUrl));

    _channel.stream.listen(
      (message) {
        final newMessage = jsonDecode(message);

        if (messageData.groupId!.isNotEmpty &&
            newMessage["chat_id"] != null &&
            newMessage["chat_id"] == messageData.groupId &&
            newMessage["type"] == "text") {
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

        if (messageData.groupId!.isNotEmpty &&
            newMessage["chat_id"] != null &&
            newMessage["chat_id"] == messageData.groupId &&
            newMessage["type"] == "image") {
          // print(newMessage);
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

        if (messageData.groupId!.isNotEmpty &&
            newMessage["chat_id"] != null &&
            newMessage["chat_id"] == messageData.groupId &&
            newMessage["type"] == "file") {
          // print(newMessage);
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

// function to send message through websocket
  void _sendMessage(String text) {
    if (messageData.message != null && messageData.message!.isNotEmpty) {
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
          "type": "text",
          "message": text,
          "createdAt": isoDate,
          "updatedAt": isoDate
        }
      });
      _channel.sink.add(defaultMessage);
    }
  }

// function to send image through websocket
  Future<void> _sendImage(XFile image) async {
    if (image.path.isNotEmpty) {
      DateTime now = DateTime.now().toUtc();
      String isoDate = DateFormat("yyyy-MM-ddTHH:mm:ss.SSS'Z'").format(now);

      // check mime type of image
      final mimeTypeData = lookupMimeType(image.path)!.split("/");
      if (mimeTypeData[0] != 'image') {
        // ignore: use_build_context_synchronously
        AnimatedSnackBar.rectangle(
          'File type not supported',
          "Error: File type not supported",
          type: AnimatedSnackBarType.warning,
          brightness: Brightness.light,
        ).show(
          context,
        );
        return;
      }

      // Read the image as bytes
      Uint8List imageBytes = await image.readAsBytes();

      // Encode the image to base64
      String base64Image = base64Encode(imageBytes);

      final defaultMessage = jsonEncode({
        "meta": "echo_payload",
        "user_id": widget.userId,
        "room_id": widget.groupId,
        "message": "image",
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
          "type": "image",
          "message": "image",
          "image": base64Image,
          "file_name": image.name,
          "createdAt": isoDate,
          "updatedAt": isoDate
        }
      });

      _channel.sink.add(defaultMessage);
    }
  }

// function to send file through web socket
  Future<void> _sendFile(FilePickerResult result) async {
    // Iterate through the selected files (FilePickerResult can contain multiple files)
    for (PlatformFile file in result.files) {
      // check mime type of file and throw error if not supported
      final mimeTypeData = lookupMimeType(file.path!);
      if (!legalMimeTypesList.contains(mimeTypeData)) {
        // ignore: use_build_context_synchronously
        AnimatedSnackBar.rectangle(
          'File type not supported',
          "Error: File type not supported",
          type: AnimatedSnackBarType.warning,
          brightness: Brightness.light,
        ).show(
          context,
        );
        return;
      }

      // Read the file as bytes
      File fileToRead = File(file.path!);
      Uint8List fileBytes = await fileToRead.readAsBytes();

      // Encode the file bytes to base64
      String base64File = base64Encode(fileBytes);

      // generate timestamp
      DateTime now = DateTime.now().toUtc();
      String isoDate = DateFormat("yyyy-MM-ddTHH:mm:ss.SSS'Z'").format(now);

      final defaultMessage = jsonEncode({
        "meta": "echo_payload",
        "user_id": widget.userId,
        "room_id": widget.groupId,
        "message": "file",
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
          "type": "file",
          "message": "file",
          "file": base64File,
          'file_name': file.name,
          'file_extension': file.extension,
          'file_size': file.size,
          "createdAt": isoDate,
          "updatedAt": isoDate
        }
      });
      _channel.sink.add(defaultMessage);
    }
  }

// function to join chat room through websocket
  void _joinChatInitialize() {
    if (widget.groupId.isNotEmpty && widget.userId != "") {
      final defaultMessage = jsonEncode({
        "meta": "join_conversation",
        "room_id": widget.groupId,
        "sender_id": widget.userId,
        "type": "join",
        "message": "",
      });
      _channel.sink.add(defaultMessage);
    }
  }

// function to fetch initial message data
  Future<List<dynamic>> _fetchInitialData() async {
    try {
      final getGroupChatMessages =
          ref.read(getGroupchatMessagesProvider(widget.groupId).future);

      return await getGroupChatMessages.then((groupData) {
        // for each map element in groupData add isFromWeb to true
        for (var element in groupData) {
          element["isFromWeb"] = true;
        }
        return groupData;
      });
    } catch (error) {
      // Or, if you want to rethrow the error:
      rethrow;
    }
  }

// function to fetch user profile
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

// function to check if the file size is greater than 3MB
  bool _checkFileSizeIsGreaterThan3MB(FilePickerResult file) {
    bool status = false;

    // Check if the file size is greater than 3MB
    for (var element in file.files) {
      final int fileSize = element.size;

      // Convert bytes to megabytes
      final double fileSizeInMB = fileSize / (1024 * 1024);

      if (fileSizeInMB > 3) {
        status = true;
        break;
      }
    }

    return status;
  }

// function to check if the image size is greater than 3MB
  Future<bool> _checkImageSizeIsGreaterThan3MB(XFile image) async {
    // Get the file size in bytes
    final int fileSize = await image.length();

    // Convert bytes to megabytes
    final double fileSizeInMB = fileSize / (1024 * 1024);

    if (fileSizeInMB > 3) {
      return true;
    }

    return false;
  }

// dispose the channel and dispose the message controller
  @override
  void dispose() {
    _channel.sink.close();
    _messageController.dispose();
    super.dispose();
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
