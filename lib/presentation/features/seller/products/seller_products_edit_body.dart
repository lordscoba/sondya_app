import 'dart:convert';

import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sondya_app/data/remote/home.dart';
import 'package:sondya_app/data/remote/seller.product.dart';
import 'package:sondya_app/domain/models/home.dart';
import 'package:sondya_app/domain/models/product.dart';
import 'package:sondya_app/domain/providers/seller.product.provider.dart';
import 'package:sondya_app/presentation/widgets/image_selection.dart';
import 'package:sondya_app/presentation/widgets/select_widget.dart';
import 'package:sondya_app/presentation/widgets/success_error_message.dart';
import 'package:sondya_app/presentation/widgets/threebounce_loader.dart';
import 'package:sondya_app/presentation/widgets/variants_widget.dart';
import 'package:sondya_app/utils/input_validations.dart';

class SellerProductsEditBody extends ConsumerStatefulWidget {
  final String id;
  const SellerProductsEditBody({
    super.key,
    required this.id,
  });

  @override
  ConsumerState<SellerProductsEditBody> createState() =>
      _SellerProductsEditBodyState();
}

class _SellerProductsEditBodyState
    extends ConsumerState<SellerProductsEditBody> {
  final _formKey = GlobalKey<FormState>();
  var _selectedCategory = "Category";
  var _selectedStatus = "Status";

  late ProductDataModel product;

  @override
  void initState() {
    super.initState();
    product = ProductDataModel();
    // Initialize the variable in initState
  }

  @override
  Widget build(BuildContext context) {
    final AsyncValue<Map<String, dynamic>> checkState =
        ref.watch(sellerEditProductProvider);
    final getProductCategory = ref.watch(getProductCategoryProvider);

    final sellerProductData =
        ref.watch(getSellerProductsDetailsProvider(widget.id));

    return SingleChildScrollView(
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(8.0),
          child: sellerProductData.when(
            data: (data) {
              if (data['product_status'].isNotEmpty &&
                  _selectedStatus == "Status") {
                _selectedStatus = data['product_status'];
                product.productStatus = _selectedStatus;
              }

              if (data['sub_category'].isNotEmpty &&
                  _selectedCategory == "Category") {
                _selectedCategory = data['sub_category'];
                product.subCategory = _selectedCategory;
              }

              if (data["variants"] == null || data["variants"].isEmpty) {
                product.variants = "{}";
              } else {
                product.variants = jsonEncode(data["variants"]);
              }

              if (product.deleteImageId == null ||
                  product.deleteImageId == "") {
                product.deleteImageId = "[]";
              }

              return Form(
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
                    checkState.when(
                      data: (data) {
                        return sondyaDisplaySuccessMessage(
                            context, data["message"]);
                      },
                      loading: () => const SizedBox(),
                      error: (error, stackTrace) {
                        return sondyaDisplayErrorMessage(
                            error.toString(), context);
                      },
                    ),
                    const SizedBox(height: 20),
                    const Text("Category",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 20),
                    const Text("Product Name",
                        style: TextStyle(color: Colors.grey)),
                    const SizedBox(height: 5),
                    TextFormField(
                      decoration: const InputDecoration(
                        hintText: " Enter Product Name",
                      ),
                      initialValue: data["name"] ?? "",
                      validator: isInputEmpty,
                      onSaved: (value) {
                        product.name = value;
                      },
                    ),
                    const SizedBox(height: 10),
                    const Text("Brand Name",
                        style: TextStyle(color: Colors.grey)),
                    const SizedBox(height: 5),
                    TextFormField(
                      decoration: const InputDecoration(
                        hintText: " Enter Brand Name",
                      ),
                      initialValue: data["brand"] ?? "",
                      validator: isInputEmpty,
                      onSaved: (value) {
                        product.brand = value;
                      },
                    ),
                    const SizedBox(height: 10),
                    const Text("Description",
                        style: TextStyle(color: Colors.grey)),
                    const SizedBox(height: 5),
                    // text area
                    TextFormField(
                      maxLines: 3,
                      decoration: const InputDecoration(
                        hintText: " Enter Product Name",
                      ),
                      initialValue: data["description"] ?? "",
                      validator: isInputEmpty,
                      onSaved: (value) {
                        product.description = value;
                      },
                    ),
                    const SizedBox(height: 10),
                    const Text("Product Category",
                        style: TextStyle(color: Colors.grey)),
                    const SizedBox(height: 5),
                    getProductCategory.when(
                      data: (data) {
                        return SizedBox(
                          width: double.infinity,
                          height: 50,
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
                                  setState(() {
                                    _selectedCategory = value;
                                  });
                                  product.subCategory = value;
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
                        );
                      },
                      error: (error, stackTrace) => Text(error.toString()),
                      loading: () => const Center(
                        child: CupertinoActivityIndicator(
                          radius: 50,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text("Tag Name",
                        style: TextStyle(color: Colors.grey)),
                    const SizedBox(height: 5),
                    TextFormField(
                      decoration: const InputDecoration(
                        hintText: " Enter Tag Name",
                      ),
                      initialValue: data["tag"] ?? "",
                      validator: isInputEmpty,
                      onSaved: (value) {
                        product.tag = value;
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
                              product.productStatus = value;
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
                                ),
                                initialValue: data["country"] ?? "",
                                validator: isInputEmpty,
                                onSaved: (value) {
                                  product.country = value;
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
                                ),
                                initialValue: data["state"] ?? "",
                                validator: isInputEmpty,
                                onSaved: (value) {
                                  product.state = value;
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
                                ),
                                initialValue: data["city"] ?? "",
                                validator: isInputEmpty,
                                onSaved: (value) {
                                  product.city = value;
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
                                ),
                                initialValue: data["zip_code"] ?? "",
                                validator: isInputEmpty,
                                onSaved: (value) {
                                  product.zipCode = value;
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
                      ),
                      initialValue: data["address"] ?? "",
                      validator: isInputEmpty,
                      onSaved: (value) {
                        product.address = value;
                      },
                    ),
                    // media space
                    const SizedBox(height: 20),
                    const Text("Media",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 20),
                    SondyaMultipleImageSelection(
                      savedNetworkImage:
                          data["image"] != null && data["image"].isNotEmpty
                              ? (data["image"] as List)
                                  .map((e) => ImageType.fromJson(e))
                                  .toList()
                              : null,
                      onSetDeletedImageId: (value) {
                        product.deleteImageId = jsonEncode(value);
                      },
                      onSetImage: (value) {
                        product.image = value;
                      },
                    ),
                    const SizedBox(height: 20),
                    const Text("Pricing",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    const Text("Price", style: TextStyle(color: Colors.grey)),
                    const SizedBox(height: 5),
                    TextFormField(
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(
                            RegExp(r'^\d*\.?\d*')),
                      ],
                      decoration: const InputDecoration(
                        hintText: "Enter Price",
                      ),
                      initialValue: data["current_price"].toString(),
                      validator: isInputEmpty,
                      onSaved: (value) {
                        if (value != "") {
                          product.currentPrice = double.parse(value!);
                        } else {
                          product.currentPrice = 0.0;
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
                              const Text("Old Price",
                                  style: TextStyle(color: Colors.grey)),
                              const SizedBox(height: 5),
                              TextFormField(
                                keyboardType:
                                    const TextInputType.numberWithOptions(
                                        decimal: true),
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'^\d*\.?\d*')),
                                ],
                                decoration: const InputDecoration(
                                  hintText: " Enter Old Price",
                                ),
                                initialValue: data["old_price"].toString(),
                                validator: isInputEmpty,
                                onSaved: (value) {
                                  if (value != "") {
                                    product.oldPrice = double.parse(value!);
                                  } else {
                                    product.oldPrice = 0.0;
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
                              TextFormField(
                                keyboardType:
                                    const TextInputType.numberWithOptions(
                                        decimal: true),
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'^\d*\.?\d*')),
                                ],
                                decoration: const InputDecoration(
                                  hintText: " Enter Discount Precentage (%)",
                                ),
                                initialValue:
                                    data["discount_percentage"].toString(),
                                validator: isInputEmpty,
                                onSaved: (value) {
                                  if (value != "") {
                                    product.discountPercentage =
                                        double.parse(value!);
                                  } else {
                                    product.discountPercentage = 0.0;
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
                              TextFormField(
                                keyboardType: TextInputType.number,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                decoration: const InputDecoration(
                                  hintText: " Enter Total Stock",
                                ),
                                initialValue: data["total_stock"].toString(),
                                validator: isInputEmpty,
                                onSaved: (value) {
                                  if (value != "") {
                                    product.totalStock = int.parse(value!);
                                  } else {
                                    product.totalStock = 0;
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
                              TextFormField(
                                keyboardType:
                                    const TextInputType.numberWithOptions(
                                        decimal: true),
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'^\d*\.?\d*')),
                                ],
                                decoration: const InputDecoration(
                                  hintText: " Enter VAT Amount (%)",
                                ),
                                initialValue: data["vat_percentage"].toString(),
                                validator: isInputEmpty,
                                onSaved: (value) {
                                  if (value != "") {
                                    product.vatPercentage =
                                        double.parse(value!);
                                  } else {
                                    product.vatPercentage = 0.0;
                                  }
                                },
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 20),
                    const Text("Inventory",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
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
                                ),
                                initialValue: data["model"] ?? "",
                                validator: isInputEmpty,
                                onSaved: (value) {
                                  product.model = value;
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
                                keyboardType: TextInputType.number,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                decoration: const InputDecoration(
                                  hintText: " Enter Total variant",
                                ),
                                initialValue: data["total_variants"].toString(),
                                validator: isInputEmpty,
                                onSaved: (value) {
                                  if (value != "") {
                                    product.totalVariants = int.parse(value!);
                                  } else {
                                    product.totalVariants = 0;
                                  }
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
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    VariationWidget(
                      mapData: data["variants"] != null &&
                              data["variants"].isNotEmpty
                          ? data["variants"].cast<String, List<dynamic>>()
                          : const {},
                      onItemSelected: (mapData) {
                        // print(mapData);
                        product.variants = jsonEncode(mapData);
                      },
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();

                          await ref
                              .read(sellerEditProductProvider.notifier)
                              .editProduct(product, data["_id"]);

                          // ignore: unused_result
                          ref.refresh(
                              getSellerProductsDetailsProvider(widget.id));
                        } else {
                          AnimatedSnackBar.rectangle(
                            'Error',
                            "Please fill all the fields",
                            type: AnimatedSnackBarType.warning,
                            brightness: Brightness.light,
                          ).show(
                            context,
                          );
                        }
                      },
                      child: checkState.isLoading
                          ? sondyaThreeBounceLoader(color: Colors.white)
                          : const Text("Save Changes"),
                    ),
                  ],
                ),
              );
            },
            error: (error, stackTrace) {
              return Text(error.toString());
            },
            loading: () {
              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
