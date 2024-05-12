import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sondya_app/presentation/widgets/price_formatter.dart';

class SellerServicesBody extends StatelessWidget {
  const SellerServicesBody({super.key});

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
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const SizedBox(
                  width: 200,
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Search",
                      prefixIcon: Icon(Icons.search),
                    ),
                  ),
                ),
                SizedBox(
                  width: 200,
                  child: ElevatedButton(
                      onPressed: () {},
                      child: const Row(
                        children: [
                          Icon(Icons.add),
                          Text("Add Service"),
                        ],
                      )),
                )
              ],
            ),
            const SizedBox(height: 20.0),
            ListView(
              shrinkWrap: true,
              children: const [
                SellerServiceCard(
                  name: "Plantain",
                  status: "Available",
                  price: 600.0,
                  image: "assets/shapes/circle_25.png",
                  productId: "123",
                  quantity: "33 qty",
                ),
                SellerServiceCard(
                  name: "beans",
                  status: "Status",
                  price: 1000.0,
                  image: "assets/shapes/circle_25.png",
                  productId: "123",
                  quantity: "33 qty",
                ),
                SellerServiceCard(
                  name: "Coke",
                  status: "Sold",
                  price: 200.0,
                  image: "assets/shapes/circle_25.png",
                  productId: "123",
                  quantity: "33 qty",
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class SellerServiceCard extends StatelessWidget {
  final String name;
  final String status;
  final double price;
  final String image;
  final String productId;
  final String quantity;
  const SellerServiceCard(
      {super.key,
      required this.name,
      required this.status,
      required this.price,
      required this.image,
      required this.productId,
      required this.quantity});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      child: Column(
        children: [
          Row(
            children: [
              Image(image: AssetImage(image), height: 150),
              const SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: const TextStyle(fontSize: 20)),
                  const SizedBox(height: 10),
                  PriceFormatWidget(
                    price: price,
                    suffix: " ($quantity)",
                    fontSize: 16,
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Text("Status:"),
                      Text(
                        status,
                        style: const TextStyle(color: Colors.green),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.edit),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.delete),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.visibility),
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
          const SizedBox(height: 20),
          const Divider(),
        ],
      ),
    );
  }
}
