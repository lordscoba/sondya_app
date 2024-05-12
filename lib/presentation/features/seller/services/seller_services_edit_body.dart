import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sondya_app/domain/models/home.dart';
import 'package:sondya_app/presentation/features/seller/products/seller_products_add_body.dart';
import 'package:sondya_app/presentation/widgets/image_selection.dart';
import 'package:sondya_app/presentation/widgets/select_widget.dart';
import 'package:sondya_app/utils/decode_json.dart';
import 'package:sondya_app/utils/input_validations.dart';

class SellerServicesEditBody extends ConsumerStatefulWidget {
  const SellerServicesEditBody({super.key});

  @override
  ConsumerState<SellerServicesEditBody> createState() =>
      _SellerServicesEditBodyState();
}

class _SellerServicesEditBodyState
    extends ConsumerState<SellerServicesEditBody> {
  final _formKey = GlobalKey<FormState>();
  String _selectedCountry = "Country";
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
                const Text("Service Name",
                    style: TextStyle(color: Colors.grey)),
                const SizedBox(height: 5),
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: " Enter Service Name",
                    labelText: 'Service Name',
                  ),
                  initialValue: "Service Name",
                  validator: isInputEmpty,
                  onSaved: (value) {
                    // user.firstName = value!;
                  },
                ),
                const SizedBox(height: 10),
                const Text("Brief Description",
                    style: TextStyle(color: Colors.grey)),
                const SizedBox(height: 5),
                TextFormField(
                  maxLines: 3,
                  decoration: const InputDecoration(
                    hintText: " Enter Brief Description",
                    labelText: 'Brief Description',
                  ),
                  initialValue: "Brief Description",
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
                    hintText: " Enter Description",
                    labelText: 'Description',
                  ),
                  initialValue: "Description",
                  validator: isInputEmpty,
                  onSaved: (value) {
                    // user.firstName = value!;
                  },
                ),
                const SizedBox(height: 10),
                const Text("Service Category",
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
                const Text(
                  "Service Status",
                  style: TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 5),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: OutlinedButton(
                    onPressed: () async {
                      List<String> sortByList = [
                        "draft",
                        "available",
                        "suspended",
                        "Closed"
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
                const SizedBox(height: 10),
                const Text("Media",
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                SondyaMultipleImageSelection(
                  savedNetworkImage:
                      ims.map((image) => ImageType.fromJson(image)).toList(),
                  onSetImage: (value) {
                    print(value);
                  },
                ),
                const SizedBox(height: 10),
                const Text("Pricing",
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                const Text("Service Price(USD)",
                    style: TextStyle(color: Colors.grey)),
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
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.45,
                      height: 50,
                      child: OutlinedButton(
                        onPressed: () async {
                          List<String> sortByList = [
                            "draft",
                            "available",
                            "suspended",
                            "Closed"
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
                          const Text("Service Duration",
                              style: TextStyle(color: Colors.grey)),
                          const SizedBox(height: 5),
                          TextFormField(
                            decoration: const InputDecoration(
                              hintText: " Enter Service Duration",
                              labelText: 'Service Duration',
                            ),
                            initialValue: "Service Duration",
                            validator: isInputEmpty,
                            onSaved: (value) {
                              // user.firstName = value!;
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const Text("Location description for service",
                    style: TextStyle(color: Colors.grey)),
                const SizedBox(height: 5),
                TextFormField(
                  maxLines: 5,
                  decoration: const InputDecoration(
                    hintText: "Location description",
                    labelText: '',
                  ),
                  initialValue: "Location description",
                  validator: isInputEmpty,
                  onSaved: (value) {
                    // user.firstName = value!;
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.45,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 10),
                          const Text("Phone Number",
                              style: TextStyle(color: Colors.grey)),
                          const SizedBox(height: 5),
                          TextFormField(
                            decoration: const InputDecoration(
                              hintText: " Enter Phone Number",
                              labelText: 'Phone Number',
                            ),
                            initialValue: "Phone Number",
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
                          const Text("Backup Phone Number (Optional)",
                              style: TextStyle(color: Colors.grey)),
                          const SizedBox(height: 5),
                          TextFormField(
                            decoration: const InputDecoration(
                              hintText: " Backup Phone Number (Optional)",
                              labelText: 'Backup Phone Number (Optional)',
                            ),
                            initialValue: "00000000000",
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
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.45,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 10),
                          const Text("Email Address",
                              style: TextStyle(color: Colors.grey)),
                          const SizedBox(height: 5),
                          TextFormField(
                            decoration: const InputDecoration(
                              hintText: "Email Address",
                              labelText: 'Email Address',
                            ),
                            initialValue: "Email Address",
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
                          const Text("Website Link (Optional)",
                              style: TextStyle(color: Colors.grey)),
                          const SizedBox(height: 5),
                          TextFormField(
                            decoration: const InputDecoration(
                              hintText: " Website Link (Optional)",
                              labelText: 'Website Link (Optional)',
                            ),
                            initialValue: "Website Link (Optional)",
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
                  crossAxisAlignment: CrossAxisAlignment.end,
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
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.45,
                            child: OutlinedButton(
                              onPressed: () async {
                                String filePath = "assets/data/countries.json";
                                List<dynamic> countries =
                                    await loadJsonAsset<dynamic>(filePath);
                                // ignore: use_build_context_synchronously
                                SondyaSelectWidget().showBottomSheet<String>(
                                  options: countries.cast<String>(),
                                  context: context,
                                  onItemSelected: (value) {
                                    setState(() {
                                      _selectedCountry = value;
                                    });
                                    // user.country = value.toString();
                                  },
                                );
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(_selectedCountry),
                                  const Icon(Icons.arrow_drop_down),
                                ],
                              ),
                            ),
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
                              hintText: "State",
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
                  crossAxisAlignment: CrossAxisAlignment.end,
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
                              hintText: "City",
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
                          const Text("Map Location (Optional)",
                              style: TextStyle(color: Colors.grey)),
                          const SizedBox(height: 5),
                          TextFormField(
                            decoration: const InputDecoration(
                              hintText: "Map Location (Optional)",
                              labelText: 'Map Location (Optional)',
                            ),
                            initialValue: "Map Location (Optional)",
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
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Text("Save Changes"),
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
