import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sondya_app/presentation/widgets/dotted_line.dart';
import 'package:sondya_app/presentation/widgets/price_formatter.dart';
import 'package:sondya_app/utils/dateTime_to_string.dart';

class ProductOrderDetailsBody extends StatelessWidget {
  final Map<String, dynamic> data;
  const ProductOrderDetailsBody({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
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
            // data Table here
            Container(
              margin: const EdgeInsets.all(8.0),
              padding: const EdgeInsets.all(8.0),
              // add border decoration
              decoration: BoxDecoration(
                // border: Border.all(color: Colors.black38, width: 1.0),
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
                  const SizedBox(height: 20.0),
                  SelectableText(
                    "Order ID: ${data["order_id"]}",
                    style: const TextStyle(fontSize: 20),
                  ),
                  const SizedBox(height: 20.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Row(
                      children: [
                        const Text(
                          "Order List",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(width: 10.0),
                        Text(
                          "+${data["checkout_items"]["order_quantity"].toString()} Orders",
                          style: const TextStyle(color: Color(0xFF1A9882)),
                        ),
                      ],
                    ),
                  ),
                  const Divider(),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      columns: const <DataColumn>[
                        DataColumn(
                          label: Text(
                            'Product',
                            style: TextStyle(fontWeight: FontWeight.w700),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'ID',
                            style: TextStyle(fontWeight: FontWeight.w700),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Total qty',
                            style: TextStyle(fontWeight: FontWeight.w700),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Price',
                            style: TextStyle(fontWeight: FontWeight.w700),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Total',
                            style: TextStyle(fontWeight: FontWeight.w700),
                          ),
                        ),
                      ],
                      rows: <DataRow>[
                        DataRow(
                          cells: <DataCell>[
                            DataCell(
                                Text(data["checkout_items"]["name"] ?? "")),
                            DataCell(Text(data["checkout_items"]["_id"] ?? "")),
                            DataCell(Text(data["checkout_items"]
                                    ["order_quantity"]
                                .toString())),
                            DataCell(
                              PriceFormatWidget(
                                  color: Colors.black87,
                                  price: data["checkout_items"]
                                              ["current_price"] !=
                                          null
                                      ? data["checkout_items"]["current_price"]
                                              .toDouble() ??
                                          0.0
                                      : 0.0),
                            ),
                            DataCell(PriceFormatWidget(
                                color: Colors.black87,
                                price:
                                    data["checkout_items"]["sub_total"] != null
                                        ? data["checkout_items"]["sub_total"]
                                                .toDouble() ??
                                            0.0
                                        : 0.0)),
                          ],
                        ),
                        DataRow(
                          cells: <DataCell>[
                            const DataCell(Text('')),
                            const DataCell(Text('')),
                            const DataCell(Text('')),
                            const DataCell(Text('Tax',
                                style: TextStyle(fontWeight: FontWeight.bold))),
                            DataCell(PriceFormatWidget(
                                color: Colors.black87,
                                price: data["checkout_items"]["tex"] != null
                                    ? data["checkout_items"]["tax"]
                                            .toDouble() ??
                                        0.0
                                    : 0.0)),
                          ],
                        ),
                        DataRow(
                          cells: <DataCell>[
                            const DataCell(Text('')),
                            const DataCell(Text('')),
                            const DataCell(Text('')),
                            const DataCell(Text('Shipping Rate',
                                style: TextStyle(fontWeight: FontWeight.bold))),
                            DataCell(PriceFormatWidget(
                                color: Colors.black87,
                                price: data["checkout_items"]["shipping_fee"] !=
                                        null
                                    ? data["checkout_items"]["shipping_fee"]
                                            .toDouble() ??
                                        0.0
                                    : 0.0)),
                          ],
                        ),
                        DataRow(
                          cells: <DataCell>[
                            const DataCell(Text('')),
                            const DataCell(Text('')),
                            const DataCell(Text('')),
                            const DataCell(Text('Discount',
                                style: TextStyle(fontWeight: FontWeight.bold))),
                            DataCell(
                              PriceFormatWidget(
                                  color: Colors.black87,
                                  prefix: "-",
                                  price:
                                      data["checkout_items"]["discount"] != null
                                          ? data["checkout_items"]["discount"]
                                                  .toDouble() ??
                                              0.0
                                          : 0.0),
                            ),
                          ],
                        ),
                        DataRow(
                          cells: <DataCell>[
                            const DataCell(Text('')),
                            const DataCell(Text('')),
                            const DataCell(Text('')),
                            const DataCell(Text('Total',
                                style: TextStyle(fontWeight: FontWeight.bold))),
                            DataCell(
                              PriceFormatWidget(
                                  color: Colors.black87,
                                  prefix: "-",
                                  price: data["checkout_items"]
                                              ["current_price"] !=
                                          null
                                      ? data["checkout_items"]["total_price"]
                                              .toDouble() ??
                                          0.0
                                      : 0.0),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.all(8.0),
              padding:
                  const EdgeInsets.symmetric(vertical: 40.0, horizontal: 12.0),
              // add border decoration
              decoration: BoxDecoration(
                // border: Border.all(color: Colors.black38, width: 1.0),
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Vendor",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                  const SizedBox(height: 10.0),
                  Row(
                    children: [
                      const Icon(Icons.person, color: Color(0xFFEDB842)),
                      const SizedBox(width: 10),
                      Text(
                          "Name: ${data["checkout_items"]["owner"]["username"].toString()}"),
                    ],
                  ),
                  const SizedBox(height: 10.0),
                  Row(
                    children: [
                      const Icon(Icons.email, color: Color(0xFFEDB842)),
                      const SizedBox(width: 10),
                      Text(
                          "Email:${data["checkout_items"]["owner"]["email"].toString()}"),
                    ],
                  ),
                  const SizedBox(height: 10.0),
                  Row(
                    children: [
                      const Icon(Icons.phone, color: Color(0xFFEDB842)),
                      const SizedBox(width: 10),
                      Text(
                          "Phone: ${data["checkout_items"]["owner"]["phone_number"].toString()}"),
                    ],
                  )
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.all(8.0),
              padding:
                  const EdgeInsets.symmetric(vertical: 40.0, horizontal: 12.0),
              // add border decoration
              decoration: BoxDecoration(
                // border: Border.all(color: Colors.black38, width: 1.0),
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Address",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                  const SizedBox(height: 10.0),
                  Row(
                    children: [
                      const Icon(Icons.card_membership,
                          color: Color(0xFFEDB842)),
                      const SizedBox(width: 10),
                      SelectableText("Order ID: ${data["order_id"]}"),
                    ],
                  ),
                  const SizedBox(height: 10.0),
                  Row(
                    children: [
                      const Icon(Icons.location_on, color: Color(0xFFEDB842)),
                      const SizedBox(width: 10),
                      Text(
                          "Shipping Address:${data["shipping_destination"]["address"]}"),
                    ],
                  ),
                  const SizedBox(height: 10.0),
                  Row(
                    children: [
                      const Icon(Icons.location_on, color: Color(0xFFEDB842)),
                      const SizedBox(width: 10),
                      Text(
                          "Location: :${data["shipping_destination"]["city"]}, ${data["shipping_destination"]["state"]}, ${data["shipping_destination"]["country"]}"),
                    ],
                  )
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.all(8.0),
              padding:
                  const EdgeInsets.symmetric(vertical: 40.0, horizontal: 12.0),
              // add border decoration
              decoration: BoxDecoration(
                // border: Border.all(color: Colors.black38, width: 1.0),
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
              child: OrderStatusWidget(
                orderStatus: data["order_status"],
                updatedAt: data["updatedAt"],
                createdAt: data["createdAt"],
              ),
            ),
            const Divider(),
            const SizedBox(height: 30.0),
            const Text(
              "Current Locations",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20.0),
            // data Table here
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: const <DataColumn>[
                  DataColumn(
                    label: Text(
                      'Country',
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'State',
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'City',
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Zip Code',
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Order Status',
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ),
                ],
                rows: data["order_location"].isEmpty
                    ? const <DataRow>[]
                    : data["order_location"].map<DataRow>((e) {
                        return DataRow(
                          cells: <DataCell>[
                            DataCell(Text(e["country"])),
                            DataCell(Text(e["state"])),
                            DataCell(Text(e["city"])),
                            DataCell(Text(e["zip_code"])),
                            DataCell(Text(e["order_status"])),
                          ],
                        );
                      }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OrderStatusWidget extends StatelessWidget {
  final String updatedAt;
  final String createdAt;
  final String orderStatus;
  const OrderStatusWidget({
    super.key,
    required this.orderStatus,
    required this.updatedAt,
    required this.createdAt,
  });

  @override
  Widget build(BuildContext context) {
    // print(updatedAt);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Order Status",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
        const SizedBox(height: 10.0),
        OrderStatusItem(
          title: "Order Placed",
          subtitle: "An order has been placed.",
          date: sondyaFormattedDate(createdAt),
          // cart icon
          icon: Icons.shopping_cart,
          isCompleted: orderStatus == "order placed" ||
              orderStatus == "processing" ||
              orderStatus == "packed" ||
              orderStatus == "shipping" ||
              orderStatus == "delivered",
        ),
        OrderStatusItem(
          title: "Processing",
          subtitle: "Seller has proccessed your order.",
          date: sondyaFormattedDate(updatedAt),
          icon: Icons.book,
          isCompleted: orderStatus == "processing" ||
              orderStatus == "packed" ||
              orderStatus == "shipping" ||
              orderStatus == "delivered",
        ),
        OrderStatusItem(
          title: "Packed",
          date: sondyaFormattedDate(updatedAt),
          icon: Icons.luggage_outlined,
          isCompleted: orderStatus == "packed" ||
              orderStatus == "shipping" ||
              orderStatus == "delivered",
        ),
        OrderStatusItem(
          title: "Shipping",
          date: sondyaFormattedDate(updatedAt),
          icon: Icons.local_shipping,
          isCompleted: orderStatus == "shipping" || orderStatus == "delivered",
        ),
        OrderStatusItem(
          title: "Delivered",
          date: sondyaFormattedDate(updatedAt),
          icon: Icons.done,
          isCompleted: orderStatus == "delivered",
        ),
      ],
    );
  }
}

class OrderStatusItem extends StatelessWidget {
  final String title;
  final String? subtitle;
  final String date;
  final IconData icon;
  final bool isCompleted;
  const OrderStatusItem({
    super.key,
    required this.title,
    this.subtitle,
    this.date = "DD/MM/YY, 00:00",
    required this.icon,
    this.isCompleted = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Container(
                  width: 35,
                  height: 35,
                  // give a colored background circle to the icon
                  padding: const EdgeInsets.all(5.0),
                  decoration: BoxDecoration(
                    color: isCompleted
                        ? const Color(0xFFEDB842).withOpacity(0.2)
                        : const Color(0xFFF0F1F3),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon,
                      color: isCompleted
                          ? const Color(0xFFEDB842)
                          : const Color(0xFF667085)),
                ),
                const SizedBox(height: 5.0),
                const DottedVerticalLine(
                  height: 30,
                  color: Color(0xFFE0E2E7),
                  thickness: 2.5,
                )
              ],
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold)),
                subtitle == null
                    ? Container()
                    : Text(subtitle ?? "",
                        style: const TextStyle(
                            fontSize: 15, color: Color(0xFF4A4C56))),
                Text(isCompleted ? date : "DD/MM/YY, 00:00",
                    style: const TextStyle(
                        fontSize: 12, color: Color(0xFF858D9D))),
              ],
            ),
          ],
        ),
        const SizedBox(height: 10.0),
      ],
    );
  }
}
