import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

Widget sondyaSellerBottomNavigationBar(BuildContext context) {
  return BottomNavigationBar(
    items: <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: IconButton(
          icon: const Icon(Icons.store),
          onPressed: () {
            context.push('/seller/products');
          },
        ),
        label: 'Products',
      ),
      BottomNavigationBarItem(
        icon: IconButton(
          icon: const Icon(Icons.work),
          onPressed: () {
            context.push('/seller/services');
          },
        ),
        label: 'Services',
      ),
      BottomNavigationBarItem(
        icon: IconButton(
          icon: const Icon(Icons.monetization_on),
          onPressed: () {
            context.push('/seller/withdrawals');
          },
        ),
        label: 'Withdrawals',
      ),
    ],
  );
}
