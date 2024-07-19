import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sondya_app/data/extra_constants.dart';
import 'package:sondya_app/data/remote/groupchat.dart';
import 'package:sondya_app/domain/providers/groupchat.dart';

class GroupChatBody extends ConsumerStatefulWidget {
  final String groupId;
  const GroupChatBody({super.key, required this.groupId});

  @override
  ConsumerState<GroupChatBody> createState() => _GroupChatBodyState();
}

class _GroupChatBodyState extends ConsumerState<GroupChatBody> {
  @override
  void initState() {
    super.initState();
    // Initialize the variable in initState
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unused_result
    // ref.refresh(memberJoinGroupChatProvider);

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
                    // IconButton(
                    //   onPressed: () {},
                    //   icon:
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
                    const Expanded(
                      child: GroupChatList(),
                    ),
                    const SizedBox(height: 2.0),
                    TextField(
                      decoration: InputDecoration(
                        hintText: "Type your message...",
                        suffixIcon: IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.send),
                        ),
                      ),
                      onChanged: (value) {},
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

class GroupChatList extends StatelessWidget {
  const GroupChatList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      reverse: true,
      shrinkWrap: true,
      itemCount: 10,
      itemBuilder: (context, index) {
        if (index.isEven) {
          return const GroupChatSnippet(
            text: "Hi there!",
            time: "10:00 AM",
            image: networkImagePlaceholder,
          );
        }
        return const GroupChatSnippet2(
          text: "Hi there!",
          time: "10:00 AM",
        );
      },
      separatorBuilder: (context, index) => const SizedBox(height: 10.0),
    );
  }
}

class GroupChatSnippet extends StatelessWidget {
  final String? text;
  final String? time;
  final String? image;
  const GroupChatSnippet(
      {super.key, required this.text, this.time, this.image});

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
          width: 400,
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
