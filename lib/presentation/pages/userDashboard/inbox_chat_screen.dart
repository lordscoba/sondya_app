import 'package:flutter/material.dart';
import 'package:sondya_app/presentation/features/user/inbox/inbox_chat_body.dart';
import 'package:sondya_app/presentation/layout/bottom_navigation.dart';
import 'package:sondya_app/presentation/layout/top_bar.dart';
import 'package:sondya_app/presentation/layout/user_drawer.dart';

class InboxChatScreen extends StatelessWidget {
  const InboxChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SondyaTopBar(title: "Inbox Chat", isHome: false),
      drawer: sonyaUserDrawer(context),
      body: const InboxChatBody(),
      bottomNavigationBar: sondyaBottomNavigationBar(context),
    );
  }
}
