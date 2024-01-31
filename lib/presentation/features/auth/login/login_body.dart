import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sondya_app/presentation/widgets/circle_images.dart';

class LoginBody extends StatefulWidget {
  const LoginBody({super.key});

  @override
  State<LoginBody> createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: SizedBox(
          height: 650,
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
                obscureText: _obscureText,
                decoration: InputDecoration(
                  hintText: " Enter your Password",
                  labelText: 'Password',
                  suffixIcon: IconButton(
                    icon: Icon(
                        _obscureText ? Icons.visibility : Icons.visibility_off),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  context.push('/home');
                },
                child: const Text("Login"),
              ),
              TextButton(
                onPressed: () {
                  context.push('/forgotPassword');
                },
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
