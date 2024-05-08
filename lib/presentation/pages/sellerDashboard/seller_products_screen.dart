import 'package:flutter/material.dart';
import 'package:sondya_app/presentation/features/seller/products/seller_products_body.dart';
import 'package:sondya_app/presentation/layout/bottom_navigation.dart';
import 'package:sondya_app/presentation/layout/top_bar.dart';
import 'package:sondya_app/presentation/layout/user_drawer.dart';

class SellerProductsScreen extends StatelessWidget {
  const SellerProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SondyaTopBar(title: "Seller Products", isHome: false),
      drawer: sonyaUserDrawer(context),
      body: const SellerProductsBody(),
      bottomNavigationBar: sondyaBottomNavigationBar(context),
    );
  }
}
