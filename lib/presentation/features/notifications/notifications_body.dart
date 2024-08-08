import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sondya_app/data/remote/notifications.dart';
import 'package:sondya_app/utils/dateTime_to_string.dart';

class NotificationsBody extends ConsumerStatefulWidget {
  const NotificationsBody({super.key});

  @override
  ConsumerState<NotificationsBody> createState() => _NotificationsBodyState();
}

class _NotificationsBodyState extends ConsumerState<NotificationsBody> {
  @override
  Widget build(BuildContext context) {
    final getUserNotifications = ref.watch(getUserNotificationsProvider);
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Center(
        child: Column(
          children: [
            context.canPop()
                ? Row(
                    children: [
                      IconButton(
                          iconSize: 30,
                          onPressed: () {
                            context.pop();
                          },
                          icon: const Icon(Icons.arrow_back))
                    ],
                  )
                : const SizedBox(),
            SizedBox(
              height: MediaQuery.of(context).size.height,
              child: getUserNotifications.when(
                data: (data) {
                  return ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      if (data.isNotEmpty) {
                        return NotificationItem(
                          id: data[index]["_id"],
                          seen: data[index]["seen"],
                          type: data[index]["type"],
                          user: data[index]["user"],
                          title: data[index]["title"],
                          createdAt: data[index]["createdAt"],
                          index: index,
                        );
                      }
                      return const SizedBox(
                        child: Center(
                          child: Text("No Notifications Found"),
                        ),
                      );
                    },
                  );
                },
                loading: () => const Center(
                  child: CupertinoActivityIndicator(
                    radius: 30, // Adjust the size of the indicator as needed
                  ),
                ),
                error: (error, stackTrace) => Text(error.toString()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NotificationItem extends ConsumerStatefulWidget {
  final int index;
  final String id;
  final bool seen;
  final String type;
  final Map<String, dynamic> user;
  final String title;
  final String createdAt;
  const NotificationItem(
      {required this.index,
      required this.id,
      required this.seen,
      required this.type,
      required this.user,
      required this.title,
      required this.createdAt,
      super.key});

  @override
  ConsumerState<NotificationItem> createState() => _NotificationItemState();
}

class _NotificationItemState extends ConsumerState<NotificationItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(
          color: widget.seen ? Colors.black38 : const Color(0xFFEDB842),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.3,
            height: 130,
            child: const Image(
              image: NetworkImage("https://picsum.photos/200/300"),
              fit: BoxFit.cover,
              height: 130,
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.user["username"] ?? widget.user["email"],
                  style: const TextStyle(
                      fontSize: 17, fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    Text(
                      sondyaFormattedDate(widget.createdAt),
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 10),
                    if (!widget.seen)
                      const Icon(
                        Icons.circle,
                        color: Color(0xFFEDB842),
                        size: 20,
                      )
                  ],
                ),
                Text(
                  widget.title,
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                ),
                TextButton(
                  style: ButtonStyle(
                    textStyle: MaterialStateProperty.all<TextStyle>(
                      const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    foregroundColor: MaterialStateProperty.all<Color>(
                        widget.seen ? Colors.black38 : const Color(0xFFEDB842)),
                  ),
                  onPressed: () {
                    ref.read(markSeenNotificationsProvider(widget.id));
                    // ignore: unused_result
                    ref.refresh(getUserNotificationsProvider);
                    // ignore: unused_result
                    ref.refresh(getUserNotificationsUnSeenCountProvider);
                    context.push("/inbox");
                  },
                  child: const Text("View Details"),
                ),
              ],
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.07,
            child: IconButton(
                onPressed: () async {
                  ref.read(deleteUserNotificationsProvider(widget.id));
                  // ignore: unused_result
                  ref.refresh(getUserNotificationsProvider);
                  // ignore: unused_result
                  ref.refresh(getUserNotificationsUnSeenCountProvider);
                },
                icon: const Icon(Icons.delete)),
          ),
        ],
      ),
    );
  }
}
