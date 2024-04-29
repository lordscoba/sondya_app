import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sondya_app/data/local/cart.dart';
import 'package:sondya_app/presentation/features/cart/cart_body.dart';
import 'package:sondya_app/presentation/features/cart/cart_empty.dart';
import 'package:sondya_app/presentation/layout/bottom_navigation.dart';
import 'package:sondya_app/presentation/layout/top_bar.dart';
import 'package:sondya_app/presentation/layout/user_drawer.dart';

class CartScreen extends ConsumerWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // total cart
    int totalCartNum = 0;
    final totalCart = ref.watch(getTotalCartProvider);
    totalCart.whenData((value) {
      totalCartNum = value;
    });
    return Scaffold(
      appBar: const SondyaTopBar(title: "Cart", isHome: true),
      drawer: sonyaUserDrawer(context),
      // body: const CartBody(),
      body: totalCartNum <= 0 ? const CartEmpty() : const CartBody(),
      bottomNavigationBar: sondyaBottomNavigationBar(context),
    );
  }
}
