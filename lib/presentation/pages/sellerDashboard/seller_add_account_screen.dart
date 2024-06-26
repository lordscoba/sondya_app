import 'package:flutter/material.dart';
import 'package:sondya_app/presentation/features/seller/withdrawals/seller_add_account_body.dart';
import 'package:sondya_app/presentation/layout/seller_bottom_navigation.dart';
import 'package:sondya_app/presentation/layout/seller_drawer.dart';
import 'package:sondya_app/presentation/layout/top_bar.dart';

class SellerAddAccountScreen extends StatelessWidget {
  const SellerAddAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SondyaTopBar(title: "Add Account", isHome: false),
      drawer: sonyaSellerDrawer(context),
      body: const SellerAddAccountBody(),
      bottomNavigationBar: sondyaSellerBottomNavigationBar(context),
    );
  }
}
