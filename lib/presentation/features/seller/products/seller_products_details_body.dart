import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sondya_app/presentation/features/product_details/product_details_tab.dart';
import 'package:sondya_app/presentation/widgets/picture_slider.dart';
import 'package:sondya_app/presentation/widgets/price_formatter.dart';
import 'package:sondya_app/presentation/widgets/ratings_widget.dart';

class SellerProductsDetailsBody extends StatelessWidget {
  final Map<String, dynamic> data;
  const SellerProductsDetailsBody({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    // final Map<String, List<String>> variants = {
    //   "color": ["blue", "red"],
    //   "size": ["big", "small"]
    // };
    // print(data);
    return SingleChildScrollView(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
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
              SondyaPictureSlider(
                pictureList: data["image"],
              ),
              const SizedBox(height: 20.0),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SondyaStarRating(
                    averageRating: data["rating"].toDouble(),
                  ),
                  Text(
                    "${data["rating"].toDouble()}(${data["total_rating"]}) Star Rating",
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                data["name"],
                style: GoogleFonts.playfairDisplay(
                    fontSize: 20, fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(data["description"],
                  style: const TextStyle(fontSize: 16, color: Colors.grey)),
              const SizedBox(
                height: 8,
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  RichText(
                    text: TextSpan(
                      style: const TextStyle(fontWeight: FontWeight.w600),
                      children: [
                        const TextSpan(
                          text: 'Model:',
                          style: TextStyle(color: Color(0xFF5F6C72)),
                        ),
                        TextSpan(
                          text: data["model"].toString(),
                          style: const TextStyle(color: Color(0xFF000000)),
                        ),
                      ],
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      style: const TextStyle(fontWeight: FontWeight.w600),
                      children: [
                        const TextSpan(
                          text: 'Availability:',
                          style: TextStyle(color: Color(0xFF5F6C72)),
                        ),
                        TextSpan(
                          text: data["product_status"].toString(),
                          style: const TextStyle(color: Color(0xFFEDB842)),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  RichText(
                    text: TextSpan(
                      style: const TextStyle(fontWeight: FontWeight.w600),
                      children: [
                        const TextSpan(
                          text: 'Brand:',
                          style: TextStyle(color: Color(0xFF5F6C72)),
                        ),
                        TextSpan(
                          text: data["brand"].toString(),
                          style: const TextStyle(color: Color(0xFF000000)),
                        ),
                      ],
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      style: const TextStyle(fontWeight: FontWeight.w600),
                      children: [
                        const TextSpan(
                          text: 'Category:',
                          style: TextStyle(color: Color(0xFF5F6C72)),
                        ),
                        TextSpan(
                          text: data["sub_category"].toString(),
                          style: const TextStyle(color: Color(0xFFEDB842)),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  PriceFormatWidget(
                    price: data["current_price"].toDouble() ?? 0.0,
                    fontSize: 15,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  PriceFormatWidget(
                    price: data["old_price"].toDouble() ?? 0.0,
                    oldPrice: true,
                    fontSize: 15,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Container(
                    padding:
                        const EdgeInsets.all(8.0), // Adjust padding as needed
                    decoration: BoxDecoration(
                      color: const Color(0xFFEDB842), // Background color
                      borderRadius: BorderRadius.circular(
                          8.0), // Optional: Rounded corners
                    ),
                    child: data["old_price"] != null || data["old_price"] != 0
                        ? Text(
                            "${data["discount_percentage"]} %off",
                            style: const TextStyle(
                              color: Colors.white, // Text color
                              fontSize: 16.0, // Font size
                              fontWeight: FontWeight.bold, // Font weight
                            ),
                          )
                        : const SizedBox(),
                  )
                ],
              ),
              const Divider(),
              const SizedBox(
                height: 8,
              ),
              const Text('Variant:', style: TextStyle(fontSize: 20)),
              const SizedBox(
                height: 8,
              ),
              ListView(
                shrinkWrap: true,
                children: [
                  data["variants"] == null || data["variants"].isEmpty
                      ? const Text("No variants available")
                      : Column(
                          children: [
                            for (var entry in data["variants"].entries)
                              ListTile(
                                leading: Text(
                                    "${entry.key}: "), // Display the key (e.g., "color" or "size")
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    for (var value in entry.value)
                                      Text(
                                          "$value,"), // Display each value (e.g., "blue", "red", "big", "small")
                                  ],
                                ),
                              )
                          ],
                        ),
                ],
              ),
              ProductDetailsTab(
                description: data["description"].toString(),
                owner: data["owner"] ?? {},
                address: data["address"].toString(),
                country: data["country"].toString(),
                state: data["state"].toString(),
                city: data["city"].toString(),
                zipCode: data["zip_code"].toString(),
                subCategory: data["sub_category"].toString(),
                model: data["model"].toString(),
                brand: data["brand"].toString(),
                name: data["name"].toString(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
