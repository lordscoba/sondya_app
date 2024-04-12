import 'package:flutter/material.dart';
import 'package:sondya_app/presentation/features/user/kyc/kyc_contact_info_body.dart';
import 'package:sondya_app/presentation/layout/bottom_navigation.dart';
import 'package:sondya_app/presentation/layout/top_bar.dart';
import 'package:sondya_app/presentation/layout/user_drawer.dart';

class KycContactInfoScreen extends StatelessWidget {
  const KycContactInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SondyaTopBar(title: "Contact Information", isHome: false),
      drawer: sonyaUserDrawer,
      body: const KycContactInfoBody(),
      bottomNavigationBar: sondyaBottomNavigationBar(context),
    );
  }
}
