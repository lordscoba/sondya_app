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
import 'package:sondya_app/data/remote/chat.dart';
import 'package:sondya_app/domain/models/chat.dart';
import 'package:sondya_app/domain/providers/chat.provider.dart';
import 'package:sondya_app/presentation/features/user/inbox/inbox_chat_snippets.dart';
import 'package:sondya_app/presentation/widgets/image_selection.dart';
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
                                      if (chatData[index]["type"] == "image") {
                                        return ChatImageSnippet2(
                                          isFromWeb: chatData[index]
                                                  ["isFromWeb"] ??
                                              false,
                                          text: chatData[index]["message"],
                                          time: sondyaFormattedDate(
                                              chatData[index]["createdAt"]),
                                          imageChat: chatData[index]
                                              ["file_attachments"],
                                        );
                                      }

                                      if (chatData[index]["type"] == "file") {
                                        return ChatFileSnippet2(
                                          isFromWeb: chatData[index]
                                                  ["isFromWeb"] ??
                                              false,
                                          text: chatData[index]["message"],
                                          time: sondyaFormattedDate(
                                              chatData[index]["createdAt"]),
                                          fileChat: chatData[index]
                                              ["file_attachments"],
                                          fileSize:
                                              chatData[index]["file_size"] ?? 0,
                                          fileName: chatData[index]
                                                  ["file_name"] ??
                                              "",
                                          fileExtension: chatData[index]
                                                  ["file_extension"] ??
                                              "",
                                        );
                                      }
                                      if (chatData[index]["type"] == "image") {
                                        return ChatImageSnippet(
                                          isFromWeb: chatData[index]
                                                  ["isFromWeb"] ??
                                              false,
                                          text: chatData[index]["message"],
                                          time: sondyaFormattedDate(
                                              chatData[index]["createdAt"]),
                                          image: chatData[index]["image"] !=
                                                      null &&
                                                  chatData[index]["image"]
                                                      .isNotEmpty
                                              ? chatData[index]["image"][0]
                                                  ["url"]
                                              : networkImagePlaceholder,
                                          imageChat: chatData[index]
                                              ["file_attachments"],
                                        );
                                      }
                                      if (chatData[index]["type"] == "file") {
                                        return ChatFileSnippet(
                                          isFromWeb: chatData[index]
                                                  ["isFromWeb"] ??
                                              false,
                                          text: chatData[index]["message"],
                                          time: sondyaFormattedDate(
                                              chatData[index]["createdAt"]),
                                          image: chatData[index]["image"] !=
                                                      null &&
                                                  chatData[index]["image"]
                                                      .isNotEmpty
                                              ? chatData[index]["image"][0]
                                                  ["url"]
                                              : networkImagePlaceholder,
                                          fileChat: chatData[index]
                                              ["file_attachments"],
                                          fileSize: chatData[index]
                                              ["file_size"],
                                          fileName: chatData[index]
                                              ["file_name"],
                                          fileExtension: chatData[index]
                                              ["file_extension"],
                                        );
                                      }
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
                                onPressed: () async {
                                  if (chatMessage.messageText != null &&
                                      chatMessage.messageText != "") {
                                    // send the message through web socket
                                    _sendMessage(chatMessage.messageText!);

                                    // refresh the send message provider
                                    ref.invalidate(postMessagesProvider);

                                    // post the message
                                    await ref
                                        .read(postMessagesProvider.notifier)
                                        .postMessages(chatMessage, "text");

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
                                            // refresh the send message provider
                                            ref.invalidate(
                                                postMessagesProvider);

                                            // Send the file through the web socket
                                            _sendFile(value);

                                            // assign data to message type and message
                                            chatMessage.file = value;
                                            chatMessage.messageText = "file";
                                            chatMessage.type = "file";
                                            chatMessage.senderId =
                                                widget.userId;
                                            chatMessage.receiverId =
                                                widget.receiverId;

                                            // send message through the api
                                            await ref
                                                .read(postMessagesProvider
                                                    .notifier)
                                                .postMessages(
                                                  chatMessage,
                                                  "file",
                                                );

                                            // Clear the TextField
                                            _messageController.clear();
                                            chatMessage.messageText = "";
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
                                                postMessagesProvider);

                                            // assign data to message type and message
                                            chatMessage.image = value;
                                            chatMessage.messageText = "image";
                                            chatMessage.type = "image";
                                            chatMessage.senderId =
                                                widget.userId;
                                            chatMessage.receiverId =
                                                widget.receiverId;

                                            // send message through the api
                                            await ref
                                                .read(postMessagesProvider
                                                    .notifier)
                                                .postMessages(
                                                  chatMessage,
                                                  "image",
                                                );

                                            // Clear the TextField
                                            _messageController.clear();
                                            chatMessage.messageText = "";
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
        "sender_id": widget.userId,
        "receiver_id": widget.receiverId,
        "message": "image",
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
          "type": "image",
          "message": "image",
          "file_attachments": base64Image,
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
        "sender_id": widget.userId,
        "receiver_id": widget.receiverId,
        "message": "file",
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
          "type": "file",
          "message": "file",
          "file_attachments": base64File,
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
        for (var element in data3) {
          element["isFromWeb"] = true;
        }

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

  @override
  void dispose() {
    _channel.sink.close();
    _messageController.dispose();
    super.dispose();
  }
}
