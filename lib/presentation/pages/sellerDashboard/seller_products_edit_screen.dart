import 'package:flutter/material.dart';
import 'package:sondya_app/presentation/features/seller/products/seller_products_edit_body.dart';
import 'package:sondya_app/presentation/layout/seller_bottom_navigation.dart';
import 'package:sondya_app/presentation/layout/seller_drawer.dart';
import 'package:sondya_app/presentation/layout/top_bar.dart';

class SellerProductsEditScreen extends StatelessWidget {
  final String id;
  const SellerProductsEditScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SondyaTopBar(title: "Edit Product", isHome: false),
      drawer: sonyaSellerDrawer(context),
      body: SellerProductsEditBody(
        id: id,
      ),
      bottomNavigationBar: sondyaSellerBottomNavigationBar(context),
    );
  }
}
