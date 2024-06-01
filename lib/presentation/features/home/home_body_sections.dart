import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sondya_app/data/remote/home.dart';
import 'package:sondya_app/presentation/widgets/product_service_container.dart';
import 'package:sondya_app/presentation/widgets/select_widget.dart';

class HomeProductsList extends ConsumerStatefulWidget {
  const HomeProductsList({
    super.key,
  });

  @override
  ConsumerState<HomeProductsList> createState() => _HomeProductsListState();
}

class _HomeProductsListState extends ConsumerState<HomeProductsList> {
  String _selectedCategory = "";
  String _queryString = "";

  @override
  Widget build(BuildContext context) {
    final getProductCategory = ref.watch(getProductCategoryProvider);
    final getProducts = ref.watch(gethomeProductsProvider(_queryString));
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () async {
                  SondyaSelectWidget()
                      .showBottomSheetApi<AsyncValue<Map<String, dynamic>>>(
                    options: getProductCategory,
                    context: context,
                    onItemSelected: (value) {
                      setState(() {
                        _selectedCategory = value;
                        _queryString = "?search=$value";
                      });
                      // user.country = value.toString();
                    },
                  );
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: 150,
                      child: Text(
                        _selectedCategory == ""
                            ? "Select Products"
                            : _selectedCategory,
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w400),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const Icon(Icons.arrow_drop_down),
                  ],
                ),
              ),
              TextButton(
                onPressed: () async {
                  context.push("/product/search");
                },
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "View more",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                    ),
                    Icon(Icons.arrow_forward),
                  ],
                ),
              ),
            ],
          ),
          getProducts.when(
            data: (data) {
              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // You can adjust this as needed
                  crossAxisSpacing: 6.0,
                  mainAxisSpacing: 6.0,
                  childAspectRatio: 0.7,
                ),
                itemCount: data["data"]["data"].length > 4 ? 4 : 1,
                itemBuilder: (context, index) {
                  // return const Text("hy");
                  if (data["data"]["data"].isNotEmpty) {
                    return ProductContainer(
                      id: data["data"]["data"][index]["_id"],
                      productName: data["data"]["data"][index]["name"],
                      productPrice: data["data"]["data"][index]["current_price"]
                          .toDouble(),
                      productImage: data["data"]["data"][index]["image"][0]
                          ["url"],
                    );
                  } else {
                    return const SizedBox(
                      child: Center(child: Text("No products found")),
                    );
                  }
                },
              );
            },
            loading: () => const Center(
              child: CupertinoActivityIndicator(
                radius: 30, // Adjust the size of the indicator as needed
              ),
            ),
            error: (error, stackTrace) => Text(error.toString()),
          ),
        ],
      ),
    );
  }
}

class HomeServicesList extends ConsumerStatefulWidget {
  const HomeServicesList({
    super.key,
  });

  @override
  ConsumerState<HomeServicesList> createState() => _HomeServicesListState();
}

class _HomeServicesListState extends ConsumerState<HomeServicesList> {
  String _selectedCategory = "";
  String _queryString = "";

  @override
  Widget build(BuildContext context) {
    final getServiceCategory = ref.watch(getServiceCategoryProvider);
    final getServices = ref.watch(gethomeServicesProvider(_queryString));
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () async {
                  SondyaSelectWidget()
                      .showBottomSheetApi<AsyncValue<Map<String, dynamic>>>(
                          options: getServiceCategory,
                          context: context,
                          onItemSelected: (value) {
                            setState(() {
                              _selectedCategory = value;
                              _queryString = "?search=$value";
                            });
                          });
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: 150,
                      child: Text(
                        _selectedCategory == ""
                            ? "Select Services"
                            : _selectedCategory,
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w400),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const Icon(Icons.arrow_drop_down),
                  ],
                ),
              ),
              TextButton(
                onPressed: () {
                  context.push("/service/search");
                },
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "View more",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                    ),
                    Icon(Icons.arrow_forward),
                  ],
                ),
              ),
            ],
          ),
          getServices.when(
            data: (data) {
              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // You can adjust this as needed
                  crossAxisSpacing: 6.0,
                  mainAxisSpacing: 6.0,
                  childAspectRatio: 0.7,
                ),
                itemCount: data["data"]["data"].length > 4 ? 4 : 1,
                itemBuilder: (context, index) {
                  // return const Text("hy");
                  if (data["data"]["data"].isNotEmpty) {
                    return ServiceContainer(
                      id: data["data"]["data"][index]["_id"],
                      productName: data["data"]["data"][index]["name"],
                      productPrice: data["data"]["data"][index]["current_price"]
                          .toDouble(),
                      productImage: data["data"]["data"][index]["image"][0]
                          ["url"],
                    );
                  } else {
                    return const SizedBox(
                      child: Center(child: Text("No products found")),
                    );
                  }
                },
              );
            },
            loading: () => const Center(
              child: CupertinoActivityIndicator(
                radius: 30, // Adjust the size of the indicator as needed
              ),
            ),
            error: (error, stackTrace) => Text(error.toString()),
          ),
        ],
      ),
    );
  }
}
