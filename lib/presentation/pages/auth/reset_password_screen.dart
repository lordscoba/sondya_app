import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sondya_app/config/style.dart';
import 'package:sondya_app/presentation/features/auth/resetPassword/reset_password_body.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: buildAuthTheme(context),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              context.push("/home");
            },
            icon: const Icon(Icons.home),
          ),
          title: const Text("Reset Password"),
        ),
        body: const ResetPasswordBody(),
      ),
    );
  }
}
