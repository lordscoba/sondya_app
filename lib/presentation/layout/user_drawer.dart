import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sondya_app/domain/providers/auth.provider.dart';
import 'package:sondya_app/presentation/features/user/settings/logout.dart';
import 'package:sondya_app/utils/auth_utils.dart';
import 'package:sondya_app/utils/is_seller.dart';

// GlobalKey for drawer navigation

Drawer sonyaUserDrawer(BuildContext context) {
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
          leading: const Icon(Icons.home_outlined),
          title: const Text('Home'),
          onTap: () {
            context.push("/");
          },
        ),
        ListTile(
          leading: const Icon(Icons.shopping_cart_outlined),
          title: const Text('Cart'),
          onTap: () {
            context.push("/cart");
          },
        ),
        ListTile(
          leading: const Icon(Icons.message_outlined),
          title: const Text('Inbox'),
          onTap: () {
            context.push("/inbox");
          },
        ),
        ListTile(
          leading: const Icon(Icons.search_outlined),
          title: const Text('Product Search'),
          onTap: () {
            context.push("/product/search");
          },
        ),
        ListTile(
          leading: const Icon(Icons.search_outlined),
          title: const Text('Service Search'),
          onTap: () {
            context.push("/service/search");
          },
        ),
        ListTile(
          leading: const Icon(Icons.history_outlined),
          title: const Text('Product History'),
          onTap: () {
            context.push("/product/order/history");
          },
        ),
        ListTile(
          leading: const Icon(Icons.history_outlined),
          title: const Text('Service History'),
          onTap: () {
            context.push("/service/order/history");
          },
        ),
        ListTile(
          leading: const Icon(Icons.local_shipping_outlined),
          title: const Text('Track Order'),
          onTap: () {
            context.push("/track/order");
          },
        ),
        ListTile(
          leading: const Icon(Icons.favorite_outline),
          title: const Text('Wishlist'),
          onTap: () {
            context.push("/wishlist");
          },
        ),
        ListTile(
          leading: const Icon(Icons.settings_outlined),
          title: const Text('Settings'),
          onTap: () {
            context.push("/settings");
          },
        ),
        const LogoutDrawerWidget(),
        isSellerSession()
            ? ListTile(
                leading: const Icon(Icons.storefront_outlined),
                title: const Text('Go to seller page'),
                onTap: () {
                  context.push("/seller/products");
                },
              )
            : Container(),
      ],
    ),
  );
}

class LogoutDrawerWidget extends ConsumerWidget {
  const LogoutDrawerWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool tempAuth = ref.watch(isAuthenticatedTemp);
    print(tempAuth);
    print(isAuthenticated());
    return isAuthenticated() || tempAuth
        ? ListTile(
            leading: const Icon(Icons.logout_outlined),
            title: const Text('logout'),
            onTap: () {
              showGeneralDialog(
                context: context,
                transitionDuration: const Duration(
                    milliseconds: 100), // Adjust animation duration
                transitionBuilder: (context, a1, a2, widget) {
                  return FadeTransition(
                    opacity: CurvedAnimation(parent: a1, curve: Curves.easeIn),
                    child: widget,
                  );
                },
                barrierLabel: MaterialLocalizations.of(context)
                    .modalBarrierDismissLabel, // Optional accessibility label
                pageBuilder: (context, animation1, animation2) {
                  return const LogoutBody();
                },
              );
            },
          )
        : ListTile(
            leading: const Icon(Icons.login_outlined),
            title: const Text('login/signup'),
            onTap: () {
              context.push("/login");
            },
          );
  }
}
