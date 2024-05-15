import 'package:flutter/material.dart';
import 'package:sondya_app/presentation/features/seller/services/seller_services_details_body.dart';
import 'package:sondya_app/presentation/layout/bottom_navigation.dart';
import 'package:sondya_app/presentation/layout/top_bar.dart';
import 'package:sondya_app/presentation/layout/user_drawer.dart';

class SellerServicesDetailsScreen extends StatelessWidget {
  final String id;
  const SellerServicesDetailsScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SondyaTopBar(title: "Service Details", isHome: false),
      drawer: sonyaUserDrawer(context),
      body: const SellerServicesDetailsBody(),
      bottomNavigationBar: sondyaBottomNavigationBar(context),
    );
  }
}
