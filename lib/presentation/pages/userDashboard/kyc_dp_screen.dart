import 'package:flutter/material.dart';
import 'package:sondya_app/presentation/features/user/kyc/kyc_pics_body.dart';
import 'package:sondya_app/presentation/layout/bottom_navigation.dart';
import 'package:sondya_app/presentation/layout/top_bar.dart';
import 'package:sondya_app/presentation/layout/user_drawer.dart';

class KycProfilePicsScreen extends StatelessWidget {
  const KycProfilePicsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SondyaTopBar(title: "Profile Pics", isHome: false),
      drawer: sonyaUserDrawer(context),
      body: const KycProfilePicsBody(),
      bottomNavigationBar: sondyaBottomNavigationBar(context),
    );
  }
}
