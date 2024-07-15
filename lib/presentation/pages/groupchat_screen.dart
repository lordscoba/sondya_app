import 'package:flutter/material.dart';
import 'package:sondya_app/presentation/features/groupchat/groupchat_body.dart';
import 'package:sondya_app/presentation/layout/bottom_navigation.dart';
import 'package:sondya_app/presentation/layout/top_bar.dart';
import 'package:sondya_app/presentation/layout/user_drawer.dart';

class GroupChatScreen extends StatelessWidget {
  const GroupChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SondyaTopBar(title: "Group Chat", isHome: false),
      drawer: sonyaUserDrawer(context),
      body: const GroupChatBody(),
      bottomNavigationBar: sondyaBottomNavigationBar(context),
    );
  }
}
