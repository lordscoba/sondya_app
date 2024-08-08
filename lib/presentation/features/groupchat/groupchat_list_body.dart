import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sondya_app/data/remote/groupchat.dart';
import 'package:sondya_app/domain/models/home.dart';
import 'package:sondya_app/domain/providers/groupchat.dart';
import 'package:sondya_app/presentation/widgets/success_error_message.dart';
import 'package:sondya_app/presentation/widgets/threebounce_loader.dart';
import 'package:sondya_app/utils/input_validations.dart';
import 'package:sondya_app/utils/map_to_searchstring.dart';

class GroupChatListBody extends ConsumerStatefulWidget {
  const GroupChatListBody({super.key});

  @override
  ConsumerState<GroupChatListBody> createState() => _GroupChatListBodyState();
}

class _GroupChatListBodyState extends ConsumerState<GroupChatListBody> {
  late ProductSearchModel search;
  List<dynamic> allItems = [];
  bool bottomPage = false;

  // for hiding the header
  bool hideHeader = false;

  // controls the scroll container
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // Initialize the variable in initState
    _scrollController.addListener(_scrollListener);
    search = ref.read(groupchatSearchprovider);

    // ignore: unused_result
    ref.refresh(memberJoinGroupChatProvider);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _loadMore() {
    if (search.page == null) {
      search.page = 2;
    } else {
      search.page = search.page! + 1;
    }
    ref.read(groupchatSearchprovider.notifier).state = search;
  }

  void _scrollListener() {
    // for the headers
    if (_scrollController.position.pixels >= 30.8 && !hideHeader) {
      setState(() {
        hideHeader = true;
      });
    } else if (_scrollController.position.pixels < 30.8 && hideHeader) {
      setState(() {
        hideHeader = false;
      });
    }

    // for bottom of page load
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      // Bottom of the page is reached
      // print('Reached the bottom!');
      if (bottomPage == false) {
        setState(() {
          _loadMore();
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // gets the search map removes null and page key, ready for iteration
    var searchData = ref.watch(groupchatSearchprovider).toJson();
    searchData.removeWhere((key, value) => (value == null || key == "page"));

    //calls search api with the filter strings
    final getGroupchats = ref.watch(getGroupchatsProvider(
        "?${mapToSearchString(ref.watch(groupchatSearchprovider).toJson())}"));

    // assigns fetched data to allitems array
    getGroupchats.whenData((data) {
      // print(data);
      if (data.isNotEmpty) {
        data.sort((a, b) {
          if (a['isJoined'] == b['isJoined']) {
            return a['name'].compareTo(b['name']);
          } else if (a['isJoined'] && !b['isJoined']) {
            return -1; // a should come before b
          } else {
            return 1; // b should come before a
          }
        });

        setState(() {
          allItems = [...allItems, ...data];
        });
      } else {
        setState(() {
          bottomPage = true;
        });
      }
    });
    return Container(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          context.canPop()
              ? Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: () {
                        context.pop();
                      },
                      icon: const Icon(Icons.arrow_back),
                    ),
                  ],
                )
              : const SizedBox(),
          hideHeader ? const SizedBox() : const SizedBox(height: 5.0),
          hideHeader
              ? const SizedBox()
              : const Text(
                  "Join our Community",
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF222222),
                  ),
                ),
          hideHeader ? const SizedBox() : const SizedBox(height: 5.0),
          hideHeader
              ? const SizedBox()
              : const Text(
                  "Join our community and unlock a world of opportunities! Whether you're buying or selling, this is the place to connect with others who share your interests. Together, let's build something special! 🛒",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Color(0xFF9F9F9F),
                  ),
                ),
          const SizedBox(height: 5.0),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            child: TextFormField(
              decoration: const InputDecoration(
                hintText: " Enter your search",
                labelText: 'Search',
                prefixIcon: Icon(Icons.search),
              ),
              validator: isInputEmpty,
              onChanged: (value) {
                Future.delayed(
                  const Duration(seconds: 1),
                  () {
                    if (value.isNotEmpty) {
                      setState(() {
                        // print(value);
                        search.search = value;
                        allItems = [];
                        search.page = null;
                        bottomPage = false;
                        ref.read(groupchatSearchprovider.notifier).state =
                            search;
                      });
                    }
                  },
                );
              },
            ),
          ),
          const SizedBox(height: 5.0),
          Expanded(
            child: ListView.separated(
              controller: _scrollController,
              itemCount: allItems.isNotEmpty ? allItems.length : 1,
              shrinkWrap: true,
              // physics: const NeverScrollableScrollPhysics(),
              separatorBuilder: (context, index) =>
                  const SizedBox(height: 20.0),
              itemBuilder: (context, index) {
                if (allItems.isNotEmpty) {
                  return GroupChatItem(
                    groupId: allItems[index]["_id"],
                    name: allItems[index]["name"],
                    description: allItems[index]["description"],
                    image: allItems[index]["image"] != null &&
                            allItems[index]["image"].isNotEmpty
                        ? allItems[index]["image"][0]["url"]
                        : "https://picsum.photos/id/237/200/300",
                    onTap: () {
                      context.push("/group/chat");
                    },
                    isJoined: allItems[index]["isJoined"],
                  );
                } else if (getGroupchats.hasValue && allItems.isEmpty) {
                  return const SizedBox(
                    height: 100, // Adjust the height as needed
                    child: Center(child: Text("No group chats found")),
                  );
                } else {
                  return const SizedBox(
                    height: 100, // Adjust the height as needed
                    child: Center(
                      child: CupertinoActivityIndicator(
                        radius:
                            30, // Adjust the size of the indicator as needed
                      ),
                    ),
                  );
                }
              },
            ),
          ),
          if (getGroupchats.isLoading)
            sondyaThreeBounceLoader(color: const Color(0xFFEDB842), size: 50),
          if (bottomPage == true)
            const Center(child: Text("You have reached bottom of the page"))
        ],
      ),
    );
  }
}

