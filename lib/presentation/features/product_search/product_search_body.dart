import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sondya_app/data/remote/search.dart';
import 'package:sondya_app/domain/models/home.dart';
import 'package:sondya_app/domain/providers/home.provider.dart';
import 'package:sondya_app/presentation/features/product_search/product_search_nav.dart';
import 'package:sondya_app/presentation/widgets/product_service_container.dart';
import 'package:sondya_app/utils/input_validations.dart';
import 'package:sondya_app/utils/map_to_searchstring.dart';

class ProductSearchBody extends ConsumerStatefulWidget {
  const ProductSearchBody({super.key});

  @override
  ConsumerState<ProductSearchBody> createState() => _ProductSearchBodyState();
}

class _ProductSearchBodyState extends ConsumerState<ProductSearchBody> {
  // final String _queryString = "";
  late ProductSearchModel search;

  @override
  void initState() {
    super.initState();
    // search = ProductSearchModel();
    // search = ref.read(productSearchprovider);
    // Initialize the variable in initState
  }

  @override
  Widget build(BuildContext context) {
    search = ref.watch(productSearchprovider);
    // final getProducts = ref.watch(getProductSearchProvider(_queryString));
    final getProducts = ref.watch(getProductSearchProvider(
        "?${mapToSearchString(ref.watch(productSearchprovider).toJson())}"));
    return SingleChildScrollView(
      child: Center(
        child: Container(
          height: 1400,
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextFormField(
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
                        search.search = value;
                        ref.read(productSearchprovider.notifier).state = search;
                      });
                    }
                  });
                },
              ),
              const SizedBox(
                height: 20,
              ),
              TextButton(
                  onPressed: () {
                    showGeneralDialog(
                      context: context,
                      // barrierDismissible:
                      //     true, // Allow dismissal by tapping outside the dialog
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
                        return const ProductSearchNav();
                      },
                    );
                  },
                  child: const Text("Search bar")),
              Text(ref.watch(productSearchprovider).toJson().toString()),
              const SizedBox(
                height: 20,
              ),
              getProducts.when(
                data: (data) {
                  return Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: [
                      if (data["data"]["products"] != null &&
                          data["data"]["products"] is List &&
                          data["data"]["products"].isNotEmpty)
                        for (var item
                            in data["data"]["products"].take(10).toList())
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
            // Your scrollable content here
          ),
        ),
      ),
    );
  }
}
