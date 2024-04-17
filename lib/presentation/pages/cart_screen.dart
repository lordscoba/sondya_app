import 'package:flutter/material.dart';
import 'package:sondya_app/presentation/features/cart/cart_body.dart';
import 'package:sondya_app/presentation/layout/bottom_navigation.dart';
import 'package:sondya_app/presentation/layout/top_bar.dart';
import 'package:sondya_app/presentation/layout/user_drawer.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SondyaTopBar(title: "Cart", isHome: true),
      drawer: sonyaUserDrawer,
      body: const CartBody(),
      bottomNavigationBar: sondyaBottomNavigationBar(context),
    );
  }
}
