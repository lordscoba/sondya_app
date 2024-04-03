import 'package:flutter/material.dart';
import 'package:sondya_app/presentation/features/user/settings/referral_page_body.dart';
import 'package:sondya_app/presentation/layout/bottom_navigation.dart';
import 'package:sondya_app/presentation/layout/top_bar.dart';
import 'package:sondya_app/presentation/layout/user_drawer.dart';

class ReferralPageScreen extends StatelessWidget {
  const ReferralPageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SondyaTopBar(title: "Referral", isHome: false),
      drawer: sonyaUserDrawer,
      body: const ReferralPageBody(),
      bottomNavigationBar: sondyaBottomNavigationBar(context),
    );
  }
}
