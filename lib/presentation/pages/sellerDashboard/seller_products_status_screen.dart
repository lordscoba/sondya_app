import 'package:flutter/material.dart';
import 'package:sondya_app/presentation/features/seller/products/seller_products_status_body.dart';
import 'package:sondya_app/presentation/layout/seller_bottom_navigation.dart';
import 'package:sondya_app/presentation/layout/seller_drawer.dart';
import 'package:sondya_app/presentation/layout/top_bar.dart';

class SellerProductsStatusScreen extends StatelessWidget {
  const SellerProductsStatusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SondyaTopBar(title: "Status", isHome: false),
      drawer: sonyaSellerDrawer(context),
      body: const SellerProductsStatusBody(),
      bottomNavigationBar: sondyaSellerBottomNavigationBar(context),
    );
  }
}
