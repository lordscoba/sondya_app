import 'package:flutter/material.dart';
import 'package:sondya_app/presentation/features/seller/withdrawals/seller_add_account_body.dart';
import 'package:sondya_app/presentation/layout/bottom_navigation.dart';
import 'package:sondya_app/presentation/layout/top_bar.dart';
import 'package:sondya_app/presentation/layout/user_drawer.dart';

class SellerAddAccountScreen extends StatelessWidget {
  const SellerAddAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SondyaTopBar(title: "Add Account", isHome: false),
      drawer: sonyaUserDrawer(context),
      body: const SellerAddAccountBody(),
      bottomNavigationBar: sondyaBottomNavigationBar(context),
    );
  }
}
