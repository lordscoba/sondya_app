import 'dart:convert';

import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sondya_app/data/remote/home.dart';
import 'package:sondya_app/domain/providers/seller.product.provider.dart';
import 'package:sondya_app/presentation/widgets/image_selection.dart';
import 'package:sondya_app/presentation/widgets/select_widget.dart';
import 'package:sondya_app/presentation/widgets/success_error_message.dart';
import 'package:sondya_app/presentation/widgets/threebounce_loader.dart';
import 'package:sondya_app/presentation/widgets/variants_widget.dart';

class SellerProductsAddBody extends ConsumerStatefulWidget {
  const SellerProductsAddBody({super.key});

  @override
  ConsumerState<SellerProductsAddBody> createState() =>
      _SellerProductsAddBodyState();
}

class _SellerProductsAddBodyState extends ConsumerState<SellerProductsAddBody> {
  String current = "1"; // 1, 2, 3
  List<String> done = []; // if done contains 1, 2, 3, it means all is done

  @override
  Widget build(BuildContext context) {
    final AsyncValue<Map<String, dynamic>> checkState =
        ref.watch(sellerAddProductProvider);
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
            Container(
              margin: const EdgeInsets.all(8.0),
              padding:
                  const EdgeInsets.symmetric(vertical: 40.0, horizontal: 12.0),
              // add border decoration
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: Theme.of(context).colorScheme.background,
                // add shadow
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                children: [
                  checkState.when(
                    data: (data) {
                      if (data.isNotEmpty) {
                        WidgetsBinding.instance.addPostFrameCallback(
                            (_) => context.push('/seller/products/status'));
                      }
                      return sondyaDisplaySuccessMessage(
                          context, data["message"]);
                    },
                    loading: () => const SizedBox(),
                    error: (error, stackTrace) {
                      return sondyaDisplayErrorMessage(
                          error.toString(), context);
                    },
                  ),
                  Row(
                    children: [
                      AddProdModalButton(
                        done: done.contains("1"),
                        selected: current == "1",
                        title: "Steps 01",
                        subtitle: 'Basic Info',
                        onTap: () {
                          setState(() {
                            current = "1";
                          });
                        },
                      ),
                      AddProdModalButton(
                        done: done.contains("2"),
                        selected: current == "2",
                        title: 'Steps 02',
                        subtitle: 'Advance Info',
                        onTap: () {
                          setState(() {
                            current = "2";
                          });
                        },
                      ),
                      AddProdModalButton(
                        done: done.contains("3"),
                        selected: current == "3",
                        title: 'Steps 03',
                        subtitle: 'Post Product',
                        onTap: () {
                          setState(() {
                            current = "3";
                          });
                        },
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Column(
                    children: [
                      if (current == "1")
                        AddModalBody1(
                          onPressed: () {
                            setState(() {
                              done.add("1");
                              current = "2";
                            });
                          },
                        ),
                      if (current == "2")
                        AddModalBody2(
                          onPressed: () {
                            setState(() {
                              done.add("2");
                              current = "3";
                            });
                          },
                        ),
                      if (current == "3")
                        AddModalBody3(
                          onPressed: () {
                            setState(() {
                              done.add("3");
                            });
                            if (!done.contains("1")) {
                              AnimatedSnackBar.rectangle(
                                'Error',
                                "You are not done with step 1, if you are done with step 01 click on save in step 01",
                                type: AnimatedSnackBarType.warning,
                                brightness: Brightness.light,
                              ).show(
                                context,
                              );
                            } else if (!done.contains("2")) {
                              AnimatedSnackBar.rectangle(
                                'Error',
                                "You are not done with step 1 or step 2, if you are done with step 01 or step 02 click on save in step 02",
                                type: AnimatedSnackBarType.warning,
                                brightness: Brightness.light,
                              ).show(
                                context,
                              );
                            } else {
                              ref
                                  .read(sellerAddProductProvider.notifier)
                                  .addProduct(ref
                                      .watch(sellerProductDataprovider.notifier)
                                      .state);
                            }
                          },
                        ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class AddModalBody1 extends ConsumerStatefulWidget {
  final void Function()? onPressed;
  const AddModalBody1({super.key, this.onPressed});

  @override
  ConsumerState<AddModalBody1> createState() => _AddModalBody1State();
}

class _AddModalBody1State extends ConsumerState<AddModalBody1> {
  var _selectedCategory = "Category";
  var _selectedStatus = "Status";

  late TextEditingController _nameController;
  late TextEditingController _brandController;
  late TextEditingController _tagsController;
  late TextEditingController _countryController;
  late TextEditingController _stateController;
  late TextEditingController _cityController;
  late TextEditingController _zipCodeController;
  late TextEditingController _addressController;

  @override
  void initState() {
    super.initState();
    var products = ref.read(sellerProductDataprovider.notifier).state;
    _nameController = TextEditingController(text: products.name);
    _brandController = TextEditingController(text: products.brand);
    _tagsController = TextEditingController(text: products.tag);
    _countryController = TextEditingController(text: products.country);
    _stateController = TextEditingController(text: products.state);
    _cityController = TextEditingController(text: products.city);
    _zipCodeController = TextEditingController(text: products.zipCode);
    _addressController = TextEditingController(text: products.address);
    if (products.subCategory != null) {
      _selectedCategory = products.subCategory!;
    }
    if (products.productStatus != null) {
      _selectedStatus = products.productStatus!;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _brandController.dispose();
    _tagsController.dispose();
    _countryController.dispose();
    _stateController.dispose();
    _cityController.dispose();
    _zipCodeController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var products = ref.watch(sellerProductDataprovider.notifier).state;
    final getProductCategory = ref.watch(getProductCategoryProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Product Name", style: TextStyle(color: Colors.grey)),
        const SizedBox(height: 5),
        TextField(
          controller: _nameController,
          decoration: const InputDecoration(
            hintText: " Enter Product Name",
          ),
          onChanged: (value) {
            products.name = value;
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
                  const Text("Status", style: TextStyle(color: Colors.grey)),
                  const SizedBox(height: 5),
                  SizedBox(
                    width: double.infinity,
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
                            products.productStatus = value;
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
                ],
              ),
            ),
            getProductCategory.when(
              data: (data) {
                return SizedBox(
                  width: MediaQuery.of(context).size.width * 0.45,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      const Text("Sub Category",
                          style: TextStyle(color: Colors.grey)),
                      const SizedBox(height: 5),
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton(
                          onPressed: () async {
                            List<String> subCategoryList = [];
                            for (var element in data["data"]) {
                              subCategoryList.add(element["name"]);
                            }
                            SondyaSelectWidget().showBottomSheet<String>(
                              options: subCategoryList,
                              context: context,
                              onItemSelected: (value) {
                                products.category = "product";
                                products.subCategory = value;
                                setState(() {
                                  // subCategory = value;
                                  _selectedCategory = value;
                                });
                              },
                            );
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.22,
                                child: Text(
                                  _selectedCategory,
                                  style: const TextStyle(fontSize: 12),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              const Icon(Icons.arrow_drop_down),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
              error: (error, stackTrace) => Text(error.toString()),
              loading: () => const Center(
                child: CupertinoActivityIndicator(
                  radius: 50,
                ),
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
                  const Text("Brand", style: TextStyle(color: Colors.grey)),
                  const SizedBox(height: 5),
                  TextField(
                    controller: _brandController,
                    decoration: const InputDecoration(
                      hintText: " Enter Brand",
                    ),
                    onChanged: (value) {
                      products.brand = value;
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
                  const Text("Tags", style: TextStyle(color: Colors.grey)),
                  const SizedBox(height: 5),
                  TextField(
                    controller: _tagsController,
                    decoration: const InputDecoration(
                      hintText: " Enter Tags",
                    ),
                    onChanged: (value) {
                      products.tag = value;
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
                  const Text("Country", style: TextStyle(color: Colors.grey)),
                  const SizedBox(height: 5),
                  TextField(
                    controller: _countryController,
                    decoration: const InputDecoration(
                      hintText: " Enter Country",
                    ),
                    onChanged: (value) {
                      products.country = value;
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
                  const Text("State", style: TextStyle(color: Colors.grey)),
                  const SizedBox(height: 5),
                  TextField(
                    controller: _stateController,
                    decoration: const InputDecoration(
                      hintText: " Enter State",
                    ),
                    onChanged: (value) {
                      products.state = value;
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
                  const Text("City", style: TextStyle(color: Colors.grey)),
                  const SizedBox(height: 5),
                  TextField(
                    controller: _cityController,
                    decoration: const InputDecoration(
                      hintText: " Enter City",
                    ),
                    onChanged: (value) {
                      products.city = value;
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
                  const Text("Zip Code", style: TextStyle(color: Colors.grey)),
                  const SizedBox(height: 5),
                  TextField(
                    controller: _zipCodeController,
                    decoration: const InputDecoration(
                      hintText: " Enter Zip Code",
                    ),
                    onChanged: (value) {
                      products.zipCode = value;
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
        TextField(
          controller: _addressController,
          decoration: const InputDecoration(
            hintText: " Enter Address",
          ),
          onChanged: (value) {
            products.address = value;
          },
        ),
        const SizedBox(height: 10),
        const Divider(),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.45,
              height: 50,
              child: OutlinedButton(
                onPressed: () {},
                child: const Text("View Rules"),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.45,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  if (_nameController.text == "" ||
                      _brandController.text == "" ||
                      _tagsController.text == "" ||
                      _countryController.text == "" ||
                      _stateController.text == "" ||
                      _cityController.text == "" ||
                      _zipCodeController.text == "" ||
                      _addressController.text == "" ||
                      _addressController.text == "" ||
                      _selectedCategory == "Category" ||
                      _selectedStatus == "Status") {
                    AnimatedSnackBar.rectangle(
                      'Error',
                      "Please fill all the fields",
                      type: AnimatedSnackBarType.warning,
                      brightness: Brightness.light,
                    ).show(
                      context,
                    );
                  } else {
                    widget.onPressed!();
                  }
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text("Save"),
                    SizedBox(width: 3),
                    Icon(Icons.arrow_forward),
                  ],
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}

class AddModalBody2 extends ConsumerStatefulWidget {
  final void Function()? onPressed;
  const AddModalBody2({super.key, this.onPressed});

  @override
  ConsumerState<AddModalBody2> createState() => _AddModalBody2State();
}

class _AddModalBody2State extends ConsumerState<AddModalBody2> {
  List<XFile> image = [];

  late TextEditingController _descriptionController;
  late TextEditingController _currentPriceController;
  late TextEditingController _oldPriceController;
  late TextEditingController _discountPercentageController;
  late TextEditingController _totalStockController;
  late TextEditingController _vatAmountController;

  @override
  void initState() {
    super.initState();
    var products = ref.read(sellerProductDataprovider.notifier).state;
    _descriptionController = TextEditingController(text: products.description);
    _currentPriceController = TextEditingController(
        text: products.currentPrice.toString() == "null"
            ? "0.0"
            : products.currentPrice.toString());
    _oldPriceController = TextEditingController(
        text: products.oldPrice.toString() == "null"
            ? "0.0"
            : products.oldPrice.toString());
    _discountPercentageController = TextEditingController(
        text: products.discountPercentage.toString() == "null"
            ? "0.0"
            : products.discountPercentage.toString());
    _totalStockController = TextEditingController(
        text: products.totalStock.toString() == "null"
            ? "0"
            : products.totalStock.toString());
    _vatAmountController = TextEditingController(
        text: products.vatPercentage.toString() == "null"
            ? "0.0"
            : products.vatPercentage.toString());

    if (products.image != null) {
      image = products.image!;
    }
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    _currentPriceController.dispose();
    _oldPriceController.dispose();
    _discountPercentageController.dispose();
    _totalStockController.dispose();
    _vatAmountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var products = ref.watch(sellerProductDataprovider.notifier).state;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        const Text("Description", style: TextStyle(color: Colors.grey)),
        const SizedBox(height: 5),
        TextField(
          controller: _descriptionController,
          maxLines: 3,
          decoration: const InputDecoration(
            hintText: " Enter Description",
          ),
          onChanged: (value) {
            products.description = value;
          },
        ),
        const SizedBox(height: 10),
        const Text("Pricing",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        const Text("Price", style: TextStyle(color: Colors.grey)),
        const SizedBox(height: 5),
        TextField(
          controller: _currentPriceController,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
          ],
          decoration: const InputDecoration(
            hintText: "Enter Price",
          ),
          onChanged: (value) {
            if (value != "") {
              products.currentPrice = double.parse(value);
            } else {
              products.currentPrice = 0.0;
            }
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
                  const Text("Old Price", style: TextStyle(color: Colors.grey)),
                  const SizedBox(height: 5),
                  TextField(
                    controller: _oldPriceController,
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
                    ],
                    decoration: const InputDecoration(
                      hintText: " Enter Old Price",
                    ),
                    onChanged: (value) {
                      if (value != "") {
                        products.oldPrice = double.parse(value);
                      } else {
                        products.oldPrice = 0.0;
                      }
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
                  TextField(
                    controller: _discountPercentageController,
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
                    ],
                    decoration: const InputDecoration(
                      hintText: " Enter Discount Precentage (%)",
                    ),
                    onChanged: (value) {
                      if (value != "") {
                        products.discountPercentage = double.parse(value);
                      } else {
                        products.discountPercentage = 0.0;
                      }
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
                  TextField(
                    controller: _totalStockController,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    decoration: const InputDecoration(
                      hintText: " Enter Total Stock",
                    ),
                    onChanged: (value) {
                      if (value != "") {
                        products.totalStock = int.parse(value);
                      } else {
                        products.totalStock = 0;
                      }
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
                  TextField(
                    controller: _vatAmountController,
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
                    ],
                    decoration: const InputDecoration(
                      hintText: " Enter VAT Amount (%)",
                    ),
                    onChanged: (value) {
                      if (value != "") {
                        products.vatPercentage = double.parse(value);
                      } else {
                        products.vatPercentage = 0.0;
                      }
                    },
                  ),
                ],
              ),
            )
          ],
        ),
        const SizedBox(height: 20),
        const Text("Media",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        SondyaMultipleImageSelection(
          savedFileImage: image.isNotEmpty ? image : null,
          onSetImage: (value) {
            setState(() {
              image = value;
            });
            products.image = value;
          },
        ),
        const SizedBox(height: 10),
        const Divider(),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.45,
              height: 50,
              child: OutlinedButton(
                onPressed: () {},
                child: const Text("View Rules"),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.45,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  if (_descriptionController.text == "" ||
                      _currentPriceController.text == "0.0" ||
                      _oldPriceController.text == "0.0" ||
                      _discountPercentageController.text == "0.0" ||
                      _totalStockController.text == "0" ||
                      _vatAmountController.text == "0.0" ||
                      image.isEmpty) {
                    AnimatedSnackBar.rectangle(
                      'Error',
                      "Please fill all the fields",
                      type: AnimatedSnackBarType.warning,
                      brightness: Brightness.light,
                    ).show(
                      context,
                    );
                  } else {
                    widget.onPressed!();
                  }
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text("Save"),
                    SizedBox(width: 3),
                    Icon(Icons.arrow_forward),
                  ],
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}

class AddModalBody3 extends ConsumerStatefulWidget {
  final void Function()? onPressed;
  const AddModalBody3({super.key, this.onPressed});

  @override
  ConsumerState<AddModalBody3> createState() => _AddModalBody3State();
}

class _AddModalBody3State extends ConsumerState<AddModalBody3> {
  Map<String, List<dynamic>>? variants = {};

  late TextEditingController _modelNumberController;
  late TextEditingController _totalVariantController;

  @override
  void initState() {
    super.initState();
    var products = ref.read(sellerProductDataprovider.notifier).state;
    _modelNumberController = TextEditingController(text: products.model);
    _totalVariantController = TextEditingController(
        text: products.totalVariants.toString() == "null"
            ? "0"
            : products.totalVariants.toString());
    if (products.variants != null && products.variants != {}) {
      variants = json.decode(products.variants!);
    }
  }

  @override
  void dispose() {
    _modelNumberController.dispose();
    _totalVariantController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var products = ref.watch(sellerProductDataprovider.notifier).state;
    final AsyncValue<Map<String, dynamic>> checkState =
        ref.watch(sellerAddProductProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        const Text("Inventory",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
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
                  TextField(
                    controller: _modelNumberController,
                    decoration: const InputDecoration(
                      hintText: " Enter Model Number",
                    ),
                    onChanged: (value) {
                      products.model = value;
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
                  TextField(
                    controller: _totalVariantController,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    decoration: const InputDecoration(
                      hintText: " Enter Total variant",
                    ),
                    onChanged: (value) {
                      if (value != "") {
                        products.totalVariants = int.parse(value);
                      } else {
                        products.totalVariants = 0;
                      }
                    },
                  ),
                ],
              ),
            )
          ],
        ),
        // inventory here
        const SizedBox(height: 10),
        const Text("Variation",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        VariationWidget(
          mapData: variants!,
          onItemSelected: (mapData) {
            setState(() {
              variants = mapData;
            });
            products.variants = jsonEncode(mapData);
          },
        ),
        const SizedBox(height: 10),
        const Divider(),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.45,
              height: 50,
              child: OutlinedButton(
                onPressed: () {},
                child: const Text("View Rules"),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.45,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  if (_modelNumberController.text == "" ||
                      _totalVariantController.text == "0" ||
                      variants == {}) {
                    AnimatedSnackBar.rectangle(
                      'Error',
                      "Please fill all the fields",
                      type: AnimatedSnackBarType.warning,
                      brightness: Brightness.light,
                    ).show(
                      context,
                    );
                  } else {
                    widget.onPressed!();
                  }
                },
                child: checkState.isLoading
                    ? sondyaThreeBounceLoader(color: Colors.white)
                    : const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text("Post"),
                          SizedBox(width: 3),
                          Icon(Icons.arrow_forward),
                        ],
                      ),
              ),
            )
          ],
        ),
      ],
    );
  }
}

class AddProdModalButton extends StatelessWidget {
  final bool done;
  final bool selected;
  final String title;
  final String subtitle;
  final void Function()? onTap;
  const AddProdModalButton(
      {super.key,
      required this.title,
      required this.subtitle,
      this.onTap,
      required this.selected,
      required this.done});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(5),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image(
                    image: selected
                        ? const AssetImage("assets/icons/add_icon_2.png")
                        : done
                            ? const AssetImage("assets/icons/add_icon_1.png")
                            : const AssetImage("assets/icons/add_icon_3.png"),
                    fit: BoxFit.cover,
                    width: 20,
                    height: 20),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      subtitle,
                      style: const TextStyle(color: Color(0xFF767E94)),
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: 70,
              child: Divider(
                color: selected ? const Color(0xFFEDB842) : Colors.transparent,
                thickness: 3.0,
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