class GroupChatItem extends ConsumerStatefulWidget {
  final String groupId;
  final String name;
  final String description;
  final String image;
  final bool isJoined;
  final VoidCallback onTap;
  const GroupChatItem({
    super.key,
    required this.groupId,
    required this.name,
    required this.description,
    required this.onTap,
    required this.image,
    this.isJoined = false,
  });

  @override
  ConsumerState<GroupChatItem> createState() => _GroupChatItemState();
}

class _GroupChatItemState extends ConsumerState<GroupChatItem> {
  bool loadingBox = false;
  @override
  Widget build(BuildContext context) {
    final AsyncValue<Map<String, dynamic>> checkState =
        ref.watch(memberJoinGroupChatProvider);
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            checkState.when(
              data: (data) {
                if (data.isNotEmpty) {
                  WidgetsBinding.instance.addPostFrameCallback(
                      (_) => context.push("/group/chat/${widget.groupId}"));
                }
                // return sondyaDisplaySuccessMessage(context, data["message"]);
                return const SizedBox();
              },
              loading: () => const SizedBox(),
              error: (error, stackTrace) {
                return sondyaDisplayErrorMessage(error.toString(), context);
              },
            ),
            ClipRRect(
              borderRadius:
                  BorderRadius.circular(20.0), // Adjust the radius as needed
              child: Image(
                image: NetworkImage(widget.image),
                width: 50.0,
                height: 50.0,
                fit: BoxFit.cover,
                frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
                  if (wasSynchronouslyLoaded) {
                    return child;
                  }
                  return AnimatedOpacity(
                    opacity: frame == null ? 0 : 1,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeIn,
                    child: child,
                  );
                },
              ),
            ),
            const SizedBox(width: 10.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.name,
                  style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5.0),
                SizedBox(
                  width: 200.0,
                  child: Text(
                    widget.description,
                    style: const TextStyle(
                      fontSize: 14.0,
                      color: Color(0xFF9F9F9F),
                    ),
                  ),
                ),
                const SizedBox(height: 5.0),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      if (!widget.isJoined)
                        OutlinedButton(
                          onPressed: () async {
                            if (widget.groupId.isNotEmpty) {
                              loadingBox = true;
                              ref.invalidate(memberJoinGroupChatProvider);
                              await ref
                                  .read(memberJoinGroupChatProvider.notifier)
                                  .joinChat(
                                    widget.groupId,
                                  );
                            } else {
                              AnimatedSnackBar.rectangle(
                                'Error',
                                "Group Id cannot be empty",
                                type: AnimatedSnackBarType.warning,
                                brightness: Brightness.light,
                              ).show(
                                context,
                              );
                            }
                          },
                          child: checkState.isLoading && loadingBox
                              ? sondyaThreeBounceLoader(
                                  color: const Color(0xFFEDB842))
                              : const Text("Join"),
                        ),
                      if (widget.isJoined)
                        ElevatedButton(
                          onPressed: () {
                            context.push("/group/chat/${widget.groupId}");
                          },
                          child: const Text("Chat"),
                        )
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
