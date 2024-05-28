import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sondya_app/data/local/storedValue.dart';
import 'package:sondya_app/presentation/features/user/inbox/inbox_body.dart';
import 'package:sondya_app/presentation/layout/seller_bottom_navigation.dart';
import 'package:sondya_app/presentation/layout/seller_drawer.dart';
import 'package:sondya_app/presentation/layout/top_bar.dart';

class SellerInboxScreen extends ConsumerWidget {
  const SellerInboxScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final getId = ref.watch(storedAuthValueProvider);
    return Scaffold(
      appBar: const SondyaTopBar(title: "Seller Inbox", isHome: false),
      drawer: sonyaSellerDrawer(context),
      body: getId.when(
        data: (data) {
          return InboxBody(
            userId: data.id,
          );
        },
        error: (error, stackTrace) => Text(error.toString()),
        loading: () => const Center(
          child: Center(
            child: CupertinoActivityIndicator(
              radius: 50,
            ),
          ),
        ),
      ),
      bottomNavigationBar: sondyaSellerBottomNavigationBar(context),
    );
  }
}
