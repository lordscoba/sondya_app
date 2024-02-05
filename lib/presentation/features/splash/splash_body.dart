import 'package:flutter/material.dart';

class SplashBody extends StatelessWidget {
  const SplashBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          child: const OverflowBox(
            maxHeight: double.infinity,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CircleAvatar(
                      radius: 110,
                      backgroundColor: Color(0xFFEDB842),
                    )
                  ],
                ),
                Image(
                  image: AssetImage(
                    'assets/logos/sondya_logo_side.png',
                  ),
                  fit: BoxFit.contain,
                  height: 200,
                  width: 250,
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 210,
                      backgroundColor: Color(0xFFEDB842),
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
