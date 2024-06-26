import 'package:flutter/material.dart';
import 'package:sondya_app/presentation/features/user/settings/settings_body.dart';
import 'package:sondya_app/presentation/layout/bottom_navigation.dart';
import 'package:sondya_app/presentation/layout/seller_bottom_navigation.dart';
import 'package:sondya_app/presentation/layout/top_bar.dart';
import 'package:sondya_app/presentation/layout/user_drawer.dart';
import 'package:sondya_app/utils/is_seller.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SondyaTopBar(title: "Settings", isHome: false),
      drawer: sonyaUserDrawer(context),
      body: const SettingsBody(),
      bottomNavigationBar: isSellerSession()
          ? sondyaSellerBottomNavigationBar(context)
          : sondyaBottomNavigationBar(context),
    );
  }
}
