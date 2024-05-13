import 'package:flutter/material.dart';
import 'package:sondya_app/presentation/features/seller/product_order/seller_order_update_status_body.dart';
import 'package:sondya_app/presentation/layout/bottom_navigation.dart';
import 'package:sondya_app/presentation/layout/top_bar.dart';
import 'package:sondya_app/presentation/layout/user_drawer.dart';

class SellerOrderUpdateStatusScreen extends StatelessWidget {
  const SellerOrderUpdateStatusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SondyaTopBar(title: "Update Status", isHome: false),
      drawer: sonyaUserDrawer(context),
      body: const SellerOrderUpdateStatusBody(),
      bottomNavigationBar: sondyaBottomNavigationBar(context),
    );
  }
}
