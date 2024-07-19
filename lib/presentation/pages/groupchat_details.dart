import 'package:flutter/material.dart';
import 'package:sondya_app/presentation/features/groupchat/groupchat_details_body.dart';
import 'package:sondya_app/presentation/layout/bottom_navigation.dart';
import 'package:sondya_app/presentation/layout/top_bar.dart';
import 'package:sondya_app/presentation/layout/user_drawer.dart';

class GroupChatDetailsScreen extends StatelessWidget {
  final String groupId;
  const GroupChatDetailsScreen({super.key, required this.groupId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SondyaTopBar(title: "Details", isHome: false),
      drawer: sonyaUserDrawer(context),
      body: GroupChatDetailsBody(
        groupId: groupId,
      ),
      bottomNavigationBar: sondyaBottomNavigationBar(context),
    );
  }
}
