import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sondya_app/presentation/widgets/picture_slider.dart';
import 'package:sondya_app/presentation/widgets/price_formatter.dart';

class SellerServicesDetailsBody extends StatelessWidget {
  const SellerServicesDetailsBody({super.key});

  @override
  Widget build(BuildContext context) {
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
              Container(
                margin: const EdgeInsets.all(8),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black38,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(2),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      "Service Package",
                      style: TextStyle(
                        fontSize: 20,
                        color: Color(0xFFEDB842),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const Divider(),
                    const SizedBox(
                      height: 5,
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("GIG"),
                        // Text("\$500"),
                        PriceFormatWidget(
                          price: 200.0,
                          fontSize: 18,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const Text(
                      "Brief Description",
                      style: TextStyle(
                        fontSize: 20,
                        color: Color(0xFFEDB842),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const Text(
                      'A very good thing i did there',
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    const Text(
                      "2 Days Delivery",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text("Continue"),
                          Icon(Icons.arrow_forward),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "About this service",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "A very good day indeed",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "About the seller",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 10,
              ),
              const Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.person_outline),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("lordscoba, lordscoba2tm@gmail.com"),
                      Text('I am a very good  there'),
                    ],
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.all(8),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black38,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(2),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "From",
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF74767E),
                          ),
                        ),
                        Text(
                          "Nigeria",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF62646A),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "State",
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF74767E),
                          ),
                        ),
                        Text(
                          "Lagos",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF62646A),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "City",
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF74767E),
                          ),
                        ),
                        Text(
                          "Ikeja",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF62646A),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Website Link",
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF74767E),
                          ),
                        ),
                        Text(
                          " www.lordscoba.com",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF62646A),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Email",
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF74767E),
                          ),
                        ),
                        Text(
                          "lordscoba2tm@gmail.com",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF62646A),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Phone Number",
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF74767E),
                          ),
                        ),
                        Text(
                          " 08012345678",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF62646A),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Phone Number Back Up",
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF74767E),
                          ),
                        ),
                        Text(
                          " 08012345678",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF62646A),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Map Location",
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF74767E),
                          ),
                        ),
                        Text(
                          " Ikeja, Lagos, Nigeria",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF62646A),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
