import 'package:flutter/material.dart';
import 'package:sondya_app/presentation/features/user/track/track_order_details_body.dart';
import 'package:sondya_app/presentation/layout/bottom_navigation.dart';
import 'package:sondya_app/presentation/layout/top_bar.dart';
import 'package:sondya_app/presentation/layout/user_drawer.dart';

class TrackOrderDetailsScreen extends StatelessWidget {
  final String id;
  const TrackOrderDetailsScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SondyaTopBar(title: "Track Details", isHome: false),
      drawer: sonyaUserDrawer(context),
      body: const TrackOrderDetailsBody(),
      bottomNavigationBar: sondyaBottomNavigationBar(context),
    );
  }
}
