import 'package:flutter/material.dart';
import 'package:sondya_app/presentation/features/service_checkout/service_checkout_confirmation_body.dart';
import 'package:sondya_app/presentation/layout/bottom_navigation.dart';
import 'package:sondya_app/presentation/layout/top_bar.dart';
import 'package:sondya_app/presentation/layout/user_drawer.dart';

class ServiceCheckoutConfirmationScreen extends StatelessWidget {
  final Map<String, dynamic> data;
  const ServiceCheckoutConfirmationScreen({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SondyaTopBar(title: "Confirmation", isHome: true),
      drawer: sonyaUserDrawer(context),
      body: ServiceCheckoutConfirmationBody(
        data: data,
      ),
      bottomNavigationBar: sondyaBottomNavigationBar(context),
    );
  }
}
