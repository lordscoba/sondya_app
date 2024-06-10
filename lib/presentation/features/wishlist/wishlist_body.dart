import 'package:flutter/cupertino.dart';
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
            context.canPop()
                ? Row(
                    children: [
                      IconButton(
                          iconSize: 30,
                          onPressed: () {
                            context.pop();
                          },
                          icon: const Icon(Icons.arrow_back))
                    ],
                  )
                : const SizedBox(),
            getWishList.when(
              data: (data) {
                // ignore: unnecessary_null_comparison
                if (data == null || data.isEmpty) {
                  return const Center(
                    child: Text("No Wishlist Found"),
                  );
                } else {
                  return SizedBox(
                    height: MediaQuery.of(context).size.height - 250,
                    child: ListView.builder(
                      // shrinkWrap: true,
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        // print(data[index].toJson());
                        return WishListItem(
                          id: data[index].id,
                          category: data[index].category,
                          name: data[index].name!,
                          index: index,
                        );
                      },
                    ),
                  );
                }
              },
              error: (error, stackTrace) => Text(error.toString()),
              loading: () => const CupertinoActivityIndicator(
                radius: 50,
              ),
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
    AsyncValue<Map<String, dynamic>> getProductDetails;
    if (widget.category == "product") {
      getProductDetails = ref.watch(getProductDetailsProvider(
          (id: widget.id, name: sondyaSlugify(widget.name))));
    } else {
      getProductDetails = ref.watch(getServiceDetailsProvider(
          (id: widget.id, name: sondyaSlugify(widget.name))));
    }

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
          return data["data"] == null
              ? Column(
                  children: [
                    Text(widget.name),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: const Text(
                          "This item has been removed from server, please remove from wishlist",
                          textAlign: TextAlign.center),
                    ),
                    IconButton(
                      onPressed: () {
                        ref
                            .read(removeFromWishlistProvider.notifier)
                            .removeFromWishlist(widget.id, "product");
                        // ignore: unused_result
                        ref.refresh(getWishlistDataProvider);
                      },
                      icon: const Icon(Icons.delete),
                    ),
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.3,
                      height: 130,
                      child: data["data"]["image"] == null ||
                              data["data"]["image"].isEmpty
                          ? Container()
                          : Image(
                              image: NetworkImage(
                                  data["data"]["image"][0]["url"] ?? ""),
                              fit: BoxFit.cover,
                              height: 130,
                            ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.5,
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
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            data["data"]["description"] ?? "",
                            maxLines: 4,
                            overflow: TextOverflow.ellipsis,
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
                              if (widget.category == "product") {
                                context.push(
                                    "/product/details/${widget.id}/${sondyaSlugify(widget.name)}");
                              } else {
                                context.push(
                                    "/service/details/${widget.id}/${sondyaSlugify(widget.name)}");
                              }
                            },
                            child: const Text("View Details"),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.07,
                      child: IconButton(
                          onPressed: () async {
                            ref
                                .read(removeFromWishlistProvider.notifier)
                                .removeFromWishlist(widget.id, "product");
                            // ignore: unused_result
                            ref.refresh(getWishlistDataProvider);
                          },
                          icon: const Icon(Icons.delete)),
                    ),
                  ],
                );
        },
        error: (error, stackTrace) => Text(error.toString()),
        loading: () => const CupertinoActivityIndicator(
          radius: 20,
        ),
      ),
    );
  }
}
