import 'package:flutter/material.dart';
import 'package:sondya_app/presentation/features/seller/services/seller_services_body.dart';
import 'package:sondya_app/presentation/layout/seller_bottom_navigation.dart';
import 'package:sondya_app/presentation/layout/seller_drawer.dart';
import 'package:sondya_app/presentation/layout/top_bar.dart';

class SellerServicesScreen extends StatelessWidget {
  const SellerServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SondyaTopBar(title: "Seller Services", isHome: false),
      drawer: sonyaSellerDrawer(context),
      body: const SellerServicesBody(),
      bottomNavigationBar: sondyaSellerBottomNavigationBar(context),
    );
  }
}
