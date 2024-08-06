import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sondya_app/data/local/storedValue.dart';
import 'package:sondya_app/presentation/features/groupchat/groupchat_details_body.dart';
import 'package:sondya_app/presentation/layout/bottom_navigation.dart';
import 'package:sondya_app/presentation/layout/top_bar.dart';
import 'package:sondya_app/presentation/layout/user_drawer.dart';

class GroupChatDetailsScreen extends ConsumerWidget {
  final String groupId;
  final Map<String, dynamic> data;
  const GroupChatDetailsScreen(
      {super.key, required this.groupId, required this.data});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final getId = ref.watch(storedAuthValueProvider);
    return Scaffold(
      appBar: const SondyaTopBar(title: "Details", isHome: false),
      drawer: sonyaUserDrawer(context),
      body: getId.when(
        data: (datab) {
          return GroupChatDetailsBody(
            groupId: groupId,
            userId: datab.id,
            data: data,
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
      bottomNavigationBar: sondyaBottomNavigationBar(context),
    );
  }
}
