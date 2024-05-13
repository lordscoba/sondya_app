import 'package:flutter/material.dart';
import 'package:sondya_app/presentation/features/seller/services_order/seller_order_review_terms_body.dart';
import 'package:sondya_app/presentation/layout/bottom_navigation.dart';
import 'package:sondya_app/presentation/layout/top_bar.dart';
import 'package:sondya_app/presentation/layout/user_drawer.dart';

class SellerOrderReviewTermsScreen extends StatelessWidget {
  const SellerOrderReviewTermsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SondyaTopBar(title: "Review Terms", isHome: false),
      drawer: sonyaUserDrawer(context),
      body: const SellerOrderReviewTermsBody(),
      bottomNavigationBar: sondyaBottomNavigationBar(context),
    );
  }
}
