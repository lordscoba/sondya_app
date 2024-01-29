import 'package:flutter/material.dart';
import 'package:sondya_app/presentation/widgets/circle_images.dart';

class LoginBody extends StatelessWidget {
  const LoginBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: SizedBox(
          height: 500,
          width: 380,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const CircleImage(),
              const Text(
                "Log in to Sondya",
                style: TextStyle(fontSize: 30),
                textAlign: TextAlign.center,
              ),
              const Text(
                "Enter your details Below",
                textAlign: TextAlign.center,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: " Enter your email",
                  labelText: 'Email',
                ),
              ),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: " Enter your Password",
                  labelText: 'Password',
                ),
              ),
              ElevatedButton(
                onPressed: () {},
                child: const Text("Login"),
              ),
              TextButton(
                onPressed: () {},
                child: const Text("Forgot Password?"),
              ),
              const AuthFooterImages(),
            ],
            // Your scrollable content here
          ),
        ),
      ),
    );
  }
}
