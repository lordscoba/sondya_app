import 'package:flutter/material.dart';
import 'package:sondya_app/presentation/features/seller/products/seller_products_add_body.dart';
import 'package:sondya_app/presentation/layout/seller_bottom_navigation.dart';
import 'package:sondya_app/presentation/layout/seller_drawer.dart';
import 'package:sondya_app/presentation/layout/top_bar.dart';

class SellerProductsAddScreen extends StatelessWidget {
  const SellerProductsAddScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SondyaTopBar(title: "Add Product", isHome: false),
      drawer: sonyaSellerDrawer(context),
      body: const SellerProductsAddBody(),
      bottomNavigationBar: sondyaSellerBottomNavigationBar(context),
    );
  }
}
