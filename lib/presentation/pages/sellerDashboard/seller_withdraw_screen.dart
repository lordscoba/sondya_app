import 'package:flutter/material.dart';
import 'package:sondya_app/presentation/features/seller/withdrawals/seller_withdraw_body.dart';
import 'package:sondya_app/presentation/layout/bottom_navigation.dart';
import 'package:sondya_app/presentation/layout/top_bar.dart';
import 'package:sondya_app/presentation/layout/user_drawer.dart';

class SellerWithdrawScreen extends StatelessWidget {
  const SellerWithdrawScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SondyaTopBar(title: "Withdraw", isHome: false),
      drawer: sonyaUserDrawer(context),
      body: const SellerWithdrawBody(),
      bottomNavigationBar: sondyaBottomNavigationBar(context),
    );
  }
}
