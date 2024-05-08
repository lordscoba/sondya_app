import 'package:flutter/material.dart';
import 'package:sondya_app/presentation/features/seller/services/seller_services_add_body.dart';
import 'package:sondya_app/presentation/layout/bottom_navigation.dart';
import 'package:sondya_app/presentation/layout/top_bar.dart';
import 'package:sondya_app/presentation/layout/user_drawer.dart';

class SellerServicesAddScreen extends StatelessWidget {
  const SellerServicesAddScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SondyaTopBar(title: "Add Service", isHome: false),
      drawer: sonyaUserDrawer(context),
      body: const SellerServicesAddBody(),
      bottomNavigationBar: sondyaBottomNavigationBar(context),
    );
  }
}
