import 'dart:convert';
import 'dart:io';

import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:mime/mime.dart';
import 'package:sondya_app/data/api_constants.dart';
import 'package:sondya_app/data/extra_constants.dart';
import 'package:sondya_app/data/legal_mimetypes.dart';
import 'package:sondya_app/data/remote/chat.dart';
import 'package:sondya_app/domain/models/chat.dart';
import 'package:sondya_app/domain/providers/chat.provider.dart';
import 'package:sondya_app/presentation/features/service_details/seller_chat_box_snippet.dart';
import 'package:sondya_app/presentation/widgets/image_selection.dart';
import 'package:sondya_app/utils/dateTime_to_string.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class SellerChatBox extends ConsumerStatefulWidget {
  final String? serviceId;
  final Map<String, dynamic>? sellerData;
  final Map<String, dynamic>? buyerData;
  const SellerChatBox({
    super.key,
    this.sellerData,
    this.buyerData,
    this.serviceId,
  });

  @override
  ConsumerState<SellerChatBox> createState() => _SellerChatBoxState();
}

class _SellerChatBoxState extends ConsumerState<SellerChatBox> {
  late Map<String, dynamic> buyer;
  late Map<String, dynamic> seller;
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

    // initialize buyer
    buyer = widget.buyerData!;

    // initialize seller
    seller = widget.sellerData!;

    // initialize chat variable
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
    final getChats = ref.watch(
        getMessagesProvider((receiverId: seller["id"], senderId: buyer["id"])));

