import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sondya_app/presentation/widgets/picture_slider.dart';
import 'package:sondya_app/presentation/widgets/price_formatter.dart';

class SellerServicesDetailsBody extends StatelessWidget {
  final Map<String, dynamic> data;
  const SellerServicesDetailsBody({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("GIG"),
                        PriceFormatWidget(
                          price: data["current_price"].toDouble() ?? 0.0,
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
                    Text(
                      data["brief_description"],
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Text(
                      "${data["duration"]}  Delivery",
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                    // const SizedBox(
                    //   height: 12,
                    // ),
                    // ElevatedButton(
                    //   onPressed: () {},
                    //   child: const Row(
                    //     mainAxisSize: MainAxisSize.min,
                    //     children: [
                    //       Text("Continue"),
                    //       Icon(Icons.arrow_forward),
                    //     ],
                    //   ),
                    // ),
                    // const SizedBox(
                    //   height: 5,
                    // ),
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
              Text(
                data["description"],
                style:
                    const TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
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
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.person_outline),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          "${data["owner"]["username"] ?? ""}, ${data["owner"]["email"] ?? ""}"),
                      Text(data["location_description"] ?? ""),
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "From",
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF74767E),
                          ),
                        ),
                        Text(
                          data["country"] ?? "",
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF62646A),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          "State",
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF74767E),
                          ),
                        ),
                        Text(
                          data["state"] ?? "",
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF62646A),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          "City",
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF74767E),
                          ),
                        ),
                        Text(
                          data["city"] ?? "",
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF62646A),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          "Website Link",
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF74767E),
                          ),
                        ),
                        Text(
                          data["website_link"] ?? "",
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF62646A),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Email",
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF74767E),
                          ),
                        ),
                        Text(
                          data["email"] ?? "",
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF62646A),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          "Phone Number",
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF74767E),
                          ),
                        ),
                        Text(
                          data["phone_number"] ?? "",
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF62646A),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          "Phone Number Back Up",
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF74767E),
                          ),
                        ),
                        Text(
                          data["phone_number_backup"] ?? "",
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF62646A),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          "Map Location",
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF74767E),
                          ),
                        ),
                        Text(
                          data["map_location_link"] ?? "",
                          style: const TextStyle(
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
