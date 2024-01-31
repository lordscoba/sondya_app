import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sondya_app/presentation/features/auth/registerSuccess/register_success_body.dart';

class RegisterSuccessScreen extends StatelessWidget {
  const RegisterSuccessScreen({super.key});

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
        title: const Text("Registration Success"),
      ),
      body: const RegisterSuccessBody(),
    );
  }
}
