import 'package:flutter/material.dart';
import 'package:sondya_app/presentation/features/user/payments/user_payments_details_body.dart';
import 'package:sondya_app/presentation/layout/bottom_navigation.dart';
import 'package:sondya_app/presentation/layout/top_bar.dart';
import 'package:sondya_app/presentation/layout/user_drawer.dart';

class UserPaymentDetailsScreen extends StatelessWidget {
  const UserPaymentDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SondyaTopBar(title: "Payments Details", isHome: false),
      drawer: sonyaUserDrawer(context),
      body: const UserPaymentsDetailsBody(),
      bottomNavigationBar: sondyaBottomNavigationBar(context),
    );
  }
}
