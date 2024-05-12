import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sondya_app/domain/models/home.dart';
import 'package:sondya_app/presentation/widgets/image_selection.dart';
import 'package:sondya_app/presentation/widgets/select_widget.dart';
import 'package:sondya_app/presentation/widgets/variants_widget.dart';
import 'package:sondya_app/utils/input_validations.dart';

class SellerProductsAddBody extends ConsumerStatefulWidget {
  const SellerProductsAddBody({super.key});

  @override
  ConsumerState<SellerProductsAddBody> createState() =>
      _SellerProductsAddBodyState();
}

class _SellerProductsAddBodyState extends ConsumerState<SellerProductsAddBody> {
  final _formKey = GlobalKey<FormState>();
  String current = "1"; // 1, 2, 3
  List<String> done = ["1"]; // if done contains 1, 2, 3, it means all is done
  @override
  Widget build(BuildContext context) {
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
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        if (current == "1") const AddModalBody1(),
                        if (current == "2") const AddModalBody2(),
                        if (current == "3") const AddModalBody3(),
                      ],
                    ),
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

class AddModalBody1 extends StatefulWidget {
  final void Function()? onPressed;
  const AddModalBody1({super.key, this.onPressed});

  @override
  State<AddModalBody1> createState() => _AddModalBody1State();
}

class _AddModalBody1State extends State<AddModalBody1> {
  var _selectedCategory = "Category";
  var _selectedStatus = "Status";
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Product Name", style: TextStyle(color: Colors.grey)),
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
            SizedBox(
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
                  const Text("Brand", style: TextStyle(color: Colors.grey)),
                  const SizedBox(height: 5),
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: " Enter Brand",
                      labelText: 'Brand',
                    ),
                    initialValue: "Brand",
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
                  const Text("Tags", style: TextStyle(color: Colors.grey)),
                  const SizedBox(height: 5),
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: " Enter Tags",
                      labelText: 'Tags',
                    ),
                    initialValue: "Tags",
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
                  const Text("Country", style: TextStyle(color: Colors.grey)),
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
                  const Text("State", style: TextStyle(color: Colors.grey)),
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
                  const Text("City", style: TextStyle(color: Colors.grey)),
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
                  const Text("Zip Code", style: TextStyle(color: Colors.grey)),
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
                onPressed: widget.onPressed,
                child: const Row(
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

class AddModalBody2 extends StatelessWidget {
  final void Function()? onPressed;
  const AddModalBody2({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
        const Text("Pricing",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
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
                  const Text("Old Price", style: TextStyle(color: Colors.grey)),
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
        const Text("Media",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),

        const SizedBox(height: 10),
        SondyaMultipleImageSelection(
          savedNetworkImage:
              ims.map((image) => ImageType.fromJson(image)).toList(),
          onSetImage: (value) {
            print(value);
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
                onPressed: onPressed,
                child: const Row(
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

class AddModalBody3 extends StatelessWidget {
  final void Function()? onPressed;
  const AddModalBody3({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
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
        const SizedBox(height: 10),
        const Text("Variation",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        VariationWidget(
          mapData: const {},
          onItemSelected: (mapData) {
            // user.vaue = mapData
            print(mapData);
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
                onPressed: onPressed,
                child: const Row(
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
