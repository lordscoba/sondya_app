import 'package:flutter/material.dart';
import 'package:sondya_app/presentation/features/seller/services/seller_services_add_body.dart';
import 'package:sondya_app/presentation/layout/seller_bottom_navigation.dart';
import 'package:sondya_app/presentation/layout/seller_drawer.dart';
import 'package:sondya_app/presentation/layout/top_bar.dart';

class SellerServicesAddScreen extends StatelessWidget {
  const SellerServicesAddScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SondyaTopBar(title: "Add Service", isHome: false),
      drawer: sonyaSellerDrawer(context),
      body: const SellerServicesAddBody(),
      bottomNavigationBar: sondyaSellerBottomNavigationBar(context),
    );
  }
}
