import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sondya_app/data/extra_constants.dart';
import 'package:sondya_app/data/remote/chat.dart';
import 'package:sondya_app/domain/models/chat.dart';
import 'package:sondya_app/domain/providers/chat.provider.dart';
import 'package:sondya_app/utils/dateTime_to_string.dart';

class SellerChatBox extends ConsumerStatefulWidget {
  final String? serviceId;
  final Map<String, dynamic>? sellerData;
  final Map<String, dynamic>? buyerData;
  const SellerChatBox(
      {super.key, this.sellerData, this.buyerData, this.serviceId});

  @override
  ConsumerState<SellerChatBox> createState() => _SellerChatBoxState();
}

class _SellerChatBoxState extends ConsumerState<SellerChatBox> {
  late Map<String, dynamic> buyer;
  late Map<String, dynamic> seller;
  late PostMessageType chatMessage;

  @override
  void initState() {
    super.initState();
    buyer = widget.buyerData!;
    seller = widget.sellerData!;
    chatMessage = PostMessageType();
  }

  @override
  Widget build(BuildContext context) {
    final getChats = ref.watch(
        getMessagesProvider((receiverId: seller["id"], senderId: buyer["id"])));

    // getChats.whenData(
    //   (data) {
    //     print("hy");
    //     print(data);
    //     // userChats = [...data];
    //   },
    // );

    final AsyncValue<Map<String, dynamic>> checkState =
        ref.watch(postMessagesProvider);
    return Container(
      margin: const EdgeInsets.all(8.0),
      padding: const EdgeInsets.all(12.0),
      // add border decoration
      decoration: BoxDecoration(
        // border: Border.all(color: Colors.black38, width: 1.0),
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
                buyer["username"] ?? buyer["email"],
                style: const TextStyle(fontWeight: FontWeight.bold),
              )
            ],
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5.0),
            child: getChats.when(
              data: (data1) {
                // ignore: unnecessary_null_comparison
                if (data1 == null || data1.isEmpty) {
                  return const Center(
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
                  );
                }
                return ConstrainedBox(
                  constraints:
                      const BoxConstraints(minHeight: 300, maxHeight: 500),
                  child: ListView.separated(
                    reverse: true,
                    shrinkWrap: true,
                    itemCount: data1.length,
                    itemBuilder: (context, index) {
                      var data = data1.reversed.toList();
                      if (data[index]["sender_id"]["_id"] == buyer["id"]) {
                        return BorderTextForChat(
                          text: data[index]["message"],
                          time: sondyaFormattedDate(data[index]["createdAt"]),
                        );
                      }
                      return ReceiverBorderTextForChat(
                        text: data[index]["message"],
                        time: sondyaFormattedDate(data[index]["createdAt"]),
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
              error: (error, stackTrace) => Text(error.toString()),
              loading: () => const Center(
                child: CupertinoActivityIndicator(
                  radius: 50,
                ),
              ),
            ),
          ),
          const Divider(),
          TextField(
            decoration: InputDecoration(
              hintText: "Enter Message....",
              border: InputBorder.none,
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
                            receiverId: seller["id"],
                            senderId: buyer["id"]
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
}

class ReceiverBorderTextForChat extends StatelessWidget {
  final String text;
  final String? time;
  const ReceiverBorderTextForChat({super.key, required this.text, this.time});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black38,
                width: 1,
              ),
              image: const DecorationImage(
                image: NetworkImage(networkImagePlaceholder),
                fit: BoxFit.cover,
              ),
              shape: BoxShape.circle),
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.6,
          margin: const EdgeInsets.all(8),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black38,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              SizedBox(
                width: 260,
                child: SelectableText(
                  text,
                ),
              ),
              const SizedBox(height: 5.0),
              Align(
                alignment: Alignment.bottomRight,
                child: SizedBox(
                  width: 130,
                  child: SelectableText(
                    time ?? "unknown",
                    style: const TextStyle(fontSize: 10),
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

class BorderTextForChat extends StatelessWidget {
  final String text;
  final String? time;
  const BorderTextForChat({super.key, required this.text, this.time});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          margin: const EdgeInsets.all(8),
          padding: const EdgeInsets.all(12),
          width: MediaQuery.of(context).size.width * 0.6,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black38,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              SizedBox(
                width: 260,
                child: SelectableText(
                  text,
                ),
              ),
              const SizedBox(height: 5.0),
              Align(
                alignment: Alignment.bottomRight,
                child: SizedBox(
                  width: 130,
                  child: SelectableText(
                    time ?? "unknown",
                    style: const TextStyle(
                      fontSize: 10,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black38,
              width: 1,
            ),
            image: const DecorationImage(
              image: NetworkImage(networkImagePlaceholder),
              fit: BoxFit.cover,
            ),
            shape: BoxShape.circle,
          ),
        ),
      ],
    );
  }
}
