import 'package:flutter/material.dart';
import 'package:sondya_app/presentation/features/user/inbox/inbox_chat_body.dart';
import 'package:sondya_app/presentation/layout/bottom_navigation.dart';
import 'package:sondya_app/presentation/layout/top_bar.dart';
import 'package:sondya_app/presentation/layout/user_drawer.dart';

class InboxChatScreen extends StatelessWidget {
  final String chatId;
  final String userId;
  final Map<String, dynamic> data;
  const InboxChatScreen(
      {super.key,
      required this.chatId,
      required this.userId,
      required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SondyaTopBar(title: "Inbox Chat", isHome: false),
      drawer: sonyaUserDrawer(context),
      body: InboxChatBody(
        chatId: chatId,
        userId: userId,
        data: data,
      ),
      bottomNavigationBar: sondyaBottomNavigationBar(context),
    );
  }
}
