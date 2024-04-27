import 'package:flutter/material.dart';
import 'package:sondya_app/presentation/features/user/kyc/kyc_document_body.dart';
import 'package:sondya_app/presentation/layout/bottom_navigation.dart';
import 'package:sondya_app/presentation/layout/top_bar.dart';
import 'package:sondya_app/presentation/layout/user_drawer.dart';

class KycDocumentUploadScreen extends StatelessWidget {
  const KycDocumentUploadScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SondyaTopBar(title: "Document Upload", isHome: false),
      drawer: sonyaUserDrawer(context),
      body: const KycDocumentUploadBody(),
      bottomNavigationBar: sondyaBottomNavigationBar(context),
    );
  }
}
