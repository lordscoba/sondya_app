import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sondya_app/data/extra_constants.dart';

class GroupChatBody extends StatelessWidget {
  const GroupChatBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10.0),
          height: MediaQuery.of(context).size.height * 0.7,
          child: Column(
            children: [
              context.canPop()
                  ? Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () {
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
              const GroupChatTopRow(),
              const SizedBox(height: 20.0),
              const Expanded(
                child: GroupChatList(),
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

class GroupChatTopRow extends StatelessWidget {
  const GroupChatTopRow({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage(
                'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=facearea&facepad=2&w=256&h=256&q=80',
              ),
            ),
            Positioned(
              left: 20,
              child: CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(
                    "https://media.istockphoto.com/id/1435891660/photo/close-up-view-of-a-young-mans-face-in-the-shadow-eye-in-the-foreground-in-black-and-dark.jpg?s=1024x1024&w=is&k=20&c=EhKb9dBcYz5VHowOJvoObg-FNqC3c0YduWk_4idRy2Y="),
              ),
            ),
            Positioned(
              left: 40,
              child: CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(
                    "https://images.unsplash.com/photo-1720640320081-763dc112f1b1?q=80&w=2670&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"),
              ),
            ),
            Positioned(
              left: 60,
              child: CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(
                  'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=facearea&facepad=2&w=256&h=256&q=80',
                ),
              ),
            ),
            Positioned(
              bottom: 20,
              left: 70,
              child: Text(
                "+20",
                style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        )
      ],
    );
  }
}
