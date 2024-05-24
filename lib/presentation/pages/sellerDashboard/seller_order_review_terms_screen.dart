import 'package:flutter/material.dart';
import 'package:sondya_app/presentation/features/seller/services_order/seller_order_review_terms_body.dart';
import 'package:sondya_app/presentation/layout/seller_bottom_navigation.dart';
import 'package:sondya_app/presentation/layout/seller_drawer.dart';
import 'package:sondya_app/presentation/layout/top_bar.dart';

class SellerOrderReviewTermsScreen extends StatelessWidget {
  final String id;
  const SellerOrderReviewTermsScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SondyaTopBar(title: "Review Terms", isHome: false),
      drawer: sonyaSellerDrawer(context),
      body: SellerOrderReviewTermsBody(
        id: id,
      ),
      bottomNavigationBar: sondyaSellerBottomNavigationBar(context),
    );
  }
}
