import 'package:flutter/material.dart';
import 'package:sondya_app/presentation/features/seller/product_order/seller_order_update_location_body.dart';
import 'package:sondya_app/presentation/layout/bottom_navigation.dart';
import 'package:sondya_app/presentation/layout/top_bar.dart';
import 'package:sondya_app/presentation/layout/user_drawer.dart';

class SellerOrderUpdateLocationScreen extends StatelessWidget {
  const SellerOrderUpdateLocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SondyaTopBar(title: "Update Location", isHome: false),
      drawer: sonyaUserDrawer(context),
      body: const SellerOrderUpdateLocationBody(),
      bottomNavigationBar: sondyaBottomNavigationBar(context),
    );
  }
}
