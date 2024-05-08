import 'package:flutter/material.dart';
import 'package:sondya_app/presentation/features/seller/services/seller_services_edit_body.dart';
import 'package:sondya_app/presentation/layout/bottom_navigation.dart';
import 'package:sondya_app/presentation/layout/top_bar.dart';
import 'package:sondya_app/presentation/layout/user_drawer.dart';

class SellerServicesEditScreen extends StatelessWidget {
  const SellerServicesEditScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SondyaTopBar(title: "Edit Service", isHome: false),
      drawer: sonyaUserDrawer(context),
      body: const SellerServicesEditBody(),
      bottomNavigationBar: sondyaBottomNavigationBar(context),
    );
  }
}
