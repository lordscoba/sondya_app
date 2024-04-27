import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GlobalKey<NavigatorState> _drawerKey =
    GlobalKey<NavigatorState>(); // GlobalKey for drawer navigation

Drawer sonyaUserDrawer(BuildContext context) {
  return Drawer(
    key: _drawerKey,
    child: ListView(
      // Important: Remove any padding from the ListView.
      padding: EdgeInsets.zero,
      children: [
        const DrawerHeader(
          decoration: BoxDecoration(),
          child: Image(
            image: AssetImage("assets/logos/sondya_logo_side.png"),
            height: 120,
            width: double.infinity,
          ),
        ),
        ListTile(
          title: const Text('Wishlist'),
          onTap: () {
            context.push("/wishlist");
          },
        ),
        ListTile(
          title: const Text('Order History'),
          onTap: () {
            // Update the state of the app.
            // ...
          },
        ),
        ListTile(
          title: const Text('Item 2'),
          onTap: () {
            // Update the state of the app.
            // ...
          },
        ),
      ],
    ),
  );
}
