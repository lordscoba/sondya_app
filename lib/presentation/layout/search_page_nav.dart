import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchPageNavbar extends ConsumerStatefulWidget {
  const SearchPageNavbar({super.key});

  @override
  ConsumerState<SearchPageNavbar> createState() => _SearchPageNavbarState();
}

class _SearchPageNavbarState extends ConsumerState<SearchPageNavbar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      extendBody: true,
      body: const Center(
        child: Text("Search Page"),
      ),
    );
  }
}
