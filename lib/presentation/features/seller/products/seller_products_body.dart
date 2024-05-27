import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sondya_app/data/remote/seller.product.dart';
import 'package:sondya_app/domain/models/home.dart';
import 'package:sondya_app/domain/providers/seller.product.provider.dart';
import 'package:sondya_app/presentation/widgets/price_formatter.dart';
import 'package:sondya_app/presentation/widgets/threebounce_loader.dart';
import 'package:sondya_app/utils/input_validations.dart';
import 'package:sondya_app/utils/map_to_searchstring.dart';

class SellerProductsBody extends ConsumerStatefulWidget {
  const SellerProductsBody({super.key});

  @override
  ConsumerState<SellerProductsBody> createState() => _SellerProductsBodyState();
}

class _SellerProductsBodyState extends ConsumerState<SellerProductsBody> {
  late ProductSearchModel search;
  List<dynamic> allItems = [];
  bool bottomPage = false;

  // controls the scroll container
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // Initialize the variable in initState
    _scrollController.addListener(_scrollListener);
    search = ref.read(sellerProductSearchprovider);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _loadMore() {
    if (search.page == null) {
      search.page = 2;
    } else {
      search.page = search.page! + 1;
    }
    ref.read(sellerProductSearchprovider.notifier).state = search;
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      // Bottom of the page is reached
      // print('Reached the bottom!');
      if (bottomPage == false) {
        setState(() {
          _loadMore();
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // final getSellerProducts = ref.watch(getSellerProductsProvider(""));

    // gets the search map removes null and page key, ready for iteration
    var searchData = ref.watch(sellerProductSearchprovider).toJson();
    searchData.removeWhere((key, value) => (value == null || key == "page"));

    //calls search api with the filter strings
    final getProducts = ref.watch(getSellerProductsProvider(
        "?${mapToSearchString(ref.watch(sellerProductSearchprovider).toJson())}"));

    // assigns fetched data to allitems array
    getProducts.whenData((data) {
      if (data.isNotEmpty) {
        setState(() {
          allItems = [...allItems, ...data["products"]];
        });
      } else {
        setState(() {
          bottomPage = true;
        });
      }
    });

    return SingleChildScrollView(
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: () {
                    context.pop();
                  },
                  icon: const Icon(Icons.arrow_back),
                ),
              ],
            ),
            const SizedBox(height: 20.0),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  width: 200,
                  child: TextFormField(
                    decoration: const InputDecoration(
                      hintText: " Enter your search",
                      labelText: 'Search',
                      prefixIcon: Icon(Icons.search),
                    ),
                    validator: isInputEmpty,
                    onChanged: (value) {
                      Future.delayed(const Duration(seconds: 1), () {
                        if (value.isNotEmpty) {
                          setState(() {
                            // print(value);
                            search.search = value;
                            allItems = [];
                            search.page = null;
                            bottomPage = false;
                            ref
                                .read(sellerProductSearchprovider.notifier)
                                .state = search;
                          });
                        }
                      });
                    },
                  ),
                ),
                SizedBox(
                  width: 200,
                  child: ElevatedButton(
                      onPressed: () {
                        context.push("/seller/products/add");
                      },
                      child: const Row(
                        children: [
                          Icon(Icons.add),
                          Text("Add Product"),
                        ],
                      )),
                )
              ],
            ),
            const SizedBox(height: 20.0),
            ListView.separated(
              controller: _scrollController,
              itemCount: allItems.isNotEmpty ? allItems.length : 1,
              shrinkWrap: true,
              separatorBuilder: (context, index) =>
                  const SizedBox(height: 20.0),
              itemBuilder: (context, index) {
                if (allItems.isNotEmpty) {
                  return SellerProductCard(
                    id: allItems[index]["_id"] ?? "",
                    data: allItems[index],
                    name: allItems[index]["name"] ?? "",
                    status: allItems[index]["product_status"] ?? "",
                    price: allItems[index]["current_price"].toDouble() ?? 0.0,
                    image: allItems[index]["image"][0]["url"] ?? "",
                    productId: allItems[index]["_id"] ?? "",
                    quantity: allItems[index]["total_stock"].toString(),
                  );
                } else if (getProducts.hasValue && allItems.isEmpty) {
                  return const SizedBox(
                    height: 100, // Adjust the height as needed
                    child: Center(child: Text("No products found")),
                  );
                } else {
                  return const SizedBox(
                    height: 100, // Adjust the height as needed
                    child: Center(
                      child: CupertinoActivityIndicator(
                        radius:
                            30, // Adjust the size of the indicator as needed
                      ),
                    ),
                  );
                }
              },
            ),
            if (getProducts.isLoading)
              sondyaThreeBounceLoader(color: const Color(0xFFEDB842), size: 50),
            if (bottomPage == true)
              const Center(child: Text("You have reached bottom of the page"))
          ],
        ),
      ),
    );
  }
}

class SellerProductCard extends ConsumerWidget {
  final String id;
  final Map<String, dynamic> data;
  final String name;
  final String status;
  final double price;
  final String image;
  final String productId;
  final String quantity;
  const SellerProductCard(
      {super.key,
      required this.name,
      required this.status,
      required this.price,
      required this.image,
      required this.productId,
      required this.quantity,
      required this.id,
      required this.data});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // print(image);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      child: Column(
        children: [
          Row(
            children: [
              image.isEmpty || image == ""
                  ? const SizedBox()
                  : Image(
                      image: NetworkImage(image),
                      height: 150,
                      width: 160,
                      fit: BoxFit.cover,
                    ),
              const SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: const TextStyle(fontSize: 20)),
                  const SizedBox(height: 10),
                  PriceFormatWidget(
                    price: price,
                    suffix: " ($quantity)",
                    fontSize: 16,
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Text("Status:"),
                      Text(
                        status,
                        style: TextStyle(
                            color:
                                status == "sold" ? Colors.red : Colors.green),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      IconButton(
                        onPressed: () {
                          context.push("/seller/products/edit/$id");
                        },
                        icon: const Icon(Icons.edit),
                      ),
                      IconButton(
                        onPressed: () {
                          ref.read(getSellerDeleteProductProvider(id));

                          // ignore: unused_result
                          ref.refresh(getSellerProductsProvider(
                              "?${mapToSearchString(ref.watch(sellerProductSearchprovider).toJson())}"));
                        },
                        icon: const Icon(Icons.delete),
                      ),
                      IconButton(
                        onPressed: () {
                          context.push("/seller/products/details/$id",
                              extra: data);
                        },
                        icon: const Icon(Icons.visibility),
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
          const SizedBox(height: 20),
          const Divider(),
        ],
      ),
    );
  }
}
