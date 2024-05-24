import 'package:flutter/material.dart';
import 'package:sondya_app/presentation/features/seller/products/seller_products_body.dart';
import 'package:sondya_app/presentation/layout/seller_bottom_navigation.dart';
import 'package:sondya_app/presentation/layout/seller_drawer.dart';
import 'package:sondya_app/presentation/layout/top_bar.dart';

class SellerProductsScreen extends StatelessWidget {
  const SellerProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SondyaTopBar(title: "Seller Products", isHome: false),
      drawer: sonyaSellerDrawer(context),
      body: const SellerProductsBody(),
      bottomNavigationBar: sondyaSellerBottomNavigationBar(context),
    );
  }
}
