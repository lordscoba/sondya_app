import 'package:flutter/material.dart';
import 'package:sondya_app/presentation/layout/search_page_nav.dart';

class SondyaTopBar extends StatelessWidget implements PreferredSizeWidget {
  final bool isHome;
  final String title;

  const SondyaTopBar({super.key, this.isHome = false, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title), // Set the title to the page title
      centerTitle: true, // Center aligns the title
      actions: [
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
                  opacity: CurvedAnimation(parent: a1, curve: Curves.easeIn),
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
          },
          icon: const Icon(Icons.shopping_cart), // Icon representing cart
        ),
      ],
    );
  }

  @override
  Size get preferredSize =>
      const Size.fromHeight(kToolbarHeight); // Height of AppBar
}
