import 'package:flutter/material.dart';
import 'package:sondya_app/presentation/features/seller/products/seller_products_status_body.dart';
import 'package:sondya_app/presentation/layout/bottom_navigation.dart';
import 'package:sondya_app/presentation/layout/top_bar.dart';
import 'package:sondya_app/presentation/layout/user_drawer.dart';

class SellerProductsStatusScreen extends StatelessWidget {
  const SellerProductsStatusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SondyaTopBar(title: "Status", isHome: false),
      drawer: sonyaUserDrawer(context),
      body: const SellerProductsStatusBody(),
      bottomNavigationBar: sondyaBottomNavigationBar(context),
    );
  }
}
