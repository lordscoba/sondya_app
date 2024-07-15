import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sondya_app/data/extra_constants.dart';
import 'package:sondya_app/data/remote/chat.dart';
import 'package:sondya_app/data/websocket/chat.websocket.dart';
import 'package:sondya_app/domain/models/chat.dart';
import 'package:sondya_app/domain/providers/chat.provider.dart';
import 'package:sondya_app/utils/dateTime_to_string.dart';

class InboxChatBody extends ConsumerStatefulWidget {
  final String userId;
  final String chatId;
  final Map<String, dynamic> data;
  const InboxChatBody(
      {super.key,
      required this.userId,
      required this.chatId,
      required this.data});

  @override
  ConsumerState<InboxChatBody> createState() => _InboxChatBodyState();
}

class _InboxChatBodyState extends ConsumerState<InboxChatBody> {
  late Map<String, dynamic> chatSender;
  late PostMessageType chatMessage;
  @override
  void initState() {
    super.initState();
    // Initialize the variable in initState
    chatSender = widget.data;
    chatMessage = PostMessageType();
  }

  @override
  Widget build(BuildContext context) {
    final getChats = ref.watch(
      getMessagesProvider(
        (receiverId: widget.data["_id"], senderId: widget.userId),
      ),
    );

    final getWebChats = ref.watch(chatWebSocketProvider);

    // getChats.whenData(
    //   (data) {
    //     print("hy");
    //     print(data);
    //     // userChats = [...data];
    //   },
    // );

    // getChats.when(
    //   data: (data) {
    //     print(data);
    //   },
    //   error: (error, stackTrace) {
    //     print(error);
    //   },
    //   loading: () {},
    // );
    final AsyncValue<Map<String, dynamic>> checkState =
        ref.watch(postMessagesProvider);
    return SingleChildScrollView(
      child: RefreshIndicator(
        onRefresh: () async {
          // ignore: unused_result
          ref.refresh(
            getMessagesProvider(
              (receiverId: widget.data["_id"], senderId: widget.userId),
            ),
          );
        },
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
                getWebChats.when(
                  data: (data) {
                    return Text(data.toString());
                  },
                  error: (error, stackTrace) {
                    return Text(error.toString());
                  },
                  loading: () => const SizedBox(),
                ),
                // checkState.when(
                //   data: (data) {
                //     return sondyaDisplaySuccessMessage(context, data["message"]);
                //   },
                //   loading: () => const SizedBox(),
                //   error: (error, stackTrace) =>
                //       sondyaDisplayErrorMessage(error.toString(), context),
                // ),
                const SizedBox(height: 20.0),
                const Text(
                  "Inbox",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20.0),
                Container(
                  height: MediaQuery.of(context).size.height * 0.6,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                  image: NetworkImage(
                                      widget.data["image"] != null &&
                                              widget.data["image"].length > 0
                                          ? widget.data["image"][0]["url"]
                                          : networkImagePlaceholder),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(width: 10.0),
                            Column(
                              children: [
                                Text(chatSender["username"] ?? "Unknown"),
                                const Row(
                                  children: [
                                    Icon(Icons.circle,
                                        color: Colors.green, size: 10),
                                    SizedBox(width: 5.0),
                                    Text("Active now"),
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
                          child: getChats.when(
                            data: (data1) {
                              // ignore: unnecessary_null_comparison
                              if (data1 == null || data1.isEmpty) {
                                return const Center(
                                  child: Text(
                                      "This is a new chat. No messages yet"),
                                );
                              }
                              return ConstrainedBox(
                                constraints: BoxConstraints(
                                    minHeight: 60,
                                    maxHeight:
                                        MediaQuery.of(context).size.height *
                                            0.46),
                                // height: MediaQuery.of(context).size.height * 0.46,
                                child: ListView.separated(
                                  reverse: true,
                                  shrinkWrap: true,
                                  itemCount: data1.length,
                                  itemBuilder: (context, index) {
                                    var data = data1.reversed.toList();

                                    if (data[index]["sender_id"]["_id"] ==
                                        widget.userId) {
                                      return ChatSnippet2(
                                        text: data[index]["message"],
                                        time: sondyaFormattedDate(
                                            data[index]["createdAt"]),
                                      );
                                    }
                                    return ChatSnippet(
                                      text: data[index]["message"],
                                      image: widget.data["image"] != null &&
                                              widget.data["image"].length > 0
                                          ? widget.data["image"][0]["url"]
                                          : networkImagePlaceholder,
                                      time: sondyaFormattedDate(
                                          data[index]["createdAt"]),
                                    );
                                  },
                                  separatorBuilder: (context, index) {
                                    return const SizedBox(
                                      height: 10,
                                    );
                                  },
                                ),
                              );
                            },
                            error: (error, stackTrace) =>
                                Text(error.toString()),
                            loading: () => const Center(
                              child: CupertinoActivityIndicator(
                                radius: 50,
                              ),
                            ),
                          ),
                        ),
                      ),
                      TextField(
                        decoration: InputDecoration(
                          hintText: "Type your message...",
                          suffixIcon: chatMessage.messageText != null &&
                                  chatMessage.messageText != ""
                              ? IconButton(
                                  onPressed: () {
                                    if (chatMessage.messageText != null &&
                                        chatMessage.messageText != "") {
                                      // print(chatMessage.toJson());
                                      ref
                                          .read(postMessagesProvider.notifier)
                                          .postMessages(chatMessage.toJson());

                                      // ignore: unused_result
                                      ref.refresh(getMessagesProvider((
                                        receiverId: widget.data["_id"],
                                        senderId: widget.userId
                                      )));
                                    }
                                  },
                                  icon: checkState.isLoading
                                      ? const Icon(Icons.bar_chart)
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
                            chatMessage.receiverId = chatSender["_id"];
                          });
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
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
