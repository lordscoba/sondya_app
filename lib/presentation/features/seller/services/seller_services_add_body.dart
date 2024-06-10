import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sondya_app/data/remote/home.dart';
import 'package:sondya_app/domain/providers/seller.service.provider.dart';
import 'package:sondya_app/presentation/widgets/image_selection.dart';
import 'package:sondya_app/presentation/widgets/select_widget.dart';
import 'package:sondya_app/presentation/widgets/success_error_message.dart';
import 'package:sondya_app/presentation/widgets/threebounce_loader.dart';
import 'package:sondya_app/utils/decode_json.dart';

class SellerServicesAddBody extends ConsumerStatefulWidget {
  const SellerServicesAddBody({super.key});

  @override
  ConsumerState<SellerServicesAddBody> createState() =>
      _SellerServicesAddBodyState();
}

class _SellerServicesAddBodyState extends ConsumerState<SellerServicesAddBody> {
  String current = "1"; // 1, 2, 3
  List<String> done = []; // if done contains 1, 2, 3, it means all is done

  @override
  Widget build(BuildContext context) {
    final AsyncValue<Map<String, dynamic>> checkState =
        ref.watch(sellerAddServiceProvider);
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
                            (_) => context.push('/seller/services/status'));
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
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: 100,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        AddServModalButton(
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
                        AddServModalButton(
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
                        AddServModalButton(
                          done: done.contains("3"),
                          selected: current == "3",
                          title: 'Steps 03',
                          subtitle: 'Post Service',
                          onTap: () {
                            setState(() {
                              current = "3";
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Column(
                    children: [
                      if (current == "1")
                        AddServModalBody1(
                          onPressed: () {
                            setState(() {
                              done.add("1");
                              current = "2";
                            });
                          },
                        ),
                      if (current == "2")
                        AddServModalBody2(
                          onPressed: () {
                            setState(() {
                              done.add("2");
                              current = "3";
                            });
                          },
                        ),
                      if (current == "3")
                        AddServModalBody3(
                          onPressed: () {
                            setState(() {
                              done.add("3");
                            });
                            if (!done.contains("1")) {
                              AnimatedSnackBar.rectangle(
                                'Error',
                                "You are not done with step 01, if you are done with step 01 click on save in step 01",
                                type: AnimatedSnackBarType.warning,
                                brightness: Brightness.light,
                              ).show(
                                context,
                              );
                            } else if (!done.contains("2")) {
                              AnimatedSnackBar.rectangle(
                                'Error',
                                "You are not done with step 2, if you are done with step 02 click on save in step 02",
                                type: AnimatedSnackBarType.warning,
                                brightness: Brightness.light,
                              ).show(
                                context,
                              );
                            } else {
                              ref
                                  .read(sellerAddServiceProvider.notifier)
                                  .addService(ref
                                      .watch(sellerServiceDataprovider.notifier)
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

class AddServModalBody1 extends ConsumerStatefulWidget {
  final void Function()? onPressed;
  const AddServModalBody1({super.key, this.onPressed});

  @override
  ConsumerState<AddServModalBody1> createState() => _AddServModalBody1State();
}

class _AddServModalBody1State extends ConsumerState<AddServModalBody1> {
  var _selectedCategory = "Category";
  var _selectedStatus = "Status";

  late TextEditingController _nameController;
  late TextEditingController _briefDescriptionController;

  @override
  void initState() {
    super.initState();
    var service = ref.read(sellerServiceDataprovider.notifier).state;
    _nameController = TextEditingController(text: service.name);
    _briefDescriptionController =
        TextEditingController(text: service.briefDescription);

    if (service.subCategory != null) {
      _selectedCategory = service.subCategory!;
    }
    if (service.serviceStatus != null) {
      _selectedStatus = service.serviceStatus!;
    }
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _briefDescriptionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var service = ref.watch(sellerServiceDataprovider.notifier).state;
    final getServiceCategory = ref.watch(getServiceCategoryProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Service Name", style: TextStyle(color: Colors.grey)),
        const SizedBox(height: 5),
        TextField(
          controller: _nameController,
          decoration: const InputDecoration(
            hintText: " Enter Service Name",
          ),
          onChanged: (value) {
            service.name = value;
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
                          "Suspended",
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
                ],
              ),
            ),
            getServiceCategory.when(
              data: (data) {
                return SizedBox(
                  width: MediaQuery.of(context).size.width * 0.42,
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
                                service.category = "service";
                                service.subCategory = value;
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
                                width: MediaQuery.of(context).size.width * 0.16,
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
        const Text("Brief Description", style: TextStyle(color: Colors.grey)),
        const SizedBox(height: 5),
        TextField(
          controller: _briefDescriptionController,
          maxLines: 3,
          decoration: const InputDecoration(
            hintText: " Enter Brief Description",
          ),
          onChanged: (value) {
            service.briefDescription = value;
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
              width: MediaQuery.of(context).size.width * 0.42,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  if (_nameController.text == "" ||
                      _briefDescriptionController.text == "" ||
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

class AddServModalBody2 extends ConsumerStatefulWidget {
  final void Function()? onPressed;
  const AddServModalBody2({super.key, this.onPressed});

  @override
  ConsumerState<AddServModalBody2> createState() => _AddServModalBody2State();
}

class _AddServModalBody2State extends ConsumerState<AddServModalBody2> {
  List<XFile> image = [];

  late TextEditingController _descriptionController;
  late TextEditingController _currentPriceController;
  late TextEditingController _oldPriceController;
  late TextEditingController _durationController;
  late TextEditingController _serviceLocationController;

  @override
  void initState() {
    super.initState();
    var service = ref.read(sellerServiceDataprovider.notifier).state;
    _descriptionController = TextEditingController(text: service.description);
    _currentPriceController = TextEditingController(
        text: service.currentPrice.toString() == "null"
            ? "0.0"
            : service.currentPrice.toString());
    _oldPriceController = TextEditingController(
        text: service.oldPrice.toString() == "null"
            ? "0.0"
            : service.oldPrice.toString());

    _durationController = TextEditingController(text: service.duration);
    _serviceLocationController =
        TextEditingController(text: service.locationDescription);
    if (service.image != null) {
      image = service.image!;
    }
  }

  @override
  void dispose() {
    super.dispose();
    _descriptionController.dispose();
    _currentPriceController.dispose();
    _oldPriceController.dispose();
    _durationController.dispose();
    _serviceLocationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var service = ref.watch(sellerServiceDataprovider.notifier).state;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        const Text("Description", style: TextStyle(color: Colors.grey)),
        const SizedBox(height: 5),
        // text area
        TextField(
          controller: _descriptionController,
          maxLines: 3,
          decoration: const InputDecoration(
            hintText: " Enter Description",
          ),
          onChanged: (value) {
            service.description = value;
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
              service.currentPrice = double.parse(value);
            } else {
              service.currentPrice = 0.0;
            }
          },
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.42,
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
                        service.oldPrice = double.parse(value);
                      } else {
                        service.oldPrice = 0.0;
                      }
                    },
                  ),
                ],
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.42,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  const Text("Duration", style: TextStyle(color: Colors.grey)),
                  const SizedBox(height: 5),
                  TextField(
                    controller: _durationController,
                    decoration: const InputDecoration(
                      hintText: "Duration",
                    ),
                    onChanged: (value) {
                      service.duration = value;
                    },
                  ),
                ],
              ),
            )
          ],
        ),
        const SizedBox(height: 10),
        const Text("Location of service", style: TextStyle(color: Colors.grey)),
        const SizedBox(height: 5),
        TextField(
          controller: _serviceLocationController,
          maxLines: 3,
          decoration: const InputDecoration(
            hintText: "Enter Location of service",
          ),
          onChanged: (value) {
            service.locationDescription = value;
          },
        ),
        const SizedBox(height: 10),
        const Text("Media",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),

        const SizedBox(height: 10),
        SondyaMultipleImageSelection(
          savedFileImage: image.isNotEmpty ? image : null,
          onSetImage: (value) {
            setState(() {
              image = value;
            });
            service.image = value;
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
              width: MediaQuery.of(context).size.width * 0.42,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  if (_descriptionController.text == "" ||
                      _currentPriceController.text == "0.0" ||
                      _oldPriceController.text == "0.0" ||
                      _durationController.text == "" ||
                      _serviceLocationController.text == "" ||
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

var ims = [
  {
    "url":
        "https://res.cloudinary.com/dyeyatchg/image/upload/v1700469639/sondya/tqrpvccrrbgz4gzkecyz.png",
    "public_id": "sondya/tqrpvccrrbgz4gzkecyz",
    "folder": "sondya",
    "_id": "655b1b87e9e25909e4909314"
  },
  {
    "url":
        "https://res.cloudinary.com/dyeyatchg/image/upload/v1700393981/sondya/kpknp9au7cyempw2jz8s.jpg",
    "public_id": "sondya/kpknp9au7cyempw2jz8s",
    "folder": "sondya",
    "_id": "6559f3ff1cc17a69f9747361"
  },
  {
    "url":
        "https://res.cloudinary.com/dyeyatchg/image/upload/v1700393981/sondya/kpknp9au7cyempw2jz8s.jpg",
    "public_id": "sondya/kpknp9au7cyempw2jz8s",
    "folder": "sondya",
    "_id": "6559f3ff1cc17a69f9747361"
  },
  {
    "url":
        "https://res.cloudinary.com/dyeyatchg/image/upload/v1700393981/sondya/kpknp9au7cyempw2jz8s.jpg",
    "public_id": "sondya/kpknp9au7cyempw2jz8s",
    "folder": "sondya",
    "_id": "6559f3ff1cc17a69f9747361"
  },
  {
    "url":
        "https://res.cloudinary.com/dyeyatchg/image/upload/v1700393981/sondya/kpknp9au7cyempw2jz8s.jpg",
    "public_id": "sondya/kpknp9au7cyempw2jz8s",
    "folder": "sondya",
    "_id": "6559f3ff1cc17a69f9747361"
  },
];

class AddServModalBody3 extends ConsumerStatefulWidget {
  final void Function()? onPressed;
  const AddServModalBody3({super.key, this.onPressed});

  @override
  ConsumerState<AddServModalBody3> createState() => _AddServModalBody3State();
}

class _AddServModalBody3State extends ConsumerState<AddServModalBody3> {
  String _selectedCountry = "Country";

  late TextEditingController _phoneNumberController;
  late TextEditingController _phoneNumberBackupController;
  late TextEditingController _emailController;
  late TextEditingController _websiteLinkController;
  late TextEditingController _stateController;
  late TextEditingController _cityController;
  late TextEditingController _mapLocationLinkController;

  @override
  void initState() {
    super.initState();
    var service = ref.read(sellerServiceDataprovider.notifier).state;
    _phoneNumberController = TextEditingController(text: service.phoneNumber);
    _phoneNumberBackupController =
        TextEditingController(text: service.phoneNumberBackup);
    _emailController = TextEditingController(text: service.email);
    _websiteLinkController = TextEditingController(text: service.websiteLink);
    _stateController = TextEditingController(text: service.state);
    _cityController = TextEditingController(text: service.city);
    _mapLocationLinkController =
        TextEditingController(text: service.mapLocationLink);

    if (service.country != null) {
      _selectedCountry = service.country!;
    }
  }

  @override
  void dispose() {
    _phoneNumberController.dispose();
    _phoneNumberBackupController.dispose();
    _emailController.dispose();
    _websiteLinkController.dispose();
    _stateController.dispose();
    _cityController.dispose();
    _mapLocationLinkController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var service = ref.watch(sellerServiceDataprovider.notifier).state;
    final AsyncValue<Map<String, dynamic>> checkState =
        ref.watch(sellerAddServiceProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.42,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  const Text("Phone Number",
                      style: TextStyle(color: Colors.grey)),
                  const SizedBox(height: 5),
                  TextField(
                    controller: _phoneNumberController,
                    decoration: const InputDecoration(
                      hintText: " Enter Phone Number",
                    ),
                    onChanged: (value) {
                      service.phoneNumber = value;
                    },
                  ),
                ],
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.42,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  const Text("Backup Phone Number (Optional)",
                      style: TextStyle(color: Colors.grey)),
                  const SizedBox(height: 5),
                  TextField(
                    controller: _phoneNumberBackupController,
                    decoration: const InputDecoration(
                      hintText: " Backup Phone Number (Optional)",
                    ),
                    onChanged: (value) {
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
              width: MediaQuery.of(context).size.width * 0.42,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  const Text("Email Address",
                      style: TextStyle(color: Colors.grey)),
                  const SizedBox(height: 5),
                  TextField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      hintText: "Email Address",
                    ),
                    onChanged: (value) {
                      service.email = value;
                    },
                  ),
                ],
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.42,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  const Text("Website Link (Optional)",
                      style: TextStyle(color: Colors.grey)),
                  const SizedBox(height: 5),
                  TextField(
                    controller: _websiteLinkController,
                    decoration: const InputDecoration(
                      hintText: " Website Link (Optional)",
                    ),
                    onChanged: (value) {
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
                  const Text("Country", style: TextStyle(color: Colors.grey)),
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
              width: MediaQuery.of(context).size.width * 0.42,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  const Text("State", style: TextStyle(color: Colors.grey)),
                  const SizedBox(height: 5),
                  TextField(
                    controller: _stateController,
                    decoration: const InputDecoration(
                      hintText: "State",
                    ),
                    onChanged: (value) {
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
              width: MediaQuery.of(context).size.width * 0.42,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  const Text("City", style: TextStyle(color: Colors.grey)),
                  const SizedBox(height: 5),
                  TextField(
                    controller: _cityController,
                    decoration: const InputDecoration(
                      hintText: "City",
                    ),
                    onChanged: (value) {
                      service.city = value;
                    },
                  ),
                ],
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.42,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  const Text("Map Location (Optional)",
                      style: TextStyle(color: Colors.grey)),
                  const SizedBox(height: 5),
                  TextField(
                    controller: _mapLocationLinkController,
                    decoration: const InputDecoration(
                      hintText: "Map Location (Optional)",
                    ),
                    onChanged: (value) {
                      service.mapLocationLink = value;
                    },
                  ),
                ],
              ),
            )
          ],
        ),
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
              width: MediaQuery.of(context).size.width * 0.42,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  if (_phoneNumberController.text == "" ||
                      _phoneNumberBackupController.text == "" ||
                      _emailController.text == "" ||
                      _websiteLinkController.text == "" ||
                      _selectedCountry == "Country" ||
                      _stateController.text == "" ||
                      _cityController.text == "" ||
                      _mapLocationLinkController.text == "") {
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

class AddServModalButton extends StatelessWidget {
  final bool done;
  final bool selected;
  final String title;
  final String subtitle;
  final void Function()? onTap;
  const AddServModalButton(
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
