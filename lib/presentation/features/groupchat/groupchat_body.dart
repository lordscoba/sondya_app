import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sondya_app/data/extra_constants.dart';
import 'package:sondya_app/data/remote/groupchat.dart';
import 'package:sondya_app/domain/providers/groupchat.dart';
import 'package:sondya_app/utils/dateTime_to_string.dart';

class GroupChatBody extends ConsumerStatefulWidget {
  final String groupId;
  const GroupChatBody({super.key, required this.groupId});

  @override
  ConsumerState<GroupChatBody> createState() => _GroupChatBodyState();
}

class _GroupChatBodyState extends ConsumerState<GroupChatBody> {
  Map<String, dynamic> messageData = {
    "message": "",
    "group_id": "",
    "sender_id": "",
  };

  @override
  void initState() {
    super.initState();
    // Initialize the variable in initState
    messageData["group_id"] = widget.groupId;
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unused_result
    // ref.refresh(memberJoinGroupChatProvider);

    final AsyncValue<Map<String, dynamic>> checkStateMessages =
        ref.watch(sendMessageGroupChatProvider);

    final AsyncValue<Map<String, dynamic>> checkStateToggeleLike =
        ref.watch(toggleLikeButtonGroupChatProvider);

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
                  context.push("/group/chat/details/${widget.groupId}");
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
                    // )
                  ],
                ),
              ),
              const SizedBox(height: 10.0),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.6,
                child: Column(
                  children: [
                    Expanded(
                      child: GroupChatList(
                        groupId: widget.groupId,
                      ),
                    ),
                    const SizedBox(height: 2.0),
                    TextField(
                      decoration: InputDecoration(
                        hintText: "Type your message...",
                        suffixIcon: IconButton(
                          onPressed: () async {
                            if (messageData["message"].isNotEmpty) {
                              ref.invalidate(sendMessageGroupChatProvider);

                              await ref
                                  .read(sendMessageGroupChatProvider.notifier)
                                  .sendMessage(
                                    messageData,
                                  );
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
}

class GroupChatList extends ConsumerWidget {
  final String groupId;
  const GroupChatList({super.key, required this.groupId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // get the details
    final getGroupChatMessages =
        ref.watch(getGroupchatMessagesProvider(groupId));
    return getGroupChatMessages.when(
      data: (data) {
        return ListView.separated(
          reverse: true,
          shrinkWrap: true,
          itemCount: data.length,
          itemBuilder: (context, index) {
            if (data[index]["isMe"]) {
              return GroupChatSnippet2(
                text: data[index]["message"],
                time: sondyaFormattedDate(data[index]["createdAt"]),
              );
            }
            return GroupChatSnippet(
              text: data[index]["message"],
              senderName:
                  "${data[index]["sender"]["first_name"] ?? ""} ${data[index]["sender"]["last_name"] ?? ""}",
              image: data[index]["image"] != null &&
                      data[index]["image"].isNotEmpty
                  ? data[index]["image"][0]["url"]
                  : networkImagePlaceholder,
              time: sondyaFormattedDate(data[index]["createdAt"]),
            );
          },
          separatorBuilder: (context, index) => const SizedBox(height: 10.0),
        );
      },
      error: (error, stackTrace) => Text(error.toString()),
      loading: () => const CupertinoActivityIndicator(
        radius: 20,
      ),
    );
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
