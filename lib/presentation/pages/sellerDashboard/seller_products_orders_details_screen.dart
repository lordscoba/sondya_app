import 'package:flutter/material.dart';
import 'package:sondya_app/presentation/features/seller/product_order/seller_products_order_body_details.dart';
import 'package:sondya_app/presentation/layout/bottom_navigation.dart';
import 'package:sondya_app/presentation/layout/top_bar.dart';
import 'package:sondya_app/presentation/layout/user_drawer.dart';

class SellerProductsOrdersDetailsScreen extends StatelessWidget {
  final String id;
  final Map<String, dynamic> data;
  const SellerProductsOrdersDetailsScreen(
      {super.key, required this.id, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SondyaTopBar(title: "Order Details", isHome: false),
      drawer: sonyaUserDrawer(context),
      body: SellerProductsOrderDetailsBody(
        data: data,
      ),
      bottomNavigationBar: sondyaBottomNavigationBar(context),
    );
  }
}
