import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sondya_app/presentation/features/user/order/product_order_details_body.dart';

class ServiceOrderDetailsBody extends StatelessWidget {
  const ServiceOrderDetailsBody({super.key});

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
                            'Service',
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
                            'Duration',
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
                            DataCell(
                              SizedBox(
                                width: 150,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Hair Dressing',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    ),
                                    Text(
                                      'I Can dress your hair an make it very fine',
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            DataCell(Text('84671527')),
                            DataCell(Text('24 hrs')),
                            DataCell(Text('\$20')),
                            DataCell(Text('\$20')),
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
                  Text("Customer",
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
                    title: "Progress",
                    subtitle: "Seller is proccessing your order.",
                    date: "May 1, 2022",
                    icon: Icons.book,
                    isCompleted: true,
                  ),
                  OrderStatusItem(
                    title: "Delivered",
                    // date: "May 1, 2022",
                    icon: Icons.handshake_outlined,
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
