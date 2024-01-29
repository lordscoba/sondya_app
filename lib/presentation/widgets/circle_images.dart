import 'package:flutter/material.dart';

class CircleImage extends StatelessWidget {
  const CircleImage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Image(
          image: AssetImage("assets/shapes/circle_25.png"),
          height: 100,
        ),
      ],
    );
  }
}

class AuthFooterImages extends StatelessWidget {
  const AuthFooterImages({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Image(
          image: AssetImage("assets/shapes/circle_25.png"),
          height: 100,
        ),
        Image(
          image: AssetImage("assets/logos/sondya_logo_side.png"),
          height: 50,
        ),
      ],
    );
  }
}
