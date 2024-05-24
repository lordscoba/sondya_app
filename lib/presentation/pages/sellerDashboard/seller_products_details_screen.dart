import 'package:flutter/material.dart';
import 'package:sondya_app/presentation/features/seller/products/seller_products_details_body.dart';
import 'package:sondya_app/presentation/layout/seller_bottom_navigation.dart';
import 'package:sondya_app/presentation/layout/seller_drawer.dart';
import 'package:sondya_app/presentation/layout/top_bar.dart';

class SellerProductsDetailsScreen extends StatelessWidget {
  final String id;
  final Map<String, dynamic> data;
  const SellerProductsDetailsScreen(
      {super.key, required this.id, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SondyaTopBar(title: "Product Details", isHome: false),
      drawer: sonyaSellerDrawer(context),
      body: SellerProductsDetailsBody(
        data: data,
      ),
      bottomNavigationBar: sondyaSellerBottomNavigationBar(context),
    );
  }
}
