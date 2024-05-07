import 'package:flutter/material.dart';
import 'package:sondya_app/presentation/features/user/track/track_order_body.dart';
import 'package:sondya_app/presentation/layout/bottom_navigation.dart';
import 'package:sondya_app/presentation/layout/top_bar.dart';
import 'package:sondya_app/presentation/layout/user_drawer.dart';

class TrackOrderScreen extends StatelessWidget {
  const TrackOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SondyaTopBar(title: "Track Order", isHome: false),
      drawer: sonyaUserDrawer(context),
      body: const TrackOrderBody(),
      bottomNavigationBar: sondyaBottomNavigationBar(context),
    );
  }
}