    final AsyncValue<Map<String, dynamic>> checkState =
        ref.watch(postMessagesProvider);
    return Container(
      margin: const EdgeInsets.all(8.0),
      padding: const EdgeInsets.all(12.0),
      // add border decoration
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: Theme.of(context).colorScheme.background,
        // add shadow
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              const Text(
                "Chat with seller",
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                seller["username"] ?? seller["email"],
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              Icon(Icons.person,
                  size: 20, color: _userStatus ? Colors.green : Colors.red),
              const SizedBox(
                width: 5,
              ),
              _userStatus
                  ? const Text(
                      "Online",
                      style: TextStyle(color: Colors.green),
                    )
                  : const Text(
                      "Offline",
                      style: TextStyle(color: Colors.red),
                    ),
              const SizedBox(
                width: 5,
              ),
            ],
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5.0),
            child: Column(
              children: [
                if (chatData.isEmpty)
                  const Center(
                    child: Column(
                      children: [
                        Text("This is a new chat. No messages yet"),
                        SizedBox(
                          height: 10,
                        ),
                        ReceiverBorderTextForChat(
                          text: "👋 Hey, say hi to seller...",
                        ),
                      ],
                    ),
                  ),
                if (getChats.isLoading)
                  const Center(
                    child: CupertinoActivityIndicator(
                      radius: 50,
                    ),
                  ),
                if (getChats.hasError) Text(getChats.error.toString()),
                if (chatData.isNotEmpty)
                  ConstrainedBox(
                    constraints:
                        const BoxConstraints(minHeight: 300, maxHeight: 500),
                    child: ListView.separated(
                      reverse: true,
                      shrinkWrap: true,
                      itemCount: chatData.length,
                      itemBuilder: (context, index) {
                        if (chatData[index]["sender_id"]["_id"] ==
                            buyer["id"]) {
                          // check if the message is an image
                          if (chatData[index]["type"] == "image") {
                            return BorderImageForChat(
                              isFromWeb: chatData[index]["isFromWeb"] ?? false,
                              text: chatData[index]["message"],
                              time: sondyaFormattedDate(
                                  chatData[index]["createdAt"]),
                              imageChat: chatData[index]["file_attachments"],
                            );
                          }

                          // check if the message is a file
                          if (chatData[index]["type"] == "file") {
                            return BorderFileForChat(
                              isFromWeb: chatData[index]["isFromWeb"] ?? false,
                              text: chatData[index]["message"],
                              time: sondyaFormattedDate(
                                  chatData[index]["createdAt"]),
                              fileChat: chatData[index]["file_attachments"],
                              fileSize: chatData[index]["file_size"] ?? 0,
                              fileName: chatData[index]["file_name"] ?? "",
                              fileExtension:
                                  chatData[index]["file_extension"] ?? "",
                            );
                          }

                          // check if the message is a text
                          return BorderTextForChat(
                            text: chatData[index]["message"],
                            time: sondyaFormattedDate(
                                chatData[index]["createdAt"]),
                          );
                        }

                        // check if the message is an image
                        if (chatData[index]["type"] == "image") {
                          return ReceiverBorderImageForChat(
                            isFromWeb: chatData[index]["isFromWeb"] ?? false,
                            text: chatData[index]["message"],
                            time: sondyaFormattedDate(
                                chatData[index]["createdAt"]),
                            image: chatData[index]["image"] != null &&
                                    chatData[index]["image"].isNotEmpty
                                ? chatData[index]["image"][0]["url"]
                                : networkImagePlaceholder,
                            imageChat: chatData[index]["file_attachments"],
                          );
                        }

                        // check if the message is a file
                        if (chatData[index]["type"] == "file") {
                          return ReceiverBorderFileForChat(
                            isFromWeb: chatData[index]["isFromWeb"] ?? false,
                            text: chatData[index]["message"],
                            time: sondyaFormattedDate(
                                chatData[index]["createdAt"]),
                            image: chatData[index]["image"] != null &&
                                    chatData[index]["image"].isNotEmpty
                                ? chatData[index]["image"][0]["url"]
                                : networkImagePlaceholder,
                            fileChat: chatData[index]["file_attachments"],
                            fileSize: chatData[index]["file_size"],
                            fileName: chatData[index]["file_name"],
                            fileExtension: chatData[index]["file_extension"],
                          );
                        }

                        // check if the message is a text
                        return ReceiverBorderTextForChat(
                          text: chatData[index]["message"],
                          time:
                              sondyaFormattedDate(chatData[index]["createdAt"]),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          height: 10,
                        );
                      },
                    ),
                  ),
              ],
            ),
          ),
          const Divider(),
          TextField(
            controller: _messageController,
            decoration: InputDecoration(
              hintText: "Enter Message....",
              border: InputBorder.none,
              suffixIcon: chatMessage.messageText != null &&
                      chatMessage.messageText != ""
                  ? IconButton(
                      onPressed: () {
                        if (chatMessage.messageText != null &&
                            chatMessage.messageText != "") {
                          // send message to websocket
                          _sendMessage(chatMessage.messageText!);

                          // send message to server
                          ref
                              .read(postMessagesProvider.notifier)
                              .postMessages(chatMessage, "text");

                          // ignore: unused_result
                          ref.refresh(getMessagesProvider((
                            receiverId: seller["id"],
                            senderId: buyer["id"]
                          )));

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
                              milliseconds: 100), // Adjust animation duration
                          transitionBuilder: (context, a1, a2, widget) {
                            return FadeTransition(
                              opacity: CurvedAnimation(
                                  parent: a1, curve: Curves.easeIn),
                              child: widget,
                            );
                          },
                          barrierLabel: MaterialLocalizations.of(context)
                              .modalBarrierDismissLabel, // Optional accessibility label
                          pageBuilder: (context, animation1, animation2) {
                            return SondyaFileAttachmentWidget(
                              onSetFile: (value) async {
                                if (value.count > 0 && value.files.isNotEmpty) {
                                  // Check if the file size is greater than 3MB
                                  if (_checkFileSizeIsGreaterThan3MB(value)) {
                                    // ignore: use_build_context_synchronously
                                    AnimatedSnackBar.rectangle(
                                      'Error',
                                      "File size is greater than 3MB(file size should be less than 3MB)",
                                      type: AnimatedSnackBarType.warning,
                                      brightness: Brightness.light,
                                    ).show(
                                      context,
                                    );
                                    return;
                                  }
                                  // refresh the send message provider
                                  ref.invalidate(postMessagesProvider);

                                  // Send the file through the web socket
                                  _sendFile(value);

                                  // assign data to message type and message
                                  chatMessage.file = value;
                                  chatMessage.messageText = "file";
                                  chatMessage.type = "file";
                                  chatMessage.senderId = buyer["id"];
                                  chatMessage.receiverId = seller["id"];

                                  // send message through the api
                                  await ref
                                      .read(postMessagesProvider.notifier)
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
                                    type: AnimatedSnackBarType.warning,
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
                                      type: AnimatedSnackBarType.warning,
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
                                  ref.invalidate(postMessagesProvider);

                                  // assign data to message type and message
                                  chatMessage.image = value;
                                  chatMessage.messageText = "image";
                                  chatMessage.type = "image";
                                  chatMessage.senderId = buyer["id"];
                                  chatMessage.receiverId = seller["id"];

                                  // send message through the api
                                  await ref
                                      .read(postMessagesProvider.notifier)
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
                                    type: AnimatedSnackBarType.warning,
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
                chatMessage.senderId = buyer["id"];
                chatMessage.receiverId = seller["id"];
                chatMessage.serviceId = widget.serviceId;
              });
            },
          ),
        ],
      ),
    );
  }

  // Connect to Web Socket
  void _connectWebSocket() {
    _channel = WebSocketChannel.connect(Uri.parse(_socketUrl));

    _channel.stream.listen(
      (message) {
        final newMessage = jsonDecode(message);
        if (newMessage["meta"] != null &&
            newMessage["meta"] == "user_status" &&
            newMessage["user_id"] == seller["id"]) {
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

  // Send Message
  void _sendMessage(String text) {
    if (chatMessage.messageText != null && chatMessage.messageText != "") {
      DateTime now = DateTime.now().toUtc();
      String isoDate = DateFormat("yyyy-MM-ddTHH:mm:ss.SSS'Z'").format(now);
      final defaultMessage = jsonEncode({
        "meta": "echo_payload",
        "sender_id": buyer["id"],
        "receiver_id": seller["id"],
        "payload": {
          "chat_id": _chatId,
          "sender_id": {
            "_id": buyer["id"],
            "first_name": buyer["username"].isNotEmpty
                ? buyer["username"]
                : chatData[0]["sender_id"]["username"] ?? "nil",
            "last_name": "",
            "username": buyer["username"].isNotEmpty
                ? buyer["username"]
                : chatData[0]["sender_id"]["username"] ?? "nil",
            "email": buyer["email"].isNotEmpty
                ? buyer["email"]
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
        "sender_id": buyer["id"],
        "receiver_id": seller["id"],
        "message": "image",
        "payload": {
          "chat_id": _chatId,
          "sender_id": {
            "_id": buyer["id"],
            "first_name": buyer["username"].isNotEmpty
                ? buyer["username"]
                : chatData[0]["sender_id"]["username"] ?? "nil",
            "last_name": "",
            "username": buyer["username"].isNotEmpty
                ? buyer["username"]
                : chatData[0]["sender_id"]["username"] ?? "nil",
            "email": buyer["email"].isNotEmpty
                ? buyer["email"]
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
        "sender_id": buyer["id"],
        "receiver_id": seller["id"],
        "message": "file",
        "payload": {
          "chat_id": _chatId,
          "sender_id": {
            "_id": buyer["id"],
            "first_name": buyer["username"].isNotEmpty
                ? buyer["username"]
                : chatData[0]["sender_id"]["username"] ?? "nil",
            "last_name": "",
            "username": buyer["username"].isNotEmpty
                ? buyer["username"]
                : chatData[0]["sender_id"]["username"] ?? "nil",
            "email": buyer["email"].isNotEmpty
                ? buyer["email"]
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

  // Join Chat
  void _joinChatInitialize() {
    if (_chatId.isNotEmpty && seller["id"] != "") {
      final defaultMessage = jsonEncode({
        "meta": "join_conversation",
        "room_id": _chatId,
        "sender_id": buyer["id"],
      });
      _channel.sink.add(defaultMessage);
    }
  }

  // Fetch Initial Data
  Future<List<dynamic>> _fetchInitialData() async {
    try {
      final getChats = ref.read(getMessagesProvider(
        (receiverId: seller["id"], senderId: buyer["id"]),
      ).future);

      return await getChats.then((data3) {
        setState(() {
          if (!_isInitialFetchDone) {
            _chatId = data3[0]["chat_id"];
            chatData = data3.reversed.toList();

            _isInitialFetchDone = true; // Set the flag to true
          }
        });

        // Add the "isFromWeb" flag to each message
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
