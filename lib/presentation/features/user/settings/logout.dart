import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LogoutBody extends ConsumerStatefulWidget {
  const LogoutBody({super.key});

  @override
  ConsumerState<LogoutBody> createState() => _LogoutBodyState();
}

class _LogoutBodyState extends ConsumerState<LogoutBody> {
  @override
  Widget build(BuildContext context) {
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
                          onPressed: () {}, child: const Text("Logout")),
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
