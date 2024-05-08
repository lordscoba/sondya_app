import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sondya_app/presentation/widgets/dotted_line.dart';

class ProductOrderDetailsBody extends StatelessWidget {
  const ProductOrderDetailsBody({super.key});

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
                      rows: const <DataRow>[
                        DataRow(
                          cells: <DataCell>[
                            DataCell(Text('Ear piece')),
                            DataCell(Text('7554444')),
                            DataCell(Text('1 pcs')),
                            DataCell(Text('\$123')),
                            DataCell(Text('\$123')),
                          ],
                        ),
                        DataRow(
                          cells: <DataCell>[
                            DataCell(Text('')),
                            DataCell(Text('')),
                            DataCell(Text('')),
                            DataCell(Text('Tax',
                                style: TextStyle(fontWeight: FontWeight.bold))),
                            DataCell(Text('\$1')),
                          ],
                        ),
                        DataRow(
                          cells: <DataCell>[
                            DataCell(Text('')),
                            DataCell(Text('')),
                            DataCell(Text('')),
                            DataCell(Text('Shipping Rate',
                                style: TextStyle(fontWeight: FontWeight.bold))),
                            DataCell(Text('\$21')),
                          ],
                        ),
                        DataRow(
                          cells: <DataCell>[
                            DataCell(Text('')),
                            DataCell(Text('')),
                            DataCell(Text('')),
                            DataCell(Text('Discount',
                                style: TextStyle(fontWeight: FontWeight.bold))),
                            DataCell(Text('-\$3')),
                          ],
                        ),
                        DataRow(
                          cells: <DataCell>[
                            DataCell(Text('')),
                            DataCell(Text('')),
                            DataCell(Text('')),
                            DataCell(Text('Total',
                                style: TextStyle(fontWeight: FontWeight.bold))),
                            DataCell(Text('\$142')),
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
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Vendor",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                  SizedBox(height: 10.0),
                  Row(
                    children: [
                      Icon(Icons.person, color: Color(0xFFEDB842)),
                      SizedBox(width: 10),
                      Text("Name:"),
                    ],
                  ),
                  SizedBox(height: 10.0),
                  Row(
                    children: [
                      Icon(Icons.email, color: Color(0xFFEDB842)),
                      SizedBox(width: 10),
                      Text("Email:lordscoba2tm@gmail.com"),
                    ],
                  ),
                  SizedBox(height: 10.0),
                  Row(
                    children: [
                      Icon(Icons.phone, color: Color(0xFFEDB842)),
                      SizedBox(width: 10),
                      Text("Phone: +1 123 456 7890"),
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
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Address",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                  SizedBox(height: 10.0),
                  Row(
                    children: [
                      Icon(Icons.card_membership, color: Color(0xFFEDB842)),
                      SizedBox(width: 10),
                      Text("Order ID: 05914377"),
                    ],
                  ),
                  SizedBox(height: 10.0),
                  Row(
                    children: [
                      Icon(Icons.location_on, color: Color(0xFFEDB842)),
                      SizedBox(width: 10),
                      Text("Shipping Address: 5167277272"),
                    ],
                  ),
                  SizedBox(height: 10.0),
                  Row(
                    children: [
                      Icon(Icons.location_on, color: Color(0xFFEDB842)),
                      SizedBox(width: 10),
                      Text("Location: Los angeles, USA"),
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
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Order Status",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                  SizedBox(height: 10.0),
                  OrderStatusItem(
                    title: "Order Placed",
                    subtitle: "An order has been placed.",
                    date: "May 1, 2022",
                    // cart icon

                    icon: Icons.shopping_cart,
                    isCompleted: true,
                  ),
                  OrderStatusItem(
                    title: "Processing",
                    subtitle: "Seller has proccessed your order.",
                    date: "May 1, 2022",
                    icon: Icons.book,
                    isCompleted: true,
                  ),
                  OrderStatusItem(
                    title: "Packed",
                    // date: "May 1, 2022",
                    icon: Icons.luggage_outlined,
                    isCompleted: false,
                  ),
                  OrderStatusItem(
                    title: "Shipping",
                    // date: "May 1, 2022",
                    icon: Icons.local_shipping,
                    isCompleted: false,
                  ),
                  OrderStatusItem(
                    title: "Delivered",
                    // date: "May 1, 2022",
                    icon: Icons.done,
                    isCompleted: false,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
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
                Text(date,
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
