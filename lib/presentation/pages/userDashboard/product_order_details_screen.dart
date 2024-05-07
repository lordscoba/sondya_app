import 'package:flutter/material.dart';
import 'package:sondya_app/presentation/features/user/order/product_order_details_body.dart';
import 'package:sondya_app/presentation/layout/bottom_navigation.dart';
import 'package:sondya_app/presentation/layout/top_bar.dart';
import 'package:sondya_app/presentation/layout/user_drawer.dart';

class ProductOrderDetailsScreen extends StatelessWidget {
  const ProductOrderDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SondyaTopBar(title: "Order Details", isHome: false),
      drawer: sonyaUserDrawer(context),
      body: const ProductOrderDetailsBody(),
      bottomNavigationBar: sondyaBottomNavigationBar(context),
    );
  }
}
