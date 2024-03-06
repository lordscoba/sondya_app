import 'package:flutter/material.dart';
import 'package:sondya_app/presentation/features/service_search/service_search_body.dart';
import 'package:sondya_app/presentation/layout/bottom_navigation.dart';
import 'package:sondya_app/presentation/layout/top_bar.dart';
import 'package:sondya_app/presentation/layout/user_drawer.dart';

class ServiceSearchScreen extends StatelessWidget {
  const ServiceSearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SondyaTopBar(title: "Service Search", isHome: false),
      drawer: sonyaUserDrawer,
      body: const ServiceSearchBody(),
      bottomNavigationBar: sondyaBottomNavigationBar(context),
    );
  }
}
