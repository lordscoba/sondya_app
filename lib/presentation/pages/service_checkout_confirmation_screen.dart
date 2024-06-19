import 'package:flutter/material.dart';
import 'package:sondya_app/presentation/features/service_checkout/service_checkout_confirmation_body.dart';
import 'package:sondya_app/presentation/layout/bottom_navigation.dart';
import 'package:sondya_app/presentation/layout/top_bar.dart';
import 'package:sondya_app/presentation/layout/user_drawer.dart';

class ServiceCheckoutConfirmationScreen extends StatelessWidget {
  const ServiceCheckoutConfirmationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SondyaTopBar(title: "Confirmation", isHome: true),
      drawer: sonyaUserDrawer(context),
      body: const ServiceCheckoutConfirmationBody(),
      bottomNavigationBar: sondyaBottomNavigationBar(context),
    );
  }
}
