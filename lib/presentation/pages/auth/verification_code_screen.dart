import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sondya_app/presentation/features/auth/verifyCode/verify_code_body.dart';

class VerificationCodeScreen extends StatelessWidget {
  const VerificationCodeScreen({super.key});

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
        title: const Text("Verification Code"),
      ),
      body: const VerificationCodeBody(),
    );
  }
}
