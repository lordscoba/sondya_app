import 'package:flutter/material.dart';
import 'package:sondya_app/presentation/features/seller/services/seller_services_edit_body.dart';
import 'package:sondya_app/presentation/layout/seller_bottom_navigation.dart';
import 'package:sondya_app/presentation/layout/seller_drawer.dart';
import 'package:sondya_app/presentation/layout/top_bar.dart';

class SellerServicesEditScreen extends StatelessWidget {
  final String id;
  const SellerServicesEditScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SondyaTopBar(title: "Edit Service", isHome: false),
      drawer: sonyaSellerDrawer(context),
      body: SellerServicesEditBody(
        id: id,
      ),
      bottomNavigationBar: sondyaSellerBottomNavigationBar(context),
    );
  }
}
