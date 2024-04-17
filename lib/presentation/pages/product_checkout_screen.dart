import 'package:flutter/material.dart';
import 'package:sondya_app/presentation/features/product_checkout/product_checkout_body.dart';
import 'package:sondya_app/presentation/layout/bottom_navigation.dart';
import 'package:sondya_app/presentation/layout/top_bar.dart';
import 'package:sondya_app/presentation/layout/user_drawer.dart';

class ProductCheckoutScreen extends StatelessWidget {
  const ProductCheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SondyaTopBar(title: "Product Checkout", isHome: true),
      drawer: sonyaUserDrawer,
      body: const ProductCheckoutBody(),
      bottomNavigationBar: sondyaBottomNavigationBar(context),
    );
  }
}
