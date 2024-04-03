import 'package:flutter/material.dart';
import 'package:sondya_app/presentation/features/user/kyc/kyc_code_body.dart';
import 'package:sondya_app/presentation/layout/bottom_navigation.dart';
import 'package:sondya_app/presentation/layout/top_bar.dart';
import 'package:sondya_app/presentation/layout/user_drawer.dart';

class KycCodeScreenVerification extends StatelessWidget {
  const KycCodeScreenVerification({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SondyaTopBar(title: "Code Verification", isHome: false),
      drawer: sonyaUserDrawer,
      body: const KycCodeVerificationBody(),
      bottomNavigationBar: sondyaBottomNavigationBar(context),
    );
  }
}
