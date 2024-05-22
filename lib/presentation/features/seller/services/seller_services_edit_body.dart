import 'dart:convert';

import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sondya_app/data/remote/home.dart';
import 'package:sondya_app/data/remote/seller.service.dart';
import 'package:sondya_app/domain/models/home.dart';
import 'package:sondya_app/domain/models/service.dart';
import 'package:sondya_app/domain/providers/seller.service.provider.dart';
import 'package:sondya_app/presentation/widgets/image_selection.dart';
import 'package:sondya_app/presentation/widgets/select_widget.dart';
import 'package:sondya_app/presentation/widgets/success_error_message.dart';
import 'package:sondya_app/presentation/widgets/threebounce_loader.dart';
import 'package:sondya_app/utils/decode_json.dart';
import 'package:sondya_app/utils/input_validations.dart';

class SellerServicesEditBody extends ConsumerStatefulWidget {
  final String id;
  const SellerServicesEditBody({super.key, required this.id});

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

  late ServiceDataModel service;

  @override
  void initState() {
    super.initState();
    service = ServiceDataModel();
    // Initialize the variable in initState
  }

  @override
  Widget build(BuildContext context) {
    final AsyncValue<Map<String, dynamic>> checkState =
        ref.watch(sellerEditServiceProvider);

    final getServiceCategory = ref.watch(getServiceCategoryProvider);

    final sellerServiceData =
        ref.watch(getSellerServicesDetailsProvider(widget.id));
    return SingleChildScrollView(
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(8.0),
          child: sellerServiceData.when(
            data: (data) {
              if (data['country'].isNotEmpty && _selectedCountry == "Country") {
                _selectedCountry = data['country'];
                service.country = _selectedCountry;
              }

              if (data['service_status'].isNotEmpty &&
                  _selectedStatus == "Status") {
                _selectedStatus = data['service_status'];
                service.serviceStatus = _selectedStatus;
              }

              if (data['sub_category'].isNotEmpty &&
                  _selectedCategory == "Category") {
                _selectedCategory = data['sub_category'];
                service.subCategory = _selectedCategory;
              }

              if (service.deleteImageId == null ||
                  service.deleteImageId == "") {
                service.deleteImageId = "[]";
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
                    const Text("Service Name",
                        style: TextStyle(color: Colors.grey)),
                    const SizedBox(height: 5),
                    TextFormField(
                      decoration: const InputDecoration(
                        hintText: " Enter Service Name",
                      ),
                      initialValue: data["name"] ?? "",
                      validator: isInputEmpty,
                      onSaved: (value) {
                        service.name = value!;
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
                      ),
                      initialValue: data["brief_description"] ?? "",
                      validator: isInputEmpty,
                      onSaved: (value) {
                        service.briefDescription = value!;
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
                        hintText: " Enter Description",
                      ),
                      initialValue: data["description"] ?? "",
                      validator: isInputEmpty,
                      onSaved: (value) {
                        service.description = value!;
                      },
                    ),
                    const SizedBox(height: 10),
                    const Text("Service Category",
                        style: TextStyle(color: Colors.grey)),
                    const SizedBox(height: 5),
                    getServiceCategory.when(
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
                                  service.subCategory = value;
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
                      // validator: isInputEmpty,
                      onSaved: (value) {
                        service.tags = value!;
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
                              service.serviceStatus = value;
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
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    SondyaMultipleImageSelection(
                      savedNetworkImage:
                          data["image"] != null && data["image"].isNotEmpty
                              ? (data["image"] as List)
                                  .map((e) => ImageType.fromJson(e))
                                  .toList()
                              : null,
                      onSetDeletedImageId: (value) {
                        service.deleteImageId = jsonEncode(value);
                      },
                      onSetImage: (value) {
                        service.image = value;
                      },
                    ),
                    const SizedBox(height: 10),
                    const Text("Pricing",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    const Text("Service Price(USD)",
                        style: TextStyle(color: Colors.grey)),
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
                          service.currentPrice = double.parse(value!);
                        } else {
                          service.currentPrice = 0.0;
                        }
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
                              const Text("Service Duration",
                                  style: TextStyle(color: Colors.grey)),
                              const SizedBox(height: 5),
                              TextFormField(
                                decoration: const InputDecoration(
                                  hintText: " Enter Service Duration",
                                ),
                                initialValue: data["duration"] ?? "",
                                validator: isInputEmpty,
                                onSaved: (value) {
                                  service.duration = value;
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
                                    service.oldPrice = double.parse(value!);
                                  } else {
                                    service.oldPrice = 0.0;
                                  }
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
                      ),
                      initialValue: data["location_description"] ?? "",
                      validator: isInputEmpty,
                      onSaved: (value) {
                        service.locationDescription = value;
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
                                ),
                                initialValue: data["phone_number"] ?? "",
                                validator: isInputEmpty,
                                onSaved: (value) {
                                  service.phoneNumber = value;
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
                                ),
                                initialValue: data["phone_number_backup"] ?? "",
                                validator: isInputEmpty,
                                onSaved: (value) {
                                  service.phoneNumberBackup = value;
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
                                ),
                                initialValue: data["email"] ?? "",
                                validator: isInputEmpty,
                                onSaved: (value) {
                                  service.email = value;
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
                                ),
                                initialValue: data["website_link"] ?? "",
                                validator: isInputEmpty,
                                onSaved: (value) {
                                  service.websiteLink = value;
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
                                    String filePath =
                                        "assets/data/countries.json";
                                    List<dynamic> countries =
                                        await loadJsonAsset<dynamic>(filePath);
                                    // ignore: use_build_context_synchronously
                                    SondyaSelectWidget()
                                        .showBottomSheet<String>(
                                      options: countries.cast<String>(),
                                      context: context,
                                      onItemSelected: (value) {
                                        setState(() {
                                          _selectedCountry = value;
                                        });
                                        service.country = value;
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
                                ),
                                initialValue: data["state"] ?? "",
                                validator: isInputEmpty,
                                onSaved: (value) {
                                  service.state = value;
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
                                ),
                                initialValue: data["city"] ?? "",
                                validator: isInputEmpty,
                                onSaved: (value) {
                                  service.city = value;
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
                                ),
                                initialValue: data["map_location_link"] ?? "",
                                validator: isInputEmpty,
                                onSaved: (value) {
                                  service.mapLocationLink = value;
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
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();

                            service.category = "service";
                            service.currency = "USD";

                            await ref
                                .read(sellerEditServiceProvider.notifier)
                                .editService(service, data["_id"]);

                            // ignore: unused_result
                            ref.refresh(
                                getSellerServicesDetailsProvider(widget.id));
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
