import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sondya_app/router/router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    const ProviderScope(
      child: MyRouter(),
    ),
  );
}

// I am leaving this here
// You are suprised this small code made this app right
// thank you for viewing
