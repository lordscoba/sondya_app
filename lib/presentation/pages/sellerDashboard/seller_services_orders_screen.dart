import 'package:flutter/material.dart';
import 'package:sondya_app/presentation/features/seller/services_order/seller_service_orders_body.dart';
import 'package:sondya_app/presentation/layout/seller_bottom_navigation.dart';
import 'package:sondya_app/presentation/layout/seller_drawer.dart';
import 'package:sondya_app/presentation/layout/top_bar.dart';

class SellerServicesOrdersScreen extends StatelessWidget {
  const SellerServicesOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SondyaTopBar(title: "Service Orders", isHome: false),
      drawer: sonyaSellerDrawer(context),
      body: const SellerServiceOrdersBody(),
      bottomNavigationBar: sondyaSellerBottomNavigationBar(context),
    );
  }
}
