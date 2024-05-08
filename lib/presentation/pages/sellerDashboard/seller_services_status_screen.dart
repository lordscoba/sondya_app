import 'package:flutter/material.dart';
import 'package:sondya_app/presentation/features/seller/services/seller_services_status_body.dart';
import 'package:sondya_app/presentation/layout/bottom_navigation.dart';
import 'package:sondya_app/presentation/layout/top_bar.dart';
import 'package:sondya_app/presentation/layout/user_drawer.dart';

class SellerServicesStatusScreen extends StatelessWidget {
  const SellerServicesStatusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SondyaTopBar(title: "Service Status", isHome: false),
      drawer: sonyaUserDrawer(context),
      body: const SellerServicesStatusBody(),
      bottomNavigationBar: sondyaBottomNavigationBar(context),
    );
  }
}
