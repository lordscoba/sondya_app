import 'package:flutter/material.dart';
import 'package:sondya_app/presentation/features/seller/services_order/seller_order_deliver_work_body.dart';
import 'package:sondya_app/presentation/layout/seller_bottom_navigation.dart';
import 'package:sondya_app/presentation/layout/seller_drawer.dart';
import 'package:sondya_app/presentation/layout/top_bar.dart';

class SellerOrderDeliverWorkScreen extends StatelessWidget {
  final String id;
  const SellerOrderDeliverWorkScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SondyaTopBar(title: "Deliver Work", isHome: false),
      drawer: sonyaSellerDrawer(context),
      body: SellerOrderDeliverWorkBody(id: id),
      bottomNavigationBar: sondyaSellerBottomNavigationBar(context),
    );
  }
}
