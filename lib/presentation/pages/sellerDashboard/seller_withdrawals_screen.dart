import 'package:flutter/material.dart';
import 'package:sondya_app/presentation/features/seller/withdrawals/seller_withdrawals_body.dart';
import 'package:sondya_app/presentation/layout/bottom_navigation.dart';
import 'package:sondya_app/presentation/layout/top_bar.dart';
import 'package:sondya_app/presentation/layout/user_drawer.dart';

class SellerWithdrawalsScreen extends StatelessWidget {
  const SellerWithdrawalsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SondyaTopBar(title: "Withdrawals", isHome: false),
      drawer: sonyaUserDrawer(context),
      body: const SellerWithdrawalsBody(),
      bottomNavigationBar: sondyaBottomNavigationBar(context),
    );
  }
}
