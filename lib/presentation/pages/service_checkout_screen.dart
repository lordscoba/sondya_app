import 'package:flutter/material.dart';
import 'package:sondya_app/presentation/features/service_checkout/service_checkout_body.dart';
import 'package:sondya_app/presentation/layout/bottom_navigation.dart';
import 'package:sondya_app/presentation/layout/top_bar.dart';
import 'package:sondya_app/presentation/layout/user_drawer.dart';

class ServiceCheckoutScreen extends StatelessWidget {
  final String sellerId;
  final String serviceId;
  const ServiceCheckoutScreen(
      {super.key, required this.sellerId, required this.serviceId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SondyaTopBar(title: "Service Checkout", isHome: true),
      drawer: sonyaUserDrawer(context),
      body: ServiceCheckoutBody(
        sellerId: sellerId,
        serviceId: serviceId,
      ),
      bottomNavigationBar: sondyaBottomNavigationBar(context),
    );
  }
}
