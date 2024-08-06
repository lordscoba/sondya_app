import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sondya_app/data/local/storedValue.dart';
import 'package:sondya_app/presentation/features/groupchat/groupchat_body.dart';
import 'package:sondya_app/presentation/layout/bottom_navigation.dart';
import 'package:sondya_app/presentation/layout/top_bar.dart';
import 'package:sondya_app/presentation/layout/user_drawer.dart';

class GroupChatScreen extends ConsumerWidget {
  final String groupId;
  const GroupChatScreen({super.key, required this.groupId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final getId = ref.watch(storedAuthValueProvider);
    return Scaffold(
      appBar: const SondyaTopBar(title: "Group Chat", isHome: false),
      drawer: sonyaUserDrawer(context),
      body: getId.when(
        data: (data) {
          return GroupChatBody(
            groupId: groupId,
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
      bottomNavigationBar: sondyaBottomNavigationBar(context),
    );
  }
}
