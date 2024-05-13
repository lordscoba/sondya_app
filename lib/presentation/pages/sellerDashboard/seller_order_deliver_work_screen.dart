import 'package:flutter/material.dart';
import 'package:sondya_app/presentation/features/seller/services_order/seller_order_deliver_work_body.dart';
import 'package:sondya_app/presentation/layout/bottom_navigation.dart';
import 'package:sondya_app/presentation/layout/top_bar.dart';
import 'package:sondya_app/presentation/layout/user_drawer.dart';

class SellerOrderDeliverWorkScreen extends StatelessWidget {
  const SellerOrderDeliverWorkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SondyaTopBar(title: "Deliver Work", isHome: false),
      drawer: sonyaUserDrawer(context),
      body: const SellerOrderDeliverWorkBody(),
      bottomNavigationBar: sondyaBottomNavigationBar(context),
    );
  }
}
