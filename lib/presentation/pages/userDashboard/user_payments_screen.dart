import 'package:flutter/material.dart';
import 'package:sondya_app/presentation/features/user/payments/user_payments_body.dart';
import 'package:sondya_app/presentation/layout/bottom_navigation.dart';
import 'package:sondya_app/presentation/layout/top_bar.dart';
import 'package:sondya_app/presentation/layout/user_drawer.dart';

class UserPaymentsScreen extends StatelessWidget {
  const UserPaymentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SondyaTopBar(title: "Payments", isHome: false),
      drawer: sonyaUserDrawer(context),
      body: const UserPaymentsBody(),
      bottomNavigationBar: sondyaBottomNavigationBar(context),
    );
  }
}
