import 'package:flutter/material.dart';
import 'package:sondya_app/presentation/features/seller/services/seller_services_details_body.dart';
import 'package:sondya_app/presentation/layout/bottom_navigation.dart';
import 'package:sondya_app/presentation/layout/top_bar.dart';
import 'package:sondya_app/presentation/layout/user_drawer.dart';

class SellerServicesDetailsScreen extends StatelessWidget {
  final String id;
  final Map<String, dynamic> data;
  const SellerServicesDetailsScreen(
      {super.key, required this.id, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SondyaTopBar(title: "Service Details", isHome: false),
      drawer: sonyaUserDrawer(context),
      body: SellerServicesDetailsBody(
        data: data,
      ),
      bottomNavigationBar: sondyaBottomNavigationBar(context),
    );
  }
}
