import 'package:flutter/material.dart';
import 'package:sondya_app/presentation/features/product_details/product_details_body.dart';
import 'package:sondya_app/presentation/layout/bottom_navigation.dart';
import 'package:sondya_app/presentation/layout/top_bar.dart';
import 'package:sondya_app/presentation/layout/user_drawer.dart';

class ProductDetailsScreen extends StatelessWidget {
  final String id;
  final String name;
  const ProductDetailsScreen({super.key, required this.id, required this.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SondyaTopBar(title: "Product Details", isHome: false),
      drawer: sonyaUserDrawer,
      body: ProductDetailsBody(
        id: id,
        name: name,
      ),
      bottomNavigationBar: sondyaBottomNavigationBar(context),
    );
  }
}
