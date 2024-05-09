import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sondya_app/presentation/features/product_details/product_details_tab.dart';
import 'package:sondya_app/presentation/widgets/picture_slider.dart';
import 'package:sondya_app/presentation/widgets/price_formatter.dart';
import 'package:sondya_app/presentation/widgets/ratings_widget.dart';

class SellerProductsDetailsBody extends StatelessWidget {
  const SellerProductsDetailsBody({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, List<String>> variants = {
      "color": ["blue", "red"],
      "size": ["big", "small"]
    };
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
              const SondyaPictureSlider(
                pictureList: [
                  {
                    "url":
                        "https://res.cloudinary.com/dyeyatchg/image/upload/v1701811873/sondya/joxkbxnbrvedpobfe1fn.jpg",
                    "public_id": "sondya/joxkbxnbrvedpobfe1fn",
                    "folder": "sondya",
                    "_id": "656f96a162f02cf0261acb04"
                  },
                  {
                    "url":
                        "https://res.cloudinary.com/dyeyatchg/image/upload/v1701811873/sondya/sq1daw132aqbnvq7umap.png",
                    "public_id": "sondya/sq1daw132aqbnvq7umap",
                    "folder": "sondya",
                    "_id": "656f96a162f02cf0261acb05"
                  }
                ],
              ),
              const SizedBox(height: 20.0),
              const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SondyaStarRating(
                    averageRating: 3.0,
                  ),
                  Text(
                    "8 Star Rating",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                "Pine apple",
                style: GoogleFonts.playfairDisplay(
                    fontSize: 20, fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  RichText(
                    text: const TextSpan(
                      style: TextStyle(fontWeight: FontWeight.w600),
                      children: [
                        TextSpan(
                          text: 'Model:',
                          style: TextStyle(color: Color(0xFF5F6C72)),
                        ),
                        TextSpan(
                          text: "5636633",
                          style: TextStyle(color: Color(0xFF000000)),
                        ),
                      ],
                    ),
                  ),
                  RichText(
                    text: const TextSpan(
                      style: TextStyle(fontWeight: FontWeight.w600),
                      children: [
                        TextSpan(
                          text: 'Availability:',
                          style: TextStyle(color: Color(0xFF5F6C72)),
                        ),
                        TextSpan(
                          text: "available",
                          style: TextStyle(color: Color(0xFFEDB842)),
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
                    text: const TextSpan(
                      style: TextStyle(fontWeight: FontWeight.w600),
                      children: [
                        TextSpan(
                          text: 'Brand:',
                          style: TextStyle(color: Color(0xFF5F6C72)),
                        ),
                        TextSpan(
                          text: "Apple",
                          style: TextStyle(color: Color(0xFF000000)),
                        ),
                      ],
                    ),
                  ),
                  RichText(
                    text: const TextSpan(
                      style: TextStyle(fontWeight: FontWeight.w600),
                      children: [
                        TextSpan(
                          text: 'Category:',
                          style: TextStyle(color: Color(0xFF5F6C72)),
                        ),
                        TextSpan(
                          text: "fruits",
                          style: TextStyle(color: Color(0xFFEDB842)),
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
                  const PriceFormatWidget(
                    price: 100.9,
                    fontSize: 15,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  const PriceFormatWidget(
                    price: 200.0,
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
                    child: const Text(
                      "15 %off",
                      style: TextStyle(
                        color: Colors.white, // Text color
                        fontSize: 16.0, // Font size
                        fontWeight: FontWeight.bold, // Font weight
                      ),
                    ),
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
                  for (var entry in variants.entries)
                    ListTile(
                      leading: Text(
                          "${entry.key}: "), // Display the key (e.g., "color" or "size")
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          for (var value in entry.value)
                            Text(
                                "$value "), // Display each value (e.g., "blue", "red", "big", "small")
                        ],
                      ),
                    ),
                ],
              ),
              const ProductDetailsTab(
                description: "I am description",
                owner: {},
                address: '',
                country: '',
                state: '',
                city: '',
                zipCode: '',
                subCategory: '',
                model: '',
                brand: '',
                name: '',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
