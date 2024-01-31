import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sondya_app/presentation/features/splash/splash_body.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            context.push("/home");
          },
          icon: const Icon(Icons.home),
        ),
        title: const Text("Splash Screen"),
      ),
      body: const SplashBody(),
    );
  }
}
