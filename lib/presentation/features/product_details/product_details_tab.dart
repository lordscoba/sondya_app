import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductDetailsTab extends StatefulWidget {
  final String description;
  final Map<String, dynamic> owner;
  final String address;
  final String country;
  final String state;
  final String city;
  final String zipCode;
  final String subCategory;
  final String model;
  final String brand;
  final String name;
  const ProductDetailsTab(
      {super.key,
      required this.description,
      required this.owner,
      required this.address,
      required this.country,
      required this.state,
      required this.city,
      required this.zipCode,
      required this.subCategory,
      required this.model,
      required this.brand,
      required this.name});

  @override
  State<ProductDetailsTab> createState() => _ProductDetailsTabState();
}

class _ProductDetailsTabState extends State<ProductDetailsTab> {
  String selectedTab = "Tab1"; // other tabs are "Tab2" and "Tab3"

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Wrap(
          alignment: WrapAlignment.start,
          spacing: 6,
          runSpacing: 6,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.3,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: selectedTab == "Tab1"
                          ? const Color(0xFFEDB842)
                          : Colors.grey, // Adjust border color
                      width: 2.0, // Adjust border width
                    ),
                  ),
                ),
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      selectedTab = "Tab1";
                    });
                  },
                  child: Text(
                    "Description",
                    style: TextStyle(
                        fontSize: selectedTab == "Tab1" ? 18 : 15,
                        fontWeight: selectedTab == "Tab1"
                            ? FontWeight.w500
                            : FontWeight.w400),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.3,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: selectedTab == "Tab2"
                          ? const Color(0xFFEDB842)
                          : Colors.grey, // Adjust border color
                      width: 2.0, // Adjust border width
                    ),
                  ),
                ),
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      selectedTab = "Tab2";
                    });
                  },
                  child: Text(
                    "About seller",
                    style: TextStyle(
                        fontSize: selectedTab == "Tab2" ? 18 : 15,
                        fontWeight: selectedTab == "Tab2"
                            ? FontWeight.w500
                            : FontWeight.w400),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.3,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: selectedTab == "Tab3"
                          ? const Color(0xFFEDB842)
                          : Colors.grey, // Adjust border color
                      width: 2.0, // Adjust border width
                    ),
                  ),
                ),
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      selectedTab = "Tab3";
                    });
                  },
                  child: Text(
                    "Shipping",
                    style: TextStyle(
                        fontSize: selectedTab == "Tab3" ? 18 : 15,
                        fontWeight: selectedTab == "Tab3"
                            ? FontWeight.w500
                            : FontWeight.w400),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 200,
          child: selectedTab == "Tab1"
              ? Tab1(
                  name: widget.name,
                  description: widget.description,
                  subCategory: widget.subCategory,
                  model: widget.model,
                  brand: widget.brand,
                )
              : selectedTab == "Tab2"
                  ? Tab2(
                      owner: widget.owner,
                    )
                  : Tab3(
                      address: widget.address,
                      country: widget.country,
                      state: widget.state,
                      city: widget.city,
                      zipCode: widget.zipCode,
                    ),
        ),
      ],
    );
  }
}

class Tab1 extends ConsumerWidget {
  final String name;
  final String description;
  final String subCategory;
  final String model;
  final String brand;
  const Tab1(
      {super.key,
      required this.name,
      required this.description,
      required this.subCategory,
      required this.model,
      required this.brand});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      child: Column(
        children: [
          const SizedBox(
            height: 8,
          ),
          Text(
            name,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
          const SizedBox(
            height: 8,
          ),
          Table(
            border: TableBorder.all(
              color: const Color(0xFFE0E7E9),
              width: 0.5,
              borderRadius: BorderRadius.circular(5.0),
            ),
            children: [
              TableRow(
                children: [
                  Container(
                    color: const Color(0xFFE0E7E9),
                    padding: const EdgeInsets.all(5.0),
                    child: const Text("Category"),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text(subCategory),
                  ),
                ],
              ),
              TableRow(
                children: [
                  Container(
                    color: const Color(0xFFE0E7E9),
                    padding: const EdgeInsets.all(5.0),
                    child: const Text("Brand"),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text(brand),
                  ),
                ],
              ),
              TableRow(
                children: [
                  Container(
                    color: const Color(0xFFE0E7E9),
                    padding: const EdgeInsets.all(5.0),
                    child: const Text("Model"),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text(model),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class Tab2 extends ConsumerWidget {
  final Map<String, dynamic> owner;
  const Tab2({super.key, required this.owner});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      child: Column(
        children: [
          const SizedBox(
            height: 8,
          ),
          const Text(
            "Seller Details",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
          const SizedBox(
            height: 8,
          ),
          Table(
            border: TableBorder.all(
              color: const Color(0xFFE0E7E9),
              width: 0.5,
              borderRadius: BorderRadius.circular(5.0),
            ),
            children: [
              TableRow(
                children: [
                  Container(
                    color: const Color(0xFFE0E7E9),
                    padding: const EdgeInsets.all(5.0),
                    child: const Text("Username"),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text(owner["username"] ?? "N/A"),
                  ),
                ],
              ),
              TableRow(
                children: [
                  Container(
                    color: const Color(0xFFE0E7E9),
                    padding: const EdgeInsets.all(5.0),
                    child: const Text("Email"),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text(owner["email"] ?? "N/A"),
                  ),
                ],
              ),
              TableRow(
                children: [
                  Container(
                    color: const Color(0xFFE0E7E9),
                    padding: const EdgeInsets.all(5.0),
                    child: const Text("Phone"),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text(owner["phone_number"] ?? "N/A"),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class Tab3 extends ConsumerWidget {
  final String address;
  final String city;
  final String state;
  final String country;
  final String zipCode;

  const Tab3(
      {super.key,
      required this.address,
      required this.city,
      required this.state,
      required this.country,
      required this.zipCode});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      child: Column(
        children: [
          const SizedBox(
            height: 8,
          ),
          const Text(
            "To be shipped from",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
          const SizedBox(
            height: 8,
          ),
          Table(
            border: TableBorder.all(
              color: const Color(0xFFE0E7E9),
              width: 0.5,
              borderRadius: BorderRadius.circular(5.0),
            ),
            children: [
              TableRow(
                children: [
                  Container(
                    color: const Color(0xFFE0E7E9),
                    padding: const EdgeInsets.all(5.0),
                    child: const Text("Address"),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text(address),
                  ),
                ],
              ),
              TableRow(
                children: [
                  Container(
                    color: const Color(0xFFE0E7E9),
                    padding: const EdgeInsets.all(5.0),
                    child: const Text("Country"),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text(country),
                  ),
                ],
              ),
              TableRow(
                children: [
                  Container(
                    color: const Color(0xFFE0E7E9),
                    padding: const EdgeInsets.all(5.0),
                    child: const Text("State"),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text(state),
                  ),
                ],
              ),
              TableRow(
                children: [
                  Container(
                    color: const Color(0xFFE0E7E9),
                    padding: const EdgeInsets.all(5.0),
                    child: const Text("City"),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text(city),
                  ),
                ],
              ),
              TableRow(
                children: [
                  Container(
                    color: const Color(0xFFE0E7E9),
                    padding: const EdgeInsets.all(5.0),
                    child: const Text("Zip code"),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text(zipCode),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
