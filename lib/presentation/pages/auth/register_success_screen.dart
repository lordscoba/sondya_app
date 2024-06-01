import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sondya_app/presentation/features/auth/registerSuccess/register_success_body.dart';

class RegisterSuccessScreen extends StatelessWidget {
  const RegisterSuccessScreen({super.key});

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
        title: const Text("Registration Success"),
      ),
      body: const RegisterSuccessBody(),
    );
  }
}
