import 'package:flutter/material.dart';
import 'package:sondya_app/presentation/features/user/order/product_order_updateterms_body.dart';
import 'package:sondya_app/presentation/layout/bottom_navigation.dart';
import 'package:sondya_app/presentation/layout/top_bar.dart';
import 'package:sondya_app/presentation/layout/user_drawer.dart';

class UserOrderReviewTermsScreen extends StatelessWidget {
  final String id;
  const UserOrderReviewTermsScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SondyaTopBar(title: "Review Terms", isHome: false),
      drawer: sonyaUserDrawer(context),
      body: UserOrderReviewTermsBody(
        id: id,
      ),
      bottomNavigationBar: sondyaBottomNavigationBar(context),
    );
  }
}
