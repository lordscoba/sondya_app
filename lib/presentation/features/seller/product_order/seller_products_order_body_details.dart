import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sondya_app/presentation/features/user/order/product_order_details_body.dart';
import 'package:sondya_app/presentation/widgets/price_formatter.dart';
import 'package:sondya_app/utils/dateTime_to_string.dart';

class SellerProductsOrderDetailsBody extends StatelessWidget {
  final Map<String, dynamic> data;
  const SellerProductsOrderDetailsBody({super.key, required this.data});

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
            const SizedBox(height: 10.0),
            const Text(
              "Order Details",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            const SizedBox(height: 10.0),
            Wrap(
              spacing: 10.0,
              runSpacing: 10.0,
              children: [
                SizedBox(
                  width: 300,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      context.push(
                        '/seller/order/update/location/${data["_id"]}',
                        extra: data,
                      );
                    },
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.edit),
                        Text(
                          "Update Location",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 300,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      context.push(
                        '/seller/order/update/status/${data["_id"]}',
                        extra: data,
                      );
                    },
                    child: const Row(
                      children: [
                        Icon(Icons.edit),
                        Text(
                          "Update Order Status",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 10.0),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Order ${data["order_id"]}",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      Container(
                        padding: const EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          color: const Color(0xFFEDB842).withOpacity(0.3),
                        ),
                        child: Text(
                          data["order_status"],
                          style: const TextStyle(color: Color(0xFFEDB842)),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10.0),
                  Row(
                    children: [
                      const Icon(Icons.calendar_month,
                          color: Color(0xFFEDB842)),
                      const SizedBox(width: 10),
                      Text("Added: ${sondyaFormattedDate(data["createdAt"])}"),
                    ],
                  ),
                  const SizedBox(height: 10.0),
                  Row(
                    children: [
                      const Icon(Icons.payment, color: Color(0xFFEDB842)),
                      const SizedBox(width: 10),
                      Text("Order Status: ${data["order_status"]}"),
                    ],
                  ),
                  const SizedBox(height: 10.0),
                  Row(
                    children: [
                      const Icon(Icons.location_on, color: Color(0xFFEDB842)),
                      const SizedBox(width: 10),
                      Text(
                          "Shipping to: ${data["shipping_destination"]["city"]}, ${data["shipping_destination"]["state"]}, ${data["shipping_destination"]["country"]}"),
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
                  const Text("Document",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                  const SizedBox(height: 10.0),
                  Row(
                    children: [
                      const Icon(Icons.receipt, color: Color(0xFFEDB842)),
                      const SizedBox(width: 10),
                      Text("Invoice: ${data["payment_id"]}"),
                    ],
                  ),
                  const SizedBox(height: 10.0),
                  Row(
                    children: [
                      const Icon(Icons.local_shipping,
                          color: Color(0xFFEDB842)),
                      const SizedBox(width: 10),
                      Text("Order ID: ${data["order_id"]}"),
                    ],
                  ),
                  const SizedBox(height: 10.0),
                  Row(
                    children: [
                      const Icon(Icons.payment, color: Color(0xFFEDB842)),
                      const SizedBox(width: 10),
                      Text("Payment Status: ${data["payment_status"]}"),
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
                  const Text("Customer",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                  const SizedBox(height: 10.0),
                  Row(
                    children: [
                      const Icon(Icons.person, color: Color(0xFFEDB842)),
                      const SizedBox(width: 10),
                      Text(
                          "Customer:  ${data["buyer"].toString() == "null" ? "" : data["buyer"]["username"] ?? ""}"),
                    ],
                  ),
                  const SizedBox(height: 10.0),
                  Row(
                    children: [
                      const Icon(Icons.email, color: Color(0xFFEDB842)),
                      const SizedBox(width: 10),
                      Text(
                          "Email: ${data["buyer"].toString() == "null" ? "" : data["buyer"]["email"] ?? ""}"),
                    ],
                  ),
                  const SizedBox(height: 10.0),
                  Row(
                    children: [
                      const Icon(Icons.phone, color: Color(0xFFEDB842)),
                      const SizedBox(width: 10),
                      Text(
                          "Phone: ${data["buyer"].toString() == "null" ? "" : data["buyer"]["phone_number"] ?? ""}"),
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
                      const Icon(Icons.location_on, color: Color(0xFFEDB842)),
                      const SizedBox(width: 10),
                      Text(
                          "Address: ${data["shipping_destination"]["address"] ?? ""}"),
                    ],
                  ),
                  const SizedBox(height: 10.0),
                  Row(
                    children: [
                      const Icon(Icons.location_on, color: Color(0xFFEDB842)),
                      const SizedBox(width: 10),
                      Text(
                          "location: ${data["shipping_destination"]["city"] ?? ""}, ${data["shipping_destination"]["state"] ?? ""}, ${data["shipping_destination"]["country"] ?? ""}"),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(height: 30),
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
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.0),
                    child: Row(
                      children: [
                        Text(
                          "Order List",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 10.0),
                        Text(
                          "+2 Orders",
                          style: TextStyle(color: Color(0xFF1A9882)),
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
                            DataCell(Text(
                                '${data["checkout_items"]["order_quantity"].toString()} pcs')),
                            DataCell(
                              PriceFormatWidget(
                                  color: Colors.black87,
                                  price: data["checkout_items"]["current_price"]
                                          .toDouble() ??
                                      0.0),
                            ),
                            DataCell(PriceFormatWidget(
                                color: Colors.black87,
                                price: data["checkout_items"]["sub_total"]
                                        .toDouble() ??
                                    0.0)),
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
                                price:
                                    data["checkout_items"]["tax"].toDouble() ??
                                        0.0)),
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
                                price: data["checkout_items"]["shipping_fee"]
                                        .toDouble() ??
                                    0.0)),
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
                                  price: data["checkout_items"]["discount"]
                                          .toDouble() ??
                                      0.0),
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
                                  price: data["checkout_items"]["total_price"]
                                          .toDouble() ??
                                      0.0),
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
              child: OrderStatusWidget(
                orderStatus: data["order_status"],
                updatedAt: data["updatedAt"],
                createdAt: data["createdAt"],
              ),
            )
          ],
        ),
      ),
    );
  }
}
