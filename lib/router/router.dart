import 'package:flutter/material.dart';
import 'package:sondya_app/router/route.list.dart';

class MyRouter extends StatelessWidget {
  const MyRouter({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      builder: (BuildContext context, Widget? child) {
        // Set the desired text scale factor here (adjust as needed)
        const double desiredTextScaleFactor = 1;

        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaler: const TextScaler.linear(desiredTextScaleFactor),
          ),
          child: child!,
        );
      },
      routerConfig: router,
    );
  }
}
