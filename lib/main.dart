import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sondya_app/data/hive_boxes.dart';
import 'package:sondya_app/domain/hive_models/auth.dart';
import 'package:sondya_app/router/router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize hive
  await Hive.initFlutter();

  // Register adapters
  Hive.registerAdapter(AuthInfoAdapter());

  // Open local boxes
  boxAuth = await Hive.openBox<AuthInfo>(authBoxString);

  runApp(
    const ProviderScope(
      child: MyRouter(),
    ),
  );
}

// I am leaving this here
// You are suprised this small code made this app right
// thank you for viewing
