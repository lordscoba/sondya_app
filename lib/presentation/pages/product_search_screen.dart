import 'package:flutter/material.dart';
import 'package:sondya_app/presentation/features/product_search/product_search_body.dart';
import 'package:sondya_app/presentation/layout/bottom_navigation.dart';
import 'package:sondya_app/presentation/layout/top_bar.dart';
import 'package:sondya_app/presentation/layout/user_drawer.dart';

class ProductSearchScreen extends StatelessWidget {
  const ProductSearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SondyaTopBar(title: "Product Search", isHome: false),
      drawer: sonyaUserDrawer(context),
      body: const ProductSearchBody(),
      bottomNavigationBar: sondyaBottomNavigationBar(context),
    );
  }
}
