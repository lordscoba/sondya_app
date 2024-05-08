import 'package:flutter/material.dart';
import 'package:sondya_app/presentation/features/seller/product_order/seller_products_order_body.dart';
import 'package:sondya_app/presentation/layout/bottom_navigation.dart';
import 'package:sondya_app/presentation/layout/top_bar.dart';
import 'package:sondya_app/presentation/layout/user_drawer.dart';

class SellerProductsOrdersScreen extends StatelessWidget {
  const SellerProductsOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SondyaTopBar(title: "Product Orders", isHome: false),
      drawer: sonyaUserDrawer(context),
      body: const SellerProductsOrderBody(),
      bottomNavigationBar: sondyaBottomNavigationBar(context),
    );
  }
}
