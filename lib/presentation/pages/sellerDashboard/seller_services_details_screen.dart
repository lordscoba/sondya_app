import 'package:flutter/material.dart';
import 'package:sondya_app/presentation/features/seller/services/seller_services_details_body.dart';
import 'package:sondya_app/presentation/layout/bottom_navigation.dart';
import 'package:sondya_app/presentation/layout/top_bar.dart';
import 'package:sondya_app/presentation/layout/user_drawer.dart';

class SellerServicesDetailsScreen extends StatelessWidget {
  const SellerServicesDetailsScreen({super.key});

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
