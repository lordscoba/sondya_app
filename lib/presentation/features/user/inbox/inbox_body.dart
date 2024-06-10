import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sondya_app/data/extra_constants.dart';
import 'package:sondya_app/data/remote/chat.dart';
import 'package:sondya_app/data/remote/profile.dart';
import 'package:sondya_app/domain/models/home.dart';
import 'package:sondya_app/domain/providers/users.provider.dart';
import 'package:sondya_app/utils/iso_time.dart';
import 'package:sondya_app/utils/map_to_searchstring.dart';

class InboxBody extends ConsumerStatefulWidget {
  final String userId;
  const InboxBody({super.key, required this.userId});

  @override
  ConsumerState<InboxBody> createState() => _InboxBodyState();
}

class _InboxBodyState extends ConsumerState<InboxBody> {
  List<dynamic> userChats = []; // not in use yet

  List<dynamic> usersNew = [];

  late ProductSearchModel search;

  TextEditingController textSearch = TextEditingController();

  @override
  void initState() {
    super.initState();
    search = ref.read(usersSearchprovider);
  }

  @override
  Widget build(BuildContext context) {
    final getChats = ref.watch(getChatsProvider);
    // final getWebChats = ref.watch(chatWebSocketProvider);

    final getUsers = ref.watch(getUsersProvider(
        "?${mapToSearchString(ref.watch(usersSearchprovider).toJson())}"));

    if (ref.watch(usersSearchprovider).search != null &&
        ref.watch(usersSearchprovider).search!.length > 1) {
      getUsers.whenData(
        (data) {
          // print(data);
          usersNew = data;
        },
      );
    }

    // getWebChats.whenData(
    //   (data) {
    //     print(data);
    //     // userChats = [...data];
    //   },
    // );

    // text

    return SingleChildScrollView(
      child: RefreshIndicator(
        onRefresh: () async {
          // ignore: unused_result
          ref.refresh(getChatsProvider);
        },
        child: Center(
          child: Container(
            // height: 1200,
            width: double.infinity,
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
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
                TextField(
                  controller: textSearch,
                  decoration: InputDecoration(
                    hintText: "Search for users",
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: usersNew.isEmpty
                        ? null
                        : IconButton(
                            onPressed: () {
                              setState(() {
                                search.search = null;
                                search.page = null;
                                usersNew = [];
                              });
                              ref.read(usersSearchprovider.notifier).state =
                                  search;

                              textSearch.clear();
                            },
                            icon: const Icon(Icons.clear),
                          ),
                  ),
                  onChanged: (value) {
                    Future.delayed(const Duration(seconds: 1), () {
                      if (value.isNotEmpty) {
                        setState(() {
                          search.search = value;
                          search.page = null;
                        });
                      }
                      ref.read(usersSearchprovider.notifier).state = search;
                      // else {
                      //   setState(() {
                      //     search.search = null;
                      //     search.page = null;
                      //     ref.read(usersSearchprovider.notifier).state = search;
                      //     usersNew = [];
                      //   });
                      // }
                    });
                  },
                ),
                const SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Chats"),
                    usersNew.isEmpty
                        ? const SizedBox()
                        : TextButton(
                            onPressed: () {
                              setState(() {
                                search.search = null;
                                search.page = null;
                                usersNew = [];
                              });
                              ref.read(usersSearchprovider.notifier).state =
                                  search;

                              textSearch.clear();
                            },
                            child: const Text(
                              "Clear Search",
                              style: TextStyle(color: Colors.orangeAccent),
                            ),
                          )
                  ],
                ),
                const SizedBox(height: 20.0),
                Container(
                  height: MediaQuery.of(context).size.height * 0.5,
                  padding: const EdgeInsets.all(10.0),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: getChats.when(
                    data: (data) {
                      List<dynamic> chatReceiver = [];
                      for (var element in data) {
                        if (element["user1"]["_id"] != widget.userId) {
                          chatReceiver.add(element["user1"]);
                        } else {
                          chatReceiver.add(element["user2"]);
                        }
                      }
                      if (usersNew.isNotEmpty) {
                        return ListView.builder(
                          itemCount: usersNew.length,
                          itemBuilder: (context, index) {
                            return InboxDataItem(
                              id: usersNew[index]["_id"].toString(),
                              senderId: widget.userId,
                              receiverId: usersNew[index]["_id"],
                              receiverData: usersNew[index],
                              name:
                                  "${usersNew[index]["first_name"]} ${usersNew[index]["last_name"]}",
                              message: "",
                              time: "",
                              image: usersNew[index]["image"] != null &&
                                      usersNew[index]["image"].length > 0
                                  ? usersNew[index]["image"][0]["url"]
                                  : null,
                            );
                          },
                        );
                      }
                      // ignore: unnecessary_null_comparison
                      if (data == null || data.isEmpty) {
                        return const Center(
                          child: Text("Pick a User to Chat with..."),
                        );
                      }
                      return ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          final message = data[index];
                          return InboxDataItem(
                            id: message["_id"].toString(),
                            senderId: widget.userId,
                            receiverId: chatReceiver[index]["_id"],
                            receiverData:
                                message["user1"]["_id"] != widget.userId
                                    ? message["user1"]
                                    : message["user2"],
                            name:
                                "${chatReceiver[index]["first_name"]} ${chatReceiver[index]["last_name"]}",
                            message: message["messages"].first["message"],
                            time: sondyaTimeAgo(
                                message["messages"].first["updatedAt"]),
                            image: chatReceiver[index]["image"] != null &&
                                    chatReceiver[index]["image"].length > 0
                                ? chatReceiver[index]["image"][0]["url"]
                                : null,
                          );
                        },
                      );
                    },
                    error: (error, stackTrace) => Text(error.toString()),
                    loading: () => const Center(
                      child: CupertinoActivityIndicator(
                        radius: 50,
                      ),
                    ),
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

class InboxDataItem extends ConsumerWidget {
  final String? id;
  final String? name;
  final String? message;
  final String? time;
  final String? image;
  final String? senderId;
  final String? receiverId;
  final Map<String, dynamic>? receiverData;
  const InboxDataItem(
      {super.key,
      this.id,
      this.name,
      this.message,
      this.time,
      this.image,
      this.senderId,
      this.receiverId,
      this.receiverData});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void goToChat() {
      context.push('/inbox/chat/${id ?? "1"}/${senderId ?? "1"}',
          extra: receiverData);
    }

    return GestureDetector(
      onTap: goToChat,
      onLongPress: goToChat,
      onDoubleTap: goToChat,
      child: Container(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: NetworkImage(image ?? networkImagePlaceholder),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 10.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name ?? "John Doe",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Text(message ?? "Hello, how are you?"),
              ],
            ),
            const Spacer(),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: const BoxDecoration(
                    color: Color(0xFFEDB842),
                    shape: BoxShape.circle,
                  ),
                  child: const Text("1", style: TextStyle(color: Colors.white)),
                ),
                Text(time ?? "1w ago"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
