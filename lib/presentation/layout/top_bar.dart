import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sondya_app/data/local/cart.dart';
import 'package:sondya_app/presentation/layout/search_page_nav.dart';
import 'package:sondya_app/utils/is_seller.dart';

class SondyaTopBar extends ConsumerWidget implements PreferredSizeWidget {
  final bool isHome;
  final String title;

  const SondyaTopBar({super.key, this.isHome = false, required this.title});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // total cart
    int totalCartNum = 0;
    final totalCart = ref.watch(getTotalCartProvider);
    totalCart.whenData((value) {
      totalCartNum = value;
    });

    return AppBar(
      title: Text(title), // Set the title to the page title
      centerTitle: true, // Center aligns the title
      actions: isSellerSession()
          ? [
              IconButton(
                onPressed: () {
                  // context.push("/wishlist");
                },
                icon: const Icon(Icons.notifications),
              )
            ]
          : [
              IconButton(
                onPressed: () {
                  showGeneralDialog(
                    context: context,
                    barrierDismissible:
                        true, // Allow dismissal by tapping outside the dialog
                    transitionDuration: const Duration(
                        milliseconds: 100), // Adjust animation duration
                    transitionBuilder: (context, a1, a2, widget) {
                      return FadeTransition(
                        opacity:
                            CurvedAnimation(parent: a1, curve: Curves.easeIn),
                        child: widget,
                      );
                    },
                    barrierLabel: MaterialLocalizations.of(context)
                        .modalBarrierDismissLabel, // Optional accessibility label
                    pageBuilder: (context, animation1, animation2) {
                      return const SearchPageNavbar();
                    },
                  );
                },
                icon: const Icon(Icons.search), // Icon representing search
              ),
              IconButton(
                onPressed: () {
                  // Handle cart button press
                  context.push("/cart");
                },
                icon: Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.center,
                  children: [
                    const Icon(Icons.shopping_cart),
                    Positioned(
                      top: -10,
                      right: -10,
                      // child: Icon(Icons.circle, color: Colors.red, size: 8),
                      child: Container(
                        width: 22,
                        height: 22,
                        decoration: const BoxDecoration(
                          color: Color(0xFFEDB842),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            totalCartNum.toString(),
                            style: const TextStyle(
                                fontSize: 10,
                                color: Colors.white,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                    )
                  ],
                ), // Icon representing cart
              ),
            ],
    );
  }

  @override
  Size get preferredSize =>
      const Size.fromHeight(kToolbarHeight); // Height of AppBar
}
