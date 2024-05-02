import 'package:flutter/material.dart';
import 'package:sondya_app/presentation/features/product_checkout/checkout_status_body.dart';
import 'package:sondya_app/presentation/layout/bottom_navigation.dart';
import 'package:sondya_app/presentation/layout/top_bar.dart';
import 'package:sondya_app/presentation/layout/user_drawer.dart';

class ProductCheckoutStatusScreen extends StatelessWidget {
  const ProductCheckoutStatusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SondyaTopBar(title: "Checkout Status", isHome: true),
      drawer: sonyaUserDrawer(context),
      body: const ProductCheckoutStatusBody(),
      bottomNavigationBar: sondyaBottomNavigationBar(context),
    );
  }
}
