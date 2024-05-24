import 'package:flutter/material.dart';
import 'package:sondya_app/presentation/features/user/inbox/inbox_body.dart';
import 'package:sondya_app/presentation/layout/seller_bottom_navigation.dart';
import 'package:sondya_app/presentation/layout/seller_drawer.dart';
import 'package:sondya_app/presentation/layout/top_bar.dart';

class SellerInboxScreen extends StatelessWidget {
  const SellerInboxScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SondyaTopBar(title: "Seller Inbox", isHome: false),
      drawer: sonyaSellerDrawer(context),
      body: const InboxBody(),
      bottomNavigationBar: sondyaSellerBottomNavigationBar(context),
    );
  }
}
