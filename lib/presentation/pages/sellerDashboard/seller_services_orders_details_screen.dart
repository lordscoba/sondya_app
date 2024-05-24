import 'package:flutter/material.dart';
import 'package:sondya_app/presentation/features/seller/services_order/seller_service_orders_details_body.dart';
import 'package:sondya_app/presentation/layout/seller_bottom_navigation.dart';
import 'package:sondya_app/presentation/layout/seller_drawer.dart';
import 'package:sondya_app/presentation/layout/top_bar.dart';

class SellerServicesOrdersDetailsScreen extends StatelessWidget {
  final String id;
  final Map<String, dynamic> data;
  const SellerServicesOrdersDetailsScreen(
      {super.key, required this.id, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SondyaTopBar(title: "Order Details", isHome: false),
      drawer: sonyaSellerDrawer(context),
      body: SellerServiceOrdersDetailsBody(
        data: data,
      ),
      bottomNavigationBar: sondyaSellerBottomNavigationBar(context),
    );
  }
}
