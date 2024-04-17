import 'package:flutter/material.dart';
import 'package:sondya_app/presentation/features/wishlist/wishlist_body.dart';
import 'package:sondya_app/presentation/layout/bottom_navigation.dart';
import 'package:sondya_app/presentation/layout/top_bar.dart';
import 'package:sondya_app/presentation/layout/user_drawer.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SondyaTopBar(title: "Wishlist", isHome: true),
      drawer: sonyaUserDrawer,
      body: const WishlistBody(),
      bottomNavigationBar: sondyaBottomNavigationBar(context),
    );
  }
}
