import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

Widget sondyaBottomNavigationBar(BuildContext context) {
  return BottomNavigationBar(
    items: <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              context.go('/search');
            }),
        label: 'Search',
      ),
      BottomNavigationBarItem(
        icon: IconButton(
            icon: const Icon(Icons.home),
            onPressed: () {
              context.go('/home');
            }),
        label: 'Home',
      ),
      BottomNavigationBarItem(
        icon: IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              context.go('/settings');
            }),
        label: 'Settings',
      ),
    ],
    // selectedItemColor: Colors.amber[800],
  );
}
