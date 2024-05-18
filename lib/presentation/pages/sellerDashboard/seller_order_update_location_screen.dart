import 'package:flutter/material.dart';
import 'package:sondya_app/presentation/features/seller/product_order/seller_order_update_location_body.dart';
import 'package:sondya_app/presentation/layout/bottom_navigation.dart';
import 'package:sondya_app/presentation/layout/top_bar.dart';
import 'package:sondya_app/presentation/layout/user_drawer.dart';

class SellerOrderUpdateLocationScreen extends StatelessWidget {
  final Map<String, dynamic> data;
  final String id;
  const SellerOrderUpdateLocationScreen(
      {super.key, required this.data, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SondyaTopBar(title: "Update Location", isHome: false),
      drawer: sonyaUserDrawer(context),
      body: SellerOrderUpdateLocationBody(data: data),
      bottomNavigationBar: sondyaBottomNavigationBar(context),
    );
  }
}
