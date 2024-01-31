import 'package:flutter/material.dart';
import 'package:sondya_app/presentation/features/welcome/welcome_body.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.loose,
        children: [
          Image.asset(
            'assets/images/welcome_bg.png', // Replace with your image path
            fit: BoxFit.cover,
          ),
          const WelcomeBody()
        ],
      ),
    );
  }
}
