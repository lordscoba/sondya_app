import 'package:flutter/material.dart';
import 'package:sondya_app/presentation/features/seller/withdrawals/seller_withdraw_body.dart';
import 'package:sondya_app/presentation/layout/seller_bottom_navigation.dart';
import 'package:sondya_app/presentation/layout/seller_drawer.dart';
import 'package:sondya_app/presentation/layout/top_bar.dart';

class SellerWithdrawScreen extends StatelessWidget {
  const SellerWithdrawScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SondyaTopBar(title: "Withdraw", isHome: false),
      drawer: sonyaSellerDrawer(context),
      body: const SellerWithdrawBody(),
      bottomNavigationBar: sondyaSellerBottomNavigationBar(context),
    );
  }
}
