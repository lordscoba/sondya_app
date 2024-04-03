import 'package:flutter/material.dart';
import 'package:sondya_app/presentation/features/user/inbox/inbox_body.dart';
import 'package:sondya_app/presentation/layout/bottom_navigation.dart';
import 'package:sondya_app/presentation/layout/top_bar.dart';
import 'package:sondya_app/presentation/layout/user_drawer.dart';

class InboxScreen extends StatelessWidget {
  const InboxScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SondyaTopBar(title: "Inbox", isHome: false),
      drawer: sonyaUserDrawer,
      body: const InboxBody(),
      bottomNavigationBar: sondyaBottomNavigationBar(context),
    );
  }
}
