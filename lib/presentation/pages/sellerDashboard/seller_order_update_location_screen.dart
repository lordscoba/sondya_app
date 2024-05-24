import 'package:flutter/material.dart';
import 'package:sondya_app/presentation/features/seller/product_order/seller_order_update_location_body.dart';
import 'package:sondya_app/presentation/layout/seller_bottom_navigation.dart';
import 'package:sondya_app/presentation/layout/seller_drawer.dart';
import 'package:sondya_app/presentation/layout/top_bar.dart';

class SellerOrderUpdateLocationScreen extends StatelessWidget {
  final String id;
  const SellerOrderUpdateLocationScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SondyaTopBar(title: "Update Location", isHome: false),
      drawer: sonyaSellerDrawer(context),
      body: SellerOrderUpdateLocationBody(id: id),
      bottomNavigationBar: sondyaSellerBottomNavigationBar(context),
    );
  }
}
