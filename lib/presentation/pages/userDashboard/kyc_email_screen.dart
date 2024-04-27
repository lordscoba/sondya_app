import 'package:flutter/material.dart';
import 'package:sondya_app/presentation/features/user/kyc/kyc_email_body.dart';
import 'package:sondya_app/presentation/layout/bottom_navigation.dart';
import 'package:sondya_app/presentation/layout/top_bar.dart';
import 'package:sondya_app/presentation/layout/user_drawer.dart';

class KycEmailVerificationScreen extends StatelessWidget {
  const KycEmailVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SondyaTopBar(title: "Email Verification", isHome: false),
      drawer: sonyaUserDrawer(context),
      body: const KycEmailVerificationBody(),
      bottomNavigationBar: sondyaBottomNavigationBar(context),
    );
  }
}
