import 'package:flutter/material.dart';
import 'package:sondya_app/presentation/features/seller/withdrawals/seller_withdrawal_details_body.dart';
import 'package:sondya_app/presentation/layout/seller_bottom_navigation.dart';
import 'package:sondya_app/presentation/layout/seller_drawer.dart';
import 'package:sondya_app/presentation/layout/top_bar.dart';

class SellerWithdrawalDetailsScreen extends StatelessWidget {
  final String id;
  const SellerWithdrawalDetailsScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SondyaTopBar(title: "Details", isHome: false),
      drawer: sonyaSellerDrawer(context),
      body: SellerWithdrawalDetailsBody(
        id: id,
      ),
      bottomNavigationBar: sondyaSellerBottomNavigationBar(context),
    );
  }
}
