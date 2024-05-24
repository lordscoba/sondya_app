import 'package:flutter/material.dart';
import 'package:sondya_app/presentation/features/seller/product_order/seller_products_order_body.dart';
import 'package:sondya_app/presentation/layout/seller_bottom_navigation.dart';
import 'package:sondya_app/presentation/layout/seller_drawer.dart';
import 'package:sondya_app/presentation/layout/top_bar.dart';

class SellerProductsOrdersScreen extends StatelessWidget {
  const SellerProductsOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SondyaTopBar(title: "Product Orders", isHome: false),
      drawer: sonyaSellerDrawer(context),
      body: const SellerProductsOrderBody(),
      bottomNavigationBar: sondyaSellerBottomNavigationBar(context),
    );
  }
}
