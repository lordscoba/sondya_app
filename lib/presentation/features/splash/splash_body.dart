import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashBody extends StatelessWidget {
  const SplashBody({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push("/welcome");
      },
      child: SingleChildScrollView(
        child: Center(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.height,
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CircleAvatar(
                      radius: MediaQuery.of(context).size.width * 0.2,
                      backgroundColor: const Color(0xFFEDB842),
                    )
                  ],
                ),
                Image(
                  image: const AssetImage(
                    'assets/logos/sondya_logo_side.png',
                  ),
                  fit: BoxFit.contain,
                  height: MediaQuery.of(context).size.height * 0.1,
                  width: MediaQuery.of(context).size.width * 0.5,
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: MediaQuery.of(context).size.width * 0.35,
                      backgroundColor: const Color(0xFFEDB842),
                    ),
                  ],
                )
              ],
              // Your scrollable content here
            ),
          ),
        ),
      ),
    );
  }
}
