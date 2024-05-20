import 'package:flutter/material.dart';
import 'package:sondya_app/presentation/features/seller/products/seller_products_edit_body.dart';
import 'package:sondya_app/presentation/layout/bottom_navigation.dart';
import 'package:sondya_app/presentation/layout/top_bar.dart';
import 'package:sondya_app/presentation/layout/user_drawer.dart';

class SellerProductsEditScreen extends StatelessWidget {
  final String id;
  final Map<String, dynamic> data;
  const SellerProductsEditScreen(
      {super.key, required this.id, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SondyaTopBar(title: "Edit Product", isHome: false),
      drawer: sonyaUserDrawer(context),
      body: SellerProductsEditBody(
        id: id,
        data: data,
      ),
      bottomNavigationBar: sondyaBottomNavigationBar(context),
    );
  }
}
