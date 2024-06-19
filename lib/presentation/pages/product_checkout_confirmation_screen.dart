import 'package:flutter/material.dart';
import 'package:sondya_app/presentation/features/product_checkout/product_checkout_confirmation_body.dart';
import 'package:sondya_app/presentation/layout/bottom_navigation.dart';
import 'package:sondya_app/presentation/layout/top_bar.dart';
import 'package:sondya_app/presentation/layout/user_drawer.dart';

class ProductCheckoutConfirmationScreen extends StatelessWidget {
  const ProductCheckoutConfirmationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SondyaTopBar(title: "Confirmation", isHome: true),
      drawer: sonyaUserDrawer(context),
      body: const ProductCheckoutConfirmationBody(),
      bottomNavigationBar: sondyaBottomNavigationBar(context),
    );
  }
}
