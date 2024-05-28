import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sondya_app/data/extra_constants.dart';

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
  @override
  void initState() {
    super.initState();
    // Initialize the variable in initState
    chatSender = widget.data;
  }

  @override
  Widget build(BuildContext context) {
    print(widget.data);
    print(widget.chatId);
    print(widget.userId);
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
              const SizedBox(height: 20.0),
              const Text(
                "Inbox",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20.0),
              Container(
                height: MediaQuery.of(context).size.height - 370,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          // const Icon(Icons.person),
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
                    const Center(
                        child: Text("This is a new chat. No messages yet")),
                    TextField(
                      decoration: InputDecoration(
                        hintText: "Type your message...",
                        // labelText: 'Code',
                        suffixIcon: IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.send),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
