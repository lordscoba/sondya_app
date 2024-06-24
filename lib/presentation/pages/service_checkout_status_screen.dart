import 'package:flutter/material.dart';
import 'package:sondya_app/presentation/features/service_checkout/service_checkout_status_body.dart';
import 'package:sondya_app/presentation/layout/bottom_navigation.dart';
import 'package:sondya_app/presentation/layout/top_bar.dart';
import 'package:sondya_app/presentation/layout/user_drawer.dart';

class ServiceCheckoutStatusScreen extends StatelessWidget {
  final Map<String, dynamic> data;
  const ServiceCheckoutStatusScreen({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SondyaTopBar(title: "Checkout Status", isHome: true),
      drawer: sonyaUserDrawer(context),
      body: ServiceCheckoutStatusBody(
        data: data,
      ),
      bottomNavigationBar: sondyaBottomNavigationBar(context),
    );
  }
}
