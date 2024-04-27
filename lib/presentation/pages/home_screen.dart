import 'package:flutter/material.dart';
import 'package:sondya_app/presentation/features/home/home_body.dart';
import 'package:sondya_app/presentation/layout/bottom_navigation.dart';
import 'package:sondya_app/presentation/layout/top_bar.dart';
import 'package:sondya_app/presentation/layout/user_drawer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SondyaTopBar(title: "Home", isHome: true),
      drawer: sonyaUserDrawer(context),
      body: const HomeBody(),
      bottomNavigationBar: sondyaBottomNavigationBar(context),
    );
  }
}
