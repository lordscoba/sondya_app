import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sondya_app/presentation/widgets/select_widget.dart';
import 'package:sondya_app/presentation/widgets/variants_widget.dart';
import 'package:sondya_app/utils/input_validations.dart';

class SellerProductsEditBody extends ConsumerStatefulWidget {
  const SellerProductsEditBody({super.key});

  @override
  ConsumerState<SellerProductsEditBody> createState() =>
      _SellerProductsEditBodyState();
}

class _SellerProductsEditBodyState
    extends ConsumerState<SellerProductsEditBody> {
  final _formKey = GlobalKey<FormState>();
  var _selectedCategory = "Category";
  var _selectedStatus = "Status";
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
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
                const SizedBox(height: 20),
                const Text(
                  "Category",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                const Text("Product Name",
                    style: TextStyle(color: Colors.grey)),
                const SizedBox(height: 5),
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: " Enter Product Name",
                    labelText: 'Product Name',
                  ),
                  initialValue: "Product Name",
                  validator: isInputEmpty,
                  onSaved: (value) {
                    // user.firstName = value!;
                  },
                ),
                const SizedBox(height: 10),
                const Text("Brand Name", style: TextStyle(color: Colors.grey)),
                const SizedBox(height: 5),
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: " Enter Brand Name",
                    labelText: 'Brand Name',
                  ),
                  initialValue: "Product Name",
                  validator: isInputEmpty,
                  onSaved: (value) {
                    // user.firstName = value!;
                  },
                ),
                const SizedBox(height: 10),
                const Text("Description", style: TextStyle(color: Colors.grey)),
                const SizedBox(height: 5),
                // text area
                TextFormField(
                  maxLines: 3,
                  decoration: const InputDecoration(
                    hintText: " Enter Product Name",
                    labelText: 'Product Name',
                  ),
                  initialValue: "Product Name",
                  validator: isInputEmpty,
                  onSaved: (value) {
                    // user.firstName = value!;
                  },
                ),
                const SizedBox(height: 10),
                const Text("Product Category",
                    style: TextStyle(color: Colors.grey)),
                const SizedBox(height: 5),
                SizedBox(
                  width: double.infinity,
                  height: 50,
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
                            _selectedCategory = value;
                          });
                        },
                      );
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          _selectedCategory,
                          style: const TextStyle(fontSize: 12),
                        ),
                        const Icon(Icons.arrow_drop_down),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                const Text("Tag Name", style: TextStyle(color: Colors.grey)),
                const SizedBox(height: 5),
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: " Enter Tag Name",
                    labelText: 'Tag Name',
                  ),
                  initialValue: "Tag Name",
                  validator: isInputEmpty,
                  onSaved: (value) {
                    // user.firstName = value!;
                  },
                ),
                const SizedBox(height: 10),
                const Text("Product Status",
                    style: TextStyle(color: Colors.grey)),
                const SizedBox(height: 5),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: OutlinedButton(
                    onPressed: () async {
                      List<String> sortByList = [
                        "draft",
                        "available",
                        "hot",
                        "sold"
                      ];
                      SondyaSelectWidget().showBottomSheet<String>(
                        options: sortByList,
                        context: context,
                        onItemSelected: (value) {
                          setState(() {
                            _selectedStatus = value;
                          });
                        },
                      );
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          _selectedStatus,
                          style: const TextStyle(fontSize: 12),
                        ),
                        const Icon(Icons.arrow_drop_down),
                      ],
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.45,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 10),
                          const Text("Country",
                              style: TextStyle(color: Colors.grey)),
                          const SizedBox(height: 5),
                          TextFormField(
                            decoration: const InputDecoration(
                              hintText: " Enter Country",
                              labelText: 'Country',
                            ),
                            initialValue: "Country",
                            validator: isInputEmpty,
                            onSaved: (value) {
                              // user.firstName = value!;
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.45,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 10),
                          const Text("State",
                              style: TextStyle(color: Colors.grey)),
                          const SizedBox(height: 5),
                          TextFormField(
                            decoration: const InputDecoration(
                              hintText: " Enter State",
                              labelText: 'State',
                            ),
                            initialValue: "State",
                            validator: isInputEmpty,
                            onSaved: (value) {
                              // user.firstName = value!;
                            },
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.45,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 10),
                          const Text("City",
                              style: TextStyle(color: Colors.grey)),
                          const SizedBox(height: 5),
                          TextFormField(
                            decoration: const InputDecoration(
                              hintText: " Enter City",
                              labelText: 'City',
                            ),
                            initialValue: "City",
                            validator: isInputEmpty,
                            onSaved: (value) {
                              // user.firstName = value!;
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.45,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 10),
                          const Text("Zip Code",
                              style: TextStyle(color: Colors.grey)),
                          const SizedBox(height: 5),
                          TextFormField(
                            decoration: const InputDecoration(
                              hintText: " Enter Zip Code",
                              labelText: 'Zip Code',
                            ),
                            initialValue: "Zip Code",
                            validator: isInputEmpty,
                            onSaved: (value) {
                              // user.firstName = value!;
                            },
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 10),
                const Text("Address", style: TextStyle(color: Colors.grey)),
                const SizedBox(height: 5),
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: " Enter Address",
                    labelText: 'Address',
                  ),
                  initialValue: "Address",
                  validator: isInputEmpty,
                  onSaved: (value) {
                    // user.firstName = value!;
                  },
                ),
                // media space
                const SizedBox(height: 20),
                const Text("Media",
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 20),
                const Text("Pricing",
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                const Text("Price", style: TextStyle(color: Colors.grey)),
                const SizedBox(height: 5),
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: "Enter Price",
                    labelText: 'Price',
                  ),
                  initialValue: "Price",
                  validator: isInputEmpty,
                  onSaved: (value) {
                    // user.firstName = value!;
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.45,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 10),
                          const Text("Old Price",
                              style: TextStyle(color: Colors.grey)),
                          const SizedBox(height: 5),
                          TextFormField(
                            decoration: const InputDecoration(
                              hintText: " Enter Old Price",
                              labelText: 'Old Price',
                            ),
                            initialValue: "Old Price",
                            validator: isInputEmpty,
                            onSaved: (value) {
                              // user.firstName = value!;
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.45,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 10),
                          const Text("Discount Precentage (%)",
                              style: TextStyle(color: Colors.grey)),
                          const SizedBox(height: 5),
                          TextFormField(
                            decoration: const InputDecoration(
                              hintText: " Enter Discount Precentage (%)",
                              labelText: 'Discount Precentage (%)',
                            ),
                            initialValue: "100%",
                            validator: isInputEmpty,
                            onSaved: (value) {
                              // user.firstName = value!;
                            },
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.45,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 10),
                          const Text("Total Stock",
                              style: TextStyle(color: Colors.grey)),
                          const SizedBox(height: 5),
                          TextFormField(
                            decoration: const InputDecoration(
                              hintText: " Enter Total Stock",
                              labelText: 'Total Stock',
                            ),
                            initialValue: "Total Stock",
                            validator: isInputEmpty,
                            onSaved: (value) {
                              // user.firstName = value!;
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.45,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 10),
                          const Text("VAT Amount (%)",
                              style: TextStyle(color: Colors.grey)),
                          const SizedBox(height: 5),
                          TextFormField(
                            decoration: const InputDecoration(
                              hintText: " Enter VAT Amount (%)",
                              labelText: 'VAT Amount (%)',
                            ),
                            initialValue: "100%",
                            validator: isInputEmpty,
                            onSaved: (value) {
                              // user.firstName = value!;
                            },
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 20),
                const Text("Inventory",
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.45,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 10),
                          const Text("Model Number",
                              style: TextStyle(color: Colors.grey)),
                          const SizedBox(height: 5),
                          TextFormField(
                            decoration: const InputDecoration(
                              hintText: " Enter Model Number",
                              labelText: 'Model Number',
                            ),
                            initialValue: "353gg2",
                            validator: isInputEmpty,
                            onSaved: (value) {
                              // user.firstName = value!;
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.45,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 10),
                          const Text("Total variant",
                              style: TextStyle(color: Colors.grey)),
                          const SizedBox(height: 5),
                          TextFormField(
                            decoration: const InputDecoration(
                              hintText: " Enter Total variant",
                              labelText: 'Total variant',
                            ),
                            initialValue: "Total variant",
                            validator: isInputEmpty,
                            onSaved: (value) {
                              // user.firstName = value!;
                            },
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                // inventory here
                const SizedBox(height: 20),
                const Text("Variation",
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 20),
                VariationWidget(
                  mapData: const {},
                  onItemSelected: (mapData) {
                    // user.vaue = mapData
                    print(mapData);
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text("Save Changes"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
