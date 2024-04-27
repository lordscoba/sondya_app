import 'package:flutter/material.dart';
import 'package:sondya_app/presentation/features/service_details/service_details_body.dart';
import 'package:sondya_app/presentation/layout/bottom_navigation.dart';
import 'package:sondya_app/presentation/layout/top_bar.dart';
import 'package:sondya_app/presentation/layout/user_drawer.dart';

class ServiceDetailsScreen extends StatelessWidget {
  final String id;
  final String name;
  const ServiceDetailsScreen({super.key, required this.id, required this.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SondyaTopBar(title: "Service Details", isHome: false),
      drawer: sonyaUserDrawer(context),
      body: ServiceDetailsBody(
        id: id,
        name: name,
      ),
      bottomNavigationBar: sondyaBottomNavigationBar(context),
    );
  }
}
