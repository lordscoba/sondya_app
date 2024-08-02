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
  // initialize get new users
  List<dynamic> usersNew = [];

  late ProductSearchModel search; // get product model

  final TextEditingController _textSearch = TextEditingController();

  // for the chat users data
  List<dynamic> usersChatData = [];
  bool _isInitialFetchDone = false; // Flag to track if initial fetch is done

  // initialize empty chats list
  List<dynamic> chatReceiver = [];

  @override
  void initState() {
    super.initState();

    // initialize search
    search = ref.read(usersSearchprovider);

    // Perform initial data fetch
    _fetchInitialUserData().then((data) {
      // Access data if needed from _fetchInitialUserData

      // add users(the ones receiving the message) to chatReceiver
      for (var element in data) {
        if (element["user1"]["_id"] != widget.userId) {
          chatReceiver.add(element["user1"]);
        } else {
          chatReceiver.add(element["user2"]);
        }
      }

      // initialize users chats data
      usersChatData = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    // get chats state
    final getChats = ref.watch(getChatsProvider);

    // get new users state
    final getUsers = ref.watch(getUsersProvider(
        "?${mapToSearchString(ref.watch(usersSearchprovider).toJson())}"));

    if (ref.watch(usersSearchprovider).search != null &&
        ref.watch(usersSearchprovider).search!.length > 1) {
      getUsers.whenData(
        (data) {
          usersNew = data;
        },
      );
    }

    return SingleChildScrollView(
      child: Center(
        child: Container(
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
                controller: _textSearch,
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

                            _textSearch.clear();
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

                            _textSearch.clear();
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
                height: MediaQuery.of(context).size.height * 0.48,
                padding: const EdgeInsets.all(10.0),
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: <Widget>[
                    // for loading get chats and get users
                    if (getChats.isLoading || getUsers.isLoading)
                      const Center(
                        child: CupertinoActivityIndicator(
                          radius: 50,
                        ),
                      ),

                    // for loading get chats
                    if (getChats.hasError)
                      Text(
                        getChats.error.toString(),
                      ),

                    // if chat list data is empty, show message
                    if (usersChatData.isEmpty)
                      const Center(
                        child: Text("Pick a User to Chat with..."),
                      ),

                    // users filter by search, to get new users
                    if (usersNew.isNotEmpty &&
                        !getUsers.isLoading &&
                        !getChats.isLoading)
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.45,
                        width: MediaQuery.of(context).size.width * 0.98,
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: usersNew.length,
                          itemBuilder: (context, index) {
                            return InboxDataItemForNew(
                              id: usersNew[index]["_id"].toString(),
                              senderId: widget.userId,
                              receiverId: usersNew[index]["_id"],
                              receiverData: usersNew[index],
                              name:
                                  "${usersNew[index]["first_name"]} ${usersNew[index]["last_name"]}",
                              message: null,
                              time: null,
                              image: usersNew[index]["image"] != null &&
                                      usersNew[index]["image"].length > 0
                                  ? usersNew[index]["image"][0]["url"]
                                  : null,
                            );
                          },
                        ),
                      ),

                    // use this to get users chat that are active
                    if ((usersChatData.isNotEmpty &&
                        usersNew.isEmpty &&
                        !getUsers.isLoading))
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.45,
                        width: MediaQuery.of(context).size.width * 0.98,
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: usersChatData.length,
                          itemBuilder: (context, index) {
                            final message = usersChatData[index];
                            return InboxDataItem(
                              id: message["_id"].toString(),
                              senderId: widget.userId,
                              receiverId: chatReceiver[index]["_id"],
                              receiverData:
                                  message["user1"]["_id"] != widget.userId
                                      ? message["user1"]
                                      : message["user2"],
                              senderData:
                                  message["user1"]["_id"] == widget.userId
                                      ? message["user1"]
                                      : message["user2"],
                              name:
                                  "${chatReceiver[index]["first_name"]} ${chatReceiver[index]["last_name"]}",
                              message: message["messages"] != null &&
                                      message["messages"].isNotEmpty
                                  ? message["messages"].first["message"] ??
                                      "nil"
                                  : "No Messages",
                              time: message["messages"] != null &&
                                      message["messages"].isNotEmpty
                                  ? sondyaTimeAgo(
                                      message["messages"].first["updatedAt"])
                                  : sondyaTimeAgo(message["createdAt"]),
                              image: chatReceiver[index]["image"] != null &&
                                      chatReceiver[index]["image"].length > 0
                                  ? chatReceiver[index]["image"][0]["url"]
                                  : null,
                            );
                          },
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

  Future<List<dynamic>> _fetchInitialUserData() async {
    try {
      final getChats = ref.read(getChatsProvider.future);

      return await getChats.then((userdata) {
        setState(() {
          if (!_isInitialFetchDone) {
            // sort data according to time created priotizing lowest time
            userdata.sort((a, b) {
              if (b["messages"].isEmpty) {
                // Handle empty array case, e.g., return a value to prioritize or deprioritize
                return 1; // Prioritize elements with non-empty messages
              } else {
                return b["messages"]
                    .first["createdAt"]
                    .compareTo(a["messages"].first["createdAt"]);
              }
            });

            _isInitialFetchDone = true; // Set the flag to true
          }
        });

        return userdata;
      });
    } catch (error) {
      print(error);
      // Or, if you want to rethrow the error:
      rethrow;
    }
  }

  @override
  void dispose() {
    _textSearch.dispose();
    super.dispose();
  }
}

class InboxDataItemForNew extends ConsumerWidget {
  final String? id;
  final String? name;
  final String? message;
  final String? time;
  final String? image;
  final String? senderId;
  final String? receiverId;
  final Map<String, dynamic>? receiverData;
  final Map<String, dynamic>? senderData;
  const InboxDataItemForNew(
      {super.key,
      this.id,
      this.name,
      this.message,
      this.time,
      this.image,
      this.senderId,
      this.receiverId,
      this.receiverData,
      this.senderData});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // print("another data");
    // print({"sender_data": senderData, "receiver_data": receiverData});
    void goToChat() {
      context.push('/inbox/chat/${receiverId ?? "nil"}/${senderId ?? "nil"}',
          extra: {"sender_data": senderData, "receiver_data": receiverData});
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
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.38,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    senderId == receiverId ? "(you) $name" : name ?? "John Doe",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    message ?? "Say Hi! 😊",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const Spacer(),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.all(12.0),
                  decoration: const BoxDecoration(
                    color: Color(0xFFEDB842),
                    shape: BoxShape.circle,
                  ),
                  // child: const Text("1", style: TextStyle(color: Colors.white)),
                ),
                Text(time ?? ""),
              ],
            ),
          ],
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
  final Map<String, dynamic>? senderData;
  const InboxDataItem(
      {super.key,
      this.id,
      this.name,
      this.message,
      this.time,
      this.image,
      this.senderId,
      this.receiverId,
      this.receiverData,
      this.senderData});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // print("another data");
    // print({"sender_data": senderData, "receiver_data": receiverData});
    void goToChat() {
      context.push('/inbox/chat/${receiverId ?? "nil"}/${senderId ?? "nil"}',
          extra: {"sender_data": senderData, "receiver_data": receiverData});
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
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.38,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    senderId == receiverId ? "(you) $name" : name ?? "John Doe",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    message ?? "Hello, how are you?",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const Spacer(),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // Container(
                //   padding: const EdgeInsets.all(8.0),
                //   decoration: const BoxDecoration(
                //     color: Color(0xFFEDB842),
                //     shape: BoxShape.circle,
                //   ),
                //   child: const Text("1", style: TextStyle(color: Colors.white)),
                // ),
                const SizedBox(
                  height: 25,
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
