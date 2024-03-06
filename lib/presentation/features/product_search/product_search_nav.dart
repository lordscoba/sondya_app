import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sondya_app/data/remote/home.dart';
import 'package:sondya_app/domain/models/home.dart';
import 'package:sondya_app/domain/providers/home.provider.dart';
import 'package:sondya_app/presentation/widgets/collapsible_widget.dart';

class ProductSearchNav extends ConsumerStatefulWidget {
  const ProductSearchNav({super.key});

  @override
  ConsumerState<ProductSearchNav> createState() => _ProductSearchNavState();
}

class _ProductSearchNavState extends ConsumerState<ProductSearchNav> {
  final String _queryString = "";
  late ProductSearchModel search;
  bool showAll = false;
  int _selectedProductValue = 0; // Initially selected value
  int _selectedPriceValue = 0; // Initially selected value
  RangeValues _currentRangeValues = const RangeValues(40, 80);

  @override
  void initState() {
    super.initState();
    // search = ProductSearchModel();
    search = ref.read(productSearchprovider);
    // Initialize the variable in initState
  }

  @override
  Widget build(BuildContext context) {
    final getProductCategory = ref.watch(getProductCategoryProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Filter Results"),
      ),
      extendBody: true,
      body: SingleChildScrollView(
        child: Center(
          child: SizedBox(
            height: 3000,
            width: double.infinity,
            child: Column(
              children: [
                TextButton(
                    onPressed: () {
                      context.push("/product/search");
                    },
                    child: const Text("apply filter")),
                CollapsibleWidget(
                  title: "Products",
                  isVisible: true,
                  child: Column(
                    children: [
                      getProductCategory.when(
                        data: (data) {
                          return ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: showAll ? data["data"].length : 5,
                            itemBuilder: (context, index) {
                              return ListTile(
                                leading: Radio(
                                  value: index,
                                  groupValue: _selectedProductValue,
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedProductValue = value!;

                                      search.subcategory =
                                          data["data"][index]["name"];

                                      ref
                                          .read(productSearchprovider.notifier)
                                          .state = search;
                                      debugPrint(search.toJson().toString());
                                      // ref.read(getProductSearchProvider(
                                      //     "?${mapToSearchString(ref.watch(productSearchprovider).toJson())}"));
                                    });
                                  },
                                ),
                                title: Text(
                                  data["data"][index]["name"].toString(),
                                ),
                              );
                            },
                          );
                        },
                        loading: () => const CircularProgressIndicator(),
                        error: (error, stackTrace) => Text(error.toString()),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                            setState(() {
                              showAll = !showAll;
                            });
                          },
                          child: showAll
                              ? const Text("show less")
                              : const Text("show all"),
                        ),
                      )
                    ],
                  ),
                ),
                CollapsibleWidget(
                  title: "Price Range",
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      RangeSlider(
                        values: _currentRangeValues,
                        max: 1000,
                        divisions: 100,
                        labels: RangeLabels(
                          "\$${_currentRangeValues.start.round()}",
                          "\$${_currentRangeValues.end.round()}",
                        ),
                        onChanged: (RangeValues values) {
                          setState(() {
                            _currentRangeValues = values;
                          });
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.5 - 40,
                            child: const TextField(
                              decoration: InputDecoration(
                                labelText: 'Min Price',
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 40,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.5 - 40,
                            child: const TextField(
                              decoration: InputDecoration(
                                labelText: 'Max Price',
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Column(
                        children: priceRangeList.asMap().entries.map((entry) {
                          int index = entry.key;
                          String option = entry.value;
                          return RadioListTile<int>(
                            title: Text(option),
                            value: index, // Use index for the value
                            groupValue:
                                _selectedPriceValue, // Currently selected value
                            onChanged: (value) {
                              setState(() {
                                _selectedPriceValue = value!;
                              });
                            }, // Call the function on change
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
                CollapsibleWidget(
                  title: "Popular Brands",
                  child: Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: popularBrandList.asMap().entries.map((entry) {
                      int index = entry.key;
                      String option = entry.value;
                      bool checked = false;
                      return SizedBox(
                        width: MediaQuery.of(context).size.width * 0.5 - 30,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Checkbox(
                              value: checked,
                              onChanged: (value) {
                                setState(() {
                                  checked = value!;
                                });
                              },
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(option),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

final List<String> priceRangeList = [
  'All Prices',
  'Under \$20',
  '\$20 - \$100',
  '\$100 - \$300',
  '\$300 to \$500',
  '\$500 to \$1000',
  '\$1000 to \$10000'
];

final List<String> popularBrandList = [
  "Apple",
  "Google",
  "Microsoft",
  "Samsung",
  "Dell",
  "Hp",
  "Sony",
  "Xiaomi",
  "Lenovo",
  "Amazon",
  "Vivo",
];
