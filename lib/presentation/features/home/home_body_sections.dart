import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
                          });
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
                onPressed: () async {},
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
              return Wrap(
                spacing: 5,
                runSpacing: 5,
                children: [
                  if (data["data"]["data"] != null &&
                      data["data"]["data"] is List &&
                      data["data"]["data"].isNotEmpty)
                    for (var item in data["data"]["data"].take(4).toList())
                      ProductContainer(
                        productName: item["name"],
                        productPrice: item["current_price"].toDouble(),
                        productImage: item["image"][0]["url"],
                      )
                  else
                    const Text("No products found"),
                ],
              );
            },
            loading: () => const CircularProgressIndicator(),
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
                onPressed: () async {},
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
              return Wrap(
                spacing: 5,
                runSpacing: 5,
                children: [
                  if (data["data"]["data"] != null &&
                      data["data"]["data"] is List &&
                      data["data"]["data"].isNotEmpty)
                    for (var item in data["data"]["data"].take(4).toList())
                      ServiceContainer(
                        productName: item["name"],
                        productPrice: item["current_price"].toDouble(),
                        productImage: item["image"][0]["url"],
                      )
                  else
                    const Text("No products found"),
                ],
              );
            },
            loading: () => const CircularProgressIndicator(),
            error: (error, stackTrace) => Text(error.toString()),
          ),
        ],
      ),
    );
  }
}
