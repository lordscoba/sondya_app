import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class GroupChatListBody extends StatelessWidget {
  const GroupChatListBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
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
            const SizedBox(height: 20.0),
            const Text(
              "Join our Community",
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF222222),
              ),
            ),
            const SizedBox(height: 20.0),
            const Text(
              "Join our community and unlock a world of opportunities! Whether you're buying or selling, this is the place to connect with others who share your interests. Together, let's build something special! 🛒",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14.0,
                color: Color(0xFF9F9F9F),
              ),
            ),
            const SizedBox(height: 20.0),
            ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                const SizedBox(height: 20.0),
                GroupChatItem(
                  name: "Group Chat",
                  onTap: () {
                    context.push("/groupchat");
                  },
                ),
                const SizedBox(height: 20.0),
                GroupChatItem(
                  name: "Group Chat",
                  onTap: () {
                    context.push("/groupchat");
                  },
                ),
                const SizedBox(height: 20.0),
                GroupChatItem(
                  name: "Group Chat",
                  onTap: () {
                    context.push("/groupchat");
                  },
                ),
              ],
              // separatorBuilder: (BuildContext context, int index) {
              //   return const SizedBox(height: 20.0);
              // },
            )
          ],
        ),
      ),
    );
  }
}

class GroupChatItem extends StatelessWidget {
  final String name;
  final VoidCallback onTap;
  const GroupChatItem({
    super.key,
    required this.name,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
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
            ClipRRect(
              borderRadius:
                  BorderRadius.circular(20.0), // Adjust the radius as needed
              child: Image(
                image:
                    const NetworkImage("https://picsum.photos/id/237/200/300"),
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
                const Text(
                  "Group Chat",
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5.0),
                const SizedBox(
                  width: 200.0,
                  child: Text(
                    "Social media has become an integral part of our day-to-day lives. It has changed the way",
                    style: TextStyle(
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
                      OutlinedButton(
                        onPressed: () {
                          context.push("/group/chat");
                        },
                        child: const Text("Join"),
                      ),
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
