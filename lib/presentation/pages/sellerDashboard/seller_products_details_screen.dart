import 'package:flutter/material.dart';
import 'package:sondya_app/presentation/features/seller/products/seller_products_details_body.dart';
import 'package:sondya_app/presentation/layout/bottom_navigation.dart';
import 'package:sondya_app/presentation/layout/top_bar.dart';
import 'package:sondya_app/presentation/layout/user_drawer.dart';

class SellerProductsDetailsScreen extends StatelessWidget {
  final String id;
  const SellerProductsDetailsScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SondyaTopBar(title: "Product Details", isHome: false),
      drawer: sonyaUserDrawer(context),
      body: const SellerProductsDetailsBody(),
      bottomNavigationBar: sondyaBottomNavigationBar(context),
    );
  }
}
