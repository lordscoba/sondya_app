import 'package:flutter/material.dart';
import 'package:sondya_app/presentation/features/notifications/notifications_body.dart';
import 'package:sondya_app/presentation/layout/bottom_navigation.dart';
import 'package:sondya_app/presentation/layout/top_bar.dart';
import 'package:sondya_app/presentation/layout/user_drawer.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SondyaTopBar(title: "Notifications", isHome: true),
      drawer: sonyaUserDrawer(context),
      body: const NotificationsBody(),
      bottomNavigationBar: sondyaBottomNavigationBar(context),
    );
  }
}
