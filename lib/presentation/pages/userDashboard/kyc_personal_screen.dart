import 'package:flutter/material.dart';
import 'package:sondya_app/presentation/features/user/kyc/kyc_personal_body.dart';
import 'package:sondya_app/presentation/layout/bottom_navigation.dart';
import 'package:sondya_app/presentation/layout/top_bar.dart';
import 'package:sondya_app/presentation/layout/user_drawer.dart';

class KycPersonalInformationScreen extends StatelessWidget {
  const KycPersonalInformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SondyaTopBar(title: "Personal Information", isHome: false),
      drawer: sonyaUserDrawer(context),
      body: const KycPersonalInformationBody(),
      bottomNavigationBar: sondyaBottomNavigationBar(context),
    );
  }
}
