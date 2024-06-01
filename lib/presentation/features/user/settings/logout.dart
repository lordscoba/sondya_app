import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sondya_app/domain/providers/auth.provider.dart';
import 'package:sondya_app/presentation/widgets/threebounce_loader.dart';

class LogoutBody extends ConsumerWidget {
  const LogoutBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<Map<String, dynamic>> checkState =
        ref.watch(logoutUserProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Logout"),
      ),
      extendBody: true,
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(10.0),
            height: MediaQuery.of(context).size.height - 200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Are you sure you want to logout?",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 20.0),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 150,
                      height: 60,
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("Cancel"),
                      ),
                    ),
                    const SizedBox(width: 20.0),
                    SizedBox(
                      width: 150,
                      height: 60,
                      child: ElevatedButton(
                        onPressed: () async {
                          await ref
                              .read(logoutUserProvider.notifier)
                              .logout(ref);

                          // delay 3 seconds before going to home
                          await Future.delayed(
                              const Duration(milliseconds: 500));

                          // ignore: use_build_context_synchronously
                          context.pop();
                        },
                        child: checkState.isLoading
                            ? sondyaThreeBounceLoader(color: Colors.white)
                            : const Text("Logout"),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
