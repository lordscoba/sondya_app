import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class WishlistBody extends StatelessWidget {
  const WishlistBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      children: [
        Row(
          children: [
            IconButton(
                iconSize: 30,
                onPressed: () {
                  context.pop();
                },
                icon: const Icon(Icons.arrow_back))
          ],
        ),
        ListView(
          shrinkWrap: true,
          children: const [
            WishListItem(),
            WishListItem(),
            WishListItem(),
          ],
        )
      ],
    ));
  }
}

class WishListItem extends StatelessWidget {
  const WishListItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black38,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            width: 100,
            child: Image(image: AssetImage("assets/images/product1.png")),
          ),
          SizedBox(
            width: 230,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "GoPro HERO6 4K Action Camera - Black",
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
                const Text(
                  "\$998.00",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const Text(
                    "Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit "),
                TextButton(
                  style: ButtonStyle(
                    textStyle: MaterialStateProperty.all<TextStyle>(
                      const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    foregroundColor: MaterialStateProperty.all<Color>(
                        const Color(0xFFEDB842)),
                  ),
                  onPressed: () {},
                  child: const Text("View Details"),
                ),
              ],
            ),
          ),
          const IconButton(onPressed: null, icon: Icon(Icons.favorite_outline)),
        ],
      ),
    );
  }
}
