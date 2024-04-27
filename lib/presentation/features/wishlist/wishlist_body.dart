import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sondya_app/data/local/wishlist.dart';
import 'package:sondya_app/data/remote/home.dart';
import 'package:sondya_app/domain/providers/wishlist.provider.dart';
import 'package:sondya_app/utils/slugify.dart';

class WishlistBody extends ConsumerWidget {
  const WishlistBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final getWishList = ref.watch(getWishlistDataProvider);
    return SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
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
            getWishList.when(
              data: (data) {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return WishListItem(
                      id: data[index].id,
                      category: data[index].category,
                      name: data[index].name,
                      index: index,
                    );
                  },
                );
              },
              error: (error, stackTrace) => Text(error.toString()),
              loading: () => const CircularProgressIndicator(),
            ),
          ],
        ));
  }
}

class WishListItem extends ConsumerStatefulWidget {
  final int index;
  final String id;
  final String category;
  final String name;
  const WishListItem(
      {required this.id,
      required this.category,
      required this.name,
      required this.index,
      super.key});

  @override
  ConsumerState<WishListItem> createState() => _WishListItemState();
}

class _WishListItemState extends ConsumerState<WishListItem> {
  @override
  Widget build(BuildContext context) {
    final getProductDetails = ref.watch(getProductDetailsProvider(
        (id: widget.id, name: sondyaSlugify(widget.name))));
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
      child: getProductDetails.when(
        data: (data) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 100,
                child: Image(
                  image: NetworkImage(data["data"]["image"][0]["url"] ?? ""),
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                width: 230,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data["data"]["name"] ?? "",
                      style: const TextStyle(
                          fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                    const Text(
                      "\$998.00",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      data["data"]["description"] ?? "",
                    ),
                    TextButton(
                      style: ButtonStyle(
                        textStyle: MaterialStateProperty.all<TextStyle>(
                          const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                        foregroundColor: MaterialStateProperty.all<Color>(
                            const Color(0xFFEDB842)),
                      ),
                      onPressed: () {
                        context.push(
                            "/product/details/${widget.id}/${sondyaSlugify(widget.name)}");
                      },
                      child: const Text("View Details"),
                    ),
                  ],
                ),
              ),
              IconButton(
                  onPressed: () async {
                    ref
                        .read(removeFromWishlistProvider.notifier)
                        .removeFromWishlist(widget.id, "product");
                    // ignore: unused_result
                    ref.refresh(getWishlistDataProvider);
                  },
                  icon: const Icon(Icons.delete)),
            ],
          );
        },
        error: (error, stackTrace) => Text(error.toString()),
        loading: () => const CircularProgressIndicator(),
      ),
    );
  }
}
