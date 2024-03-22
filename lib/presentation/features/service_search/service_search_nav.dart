import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sondya_app/data/remote/home.dart';
import 'package:sondya_app/data/search_data.dart';
import 'package:sondya_app/domain/models/home.dart';
import 'package:sondya_app/domain/providers/home.provider.dart';
import 'package:sondya_app/presentation/widgets/collapsible_widget.dart';

class ServiceSearchNav extends ConsumerStatefulWidget {
  const ServiceSearchNav({super.key});

  @override
  ConsumerState<ServiceSearchNav> createState() => _ServiceSearchNavState();
}

class _ServiceSearchNavState extends ConsumerState<ServiceSearchNav> {
  late ServiceSearchModel search;
  bool showAll = false;
  int _selectedServiceValue = 0; // Initially selected value
  int _selectedPriceValue = 0; // Initially selected value
  RangeValues _currentRangeValues = const RangeValues(40, 80);
  Timer? _debounce;

  // for the input price selector
  int minPrice = 0;
  int maxPrice = 100;

  @override
  void initState() {
    super.initState();
    search = ref.read(serviceSearchprovider);
    // Initialize the variable in initState
  }

  @override
  Widget build(BuildContext context) {
    final getServiceCategory = ref.watch(getServiceCategoryProvider);
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
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.95,
                  child: ElevatedButton(
                    onPressed: () {
                      context.push("/service/search");
                    },
                    child: const Text("Apply Filter"),
                  ),
                ),
                CollapsibleWidget(
                  title: "Services",
                  isVisible: true,
                  child: Column(
                    children: [
                      getServiceCategory.when(
                        data: (data) {
                          return ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: showAll ? data["data"].length : 5,
                            itemBuilder: (context, index) {
                              return ListTile(
                                leading: Radio(
                                  value: index,
                                  groupValue: _selectedServiceValue,
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedServiceValue = value!;

                                      search.subcategory =
                                          data["data"][index]["name"];
                                    });
                                    ref
                                        .read(serviceSearchprovider.notifier)
                                        .state = search;
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
                        onChanged: (RangeValues values) async {
                          setState(
                            () {
                              _currentRangeValues = values;
                            },
                          );
                          if (_debounce?.isActive ?? false) _debounce!.cancel();
                          _debounce = Timer(const Duration(seconds: 1), () {
                            search.priceRange =
                                "${values.start.toInt()} _ ${values.end.toInt()}";
                            ref.read(serviceSearchprovider.notifier).state =
                                search;
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
                            child: TextField(
                              decoration: const InputDecoration(
                                labelText: 'Min Price',
                              ),
                              keyboardType: TextInputType.number,
                              onChanged: (value) {
                                setState(() {
                                  minPrice = int.parse(value);
                                });
                                if (_debounce?.isActive ?? false) {
                                  _debounce!.cancel();
                                }
                                _debounce =
                                    Timer(const Duration(seconds: 1), () {
                                  search.priceRange = "${minPrice}_$maxPrice";
                                  ref
                                      .read(serviceSearchprovider.notifier)
                                      .state = search;
                                });
                              },
                            ),
                          ),
                          const SizedBox(
                            width: 40,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.5 - 40,
                            child: TextField(
                              decoration: const InputDecoration(
                                labelText: 'Max Price',
                              ),
                              keyboardType: TextInputType.number,
                              onChanged: (value) {
                                setState(() {
                                  maxPrice = int.parse(value);
                                });
                                if (_debounce?.isActive ?? false) {
                                  _debounce!.cancel();
                                }
                                _debounce =
                                    Timer(const Duration(seconds: 1), () {
                                  search.priceRange = "${minPrice}_$maxPrice";
                                  ref
                                      .read(serviceSearchprovider.notifier)
                                      .state = search;
                                });
                              },
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
                              search.priceRange =
                                  priceRangeListString[_selectedPriceValue];
                              ref.read(serviceSearchprovider.notifier).state =
                                  search;
                            }, // Call the function on change
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.95,
                  child: ElevatedButton(
                    onPressed: () {
                      context.push("/service/search");
                    },
                    child: const Text("Apply Filter"),
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
