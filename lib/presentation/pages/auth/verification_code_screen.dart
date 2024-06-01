import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sondya_app/presentation/features/auth/verifyCode/verify_code_body.dart';

class VerificationCodeScreen extends StatelessWidget {
  final String email;
  const VerificationCodeScreen({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: context.canPop()
            ? IconButton(
                onPressed: () {
                  context.pop();
                },
                icon: const Icon(Icons.arrow_back),
              )
            : IconButton(
                onPressed: () {
                  context.push("/");
                },
                icon: const Icon(Icons.home),
              ),
        title: const Text("Verification Code"),
      ),
      body: VerificationCodeBody(
        email: email,
      ),
    );
  }
}
