import 'package:flutter/material.dart';
import 'package:sondya_app/presentation/features/splash/splash_body.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      // appBar: AppBar(
      //   leading: IconButton(
      //     onPressed: () {
      //       context.push("/home");
      //     },
      //     icon: const Icon(Icons.home),
      //   ),
      //   title: const Text("Splash Screen"),
      // ),
      body: SplashBody(),
    );
  }
}
