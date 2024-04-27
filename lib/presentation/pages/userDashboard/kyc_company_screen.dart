import 'package:flutter/material.dart';
import 'package:sondya_app/presentation/features/user/kyc/kyc_company_body.dart';
import 'package:sondya_app/presentation/layout/bottom_navigation.dart';
import 'package:sondya_app/presentation/layout/top_bar.dart';
import 'package:sondya_app/presentation/layout/user_drawer.dart';

class KycCompanyInformationScreen extends StatelessWidget {
  const KycCompanyInformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SondyaTopBar(title: "Company Information", isHome: false),
      drawer: sonyaUserDrawer(context),
      body: const KycCompanyInformationBody(),
      bottomNavigationBar: sondyaBottomNavigationBar(context),
    );
  }
}
