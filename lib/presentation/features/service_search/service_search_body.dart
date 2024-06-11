import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sondya_app/data/remote/search.dart';
import 'package:sondya_app/domain/models/home.dart';
import 'package:sondya_app/domain/providers/home.provider.dart';
import 'package:sondya_app/presentation/features/service_search/service_search_nav.dart';
import 'package:sondya_app/presentation/widgets/product_service_container.dart';
import 'package:sondya_app/presentation/widgets/select_widget.dart';
import 'package:sondya_app/presentation/widgets/threebounce_loader.dart';
import 'package:sondya_app/utils/input_validations.dart';
import 'package:sondya_app/utils/map_to_searchstring.dart';
import 'package:sondya_app/utils/range_price_format.dart';

class ServiceSearchBody extends ConsumerStatefulWidget {
  const ServiceSearchBody({super.key});

  @override
  ConsumerState<ServiceSearchBody> createState() => _ServiceSearchBodyState();
}

class _ServiceSearchBodyState extends ConsumerState<ServiceSearchBody> {
  late ServiceSearchModel search;
  String _selectedSortType = "Sort By";
  List<dynamic> allItems = [];
  bool bottomPage = false;

  // controls the scroll container
  final ScrollController _scrollController = ScrollController();

  Map<String, dynamic> searchData = {};

  TextEditingController? searchController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // Initialize the variable in initState
    _scrollController.addListener(_scrollListener);
    search = ref.read(serviceSearchprovider);

    // assign initial text to search controller
    searchController = TextEditingController(text: search.search);
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
    ref.read(serviceSearchprovider.notifier).state = search;
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
    // gets the search map removes null and page key, ready for iteration
    searchData = ref.watch(serviceSearchprovider).toJson();
    searchData.removeWhere((key, value) => (value == null || key == "page"));

    //calls search api with the filter strings
    final getServices = ref.watch(getServiceSearchProvider(
        "?${mapToSearchString(ref.watch(serviceSearchprovider).toJson())}"));

    // assigns fetched data to allitems array
    getServices.whenData((data) {
      if (data.isNotEmpty) {
        setState(() {
          allItems = [...allItems, ...data];
        });
      } else {
        setState(() {
          bottomPage = true;
        });
      }
    });
    return SingleChildScrollView(
      child: Center(
        child: Container(
          // height: 600,
          height: MediaQuery.of(context).size.height * 0.85,
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
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
              const SizedBox(height: 5),
              TextFormField(
                decoration: InputDecoration(
                  hintText: " Enter your search",
                  labelText: 'Search',
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: IconButton(
                    icon: search.search == null || search.search == ""
                        ? const SizedBox()
                        : const Icon(Icons.clear, color: Colors.red),
                    onPressed: () {
                      setState(() {
                        search.search = null;
                        search.page = null;

                        searchController!.clear();

                        allItems = [];
                        search.page = null;
                        bottomPage = false;
                        ref.read(serviceSearchprovider.notifier).state = search;
                      });
                    },
                  ),
                ),
                controller: searchController,
                validator: isInputEmpty,
                onChanged: (value) {
                  Future.delayed(const Duration(seconds: 1), () {
                    if (value.isNotEmpty) {
                      setState(() {
                        search.search = value;
                        allItems = [];
                        search.page = null;
                        bottomPage = false;
                        ref.read(serviceSearchprovider.notifier).state = search;
                      });
                    }
                  });
                },
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () async {
                        List<String> sortByList = [
                          "Latest",
                          "Oldest",
                          "Alphabetical(A-Z)",
                          "Alphabetical(Z-A)"
                        ];
                        SondyaSelectWidget().showBottomSheet<String>(
                          options: sortByList,
                          context: context,
                          onItemSelected: (value) {
                            setState(() {
                              // refresh page
                              allItems = [];
                              search.page = null;
                              bottomPage = false;

                              _selectedSortType = value;
                            });
                            if (value == "Alphabetical(A-Z)") {
                              search.sortBy = "a-z";
                            } else if (value == "Alphabetical(Z-A)") {
                              search.sortBy = "z-a";
                            } else {
                              search.sortBy = value.toLowerCase();
                            }
                            ref.read(serviceSearchprovider.notifier).state =
                                search;
                          },
                        );
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            _selectedSortType,
                            style: const TextStyle(fontSize: 12),
                          ),
                          const Icon(Icons.arrow_drop_down),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        // refresh page
                        allItems = [];
                        search.page = null;
                        bottomPage = false;

                        showGeneralDialog(
                          context: context,
                          transitionDuration: const Duration(
                              milliseconds: 100), // Adjust animation duration
                          transitionBuilder: (context, a1, a2, widget) {
                            return FadeTransition(
                              opacity: CurvedAnimation(
                                  parent: a1, curve: Curves.easeIn),
                              child: widget,
                            );
                          },
                          barrierLabel: MaterialLocalizations.of(context)
                              .modalBarrierDismissLabel, // Optional accessibility label
                          pageBuilder: (context, animation1, animation2) {
                            return const ServiceSearchNav();
                          },
                        );
                      },
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text("Filter By:"),
                          SizedBox(width: 5),
                          Icon(Icons.filter_list_sharp),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: searchData.isEmpty ? 1 : 50,
                child: ListView.builder(
                  // shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: searchData.length,
                  itemBuilder: (context, index) {
                    final key = searchData.keys.elementAt(index);
                    final value = searchData[key];

                    if (searchData.isNotEmpty) {
                      return Padding(
                        padding: EdgeInsets.only(
                            left: index == 0
                                ? 0
                                : 8), // Adjust the left padding as needed
                        child: InputChip(
                          label: key == "priceRange"
                              ? Text(formatPriceRange(value.toString()))
                              : Text(value.toString()),
                          labelStyle: const TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.black),
                          backgroundColor: Colors.grey,
                          onDeleted: () => {
                            setState(() {
                              if (key == "search") {
                                search.search = null;
                                searchController!.clear();
                              } else if (key == "priceRange") {
                                search.priceRange = null;
                              } else if (key == "subcategory") {
                                search.subcategory = null;
                              } else if (key == "sortBy") {
                                search.sortBy = null;
                              }
                              allItems = [];
                              search.page = null;
                              bottomPage = false;
                              ref.read(serviceSearchprovider.notifier).state =
                                  search;
                            })
                          },
                        ),
                      );
                    } else {
                      return const SizedBox.shrink();
                    }
                  },
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Expanded(
                child: GridView.builder(
                  shrinkWrap: true,
                  controller: _scrollController,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // You can adjust this as needed
                    crossAxisSpacing: 6.0,
                    mainAxisSpacing: 6.0,
                    childAspectRatio: 0.7,
                  ),
                  itemCount: allItems.isNotEmpty ? allItems.length : 1,
                  itemBuilder: (context, index) {
                    if (allItems.isNotEmpty) {
                      return ServiceContainer(
                        id: allItems[index]["_id"],
                        productName: allItems[index]["name"],
                        productPrice:
                            allItems[index]["current_price"].toDouble(),
                        productImage: allItems[index]["image"][0]["url"],
                      );
                    } else if (getServices.hasValue && allItems.isEmpty) {
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
              ),
              if (getServices.isLoading)
                sondyaThreeBounceLoader(
                    color: const Color(0xFFEDB842), size: 50),
              if (bottomPage == true)
                const Center(child: Text("You have reached bottom of the page"))
            ],
            // Your scrollable content here
          ),
        ),
      ),
    );
  }
}
