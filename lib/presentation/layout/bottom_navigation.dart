import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

Widget sondyaBottomNavigationBar(BuildContext context) {
  return BottomNavigationBar(
    items: <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {
            context.push('/product/search');
          },
        ),
        label: 'Search',
      ),
      BottomNavigationBarItem(
        icon: IconButton(
            icon: const Icon(Icons.home),
            onPressed: () {
              context.push('/');
            }),
        label: 'Home',
      ),
      BottomNavigationBarItem(
        icon: IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              context.push('/settings');
            }),
        label: 'Settings',
      ),
    ],
    // selectedItemColor: Colors.amber[800],
  );
}
