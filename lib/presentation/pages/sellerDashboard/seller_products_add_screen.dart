import 'package:flutter/material.dart';
import 'package:sondya_app/presentation/features/seller/products/seller_products_add_body.dart';
import 'package:sondya_app/presentation/layout/bottom_navigation.dart';
import 'package:sondya_app/presentation/layout/top_bar.dart';
import 'package:sondya_app/presentation/layout/user_drawer.dart';

class SellerProductsAddScreen extends StatelessWidget {
  const SellerProductsAddScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SondyaTopBar(title: "Add Product", isHome: false),
      drawer: sonyaUserDrawer(context),
      body: const SellerProductsAddBody(),
      bottomNavigationBar: sondyaBottomNavigationBar(context),
    );
  }
}
