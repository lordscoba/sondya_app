import 'package:flutter/material.dart';
import 'package:sondya_app/presentation/features/groupchat/groupchat_body.dart';
import 'package:sondya_app/presentation/layout/bottom_navigation.dart';
import 'package:sondya_app/presentation/layout/top_bar.dart';
import 'package:sondya_app/presentation/layout/user_drawer.dart';

class GroupChatScreen extends StatelessWidget {
  final String groupId;
  const GroupChatScreen({super.key, required this.groupId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SondyaTopBar(title: "Group Chat", isHome: false),
      drawer: sonyaUserDrawer(context),
      body: GroupChatBody(
        groupId: groupId,
      ),
      bottomNavigationBar: sondyaBottomNavigationBar(context),
    );
  }
}
