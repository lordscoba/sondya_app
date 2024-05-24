import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

Drawer sonyaSellerDrawer(BuildContext context) {
  // GlobalKey for drawer navigation
  final GlobalKey<NavigatorState> drawerKey = GlobalKey<NavigatorState>();
  return Drawer(
    key: drawerKey,
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
          leading: const Icon(Icons.storefront_outlined),
          title: const Text('My Products'),
          onTap: () {
            context.push("/seller/products");
          },
        ),
        ListTile(
          leading: const Icon(Icons.work_outlined),
          title: const Text('My Services'),
          onTap: () {
            context.push("/seller/services");
          },
        ),
        ListTile(
          leading: const Icon(Icons.shopping_bag_outlined),
          title: const Text('Products Orders'),
          onTap: () {
            context.push("/seller/products/orders");
          },
        ),
        ListTile(
          leading: const Icon(Icons.shopping_bag_outlined),
          title: const Text('Services Orders'),
          onTap: () {
            context.push("/seller/services/orders");
          },
        ),
        ListTile(
          leading: const Icon(Icons.mail_outline),
          title: const Text('Inbox'),
          onTap: () {
            context.push("/seller/inbox");
          },
        ),
        ListTile(
          leading: const Icon(Icons.money_outlined),
          title: const Text('Withdrawals'),
          onTap: () {
            context.push("/seller/withdrawals");
          },
        ),
        ListTile(
          leading: const Icon(Icons.settings_outlined),
          title: const Text('Settings'),
          onTap: () {
            context.push("/settings");
          },
        ),
      ],
    ),
  );
}
