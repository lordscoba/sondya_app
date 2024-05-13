import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sondya_app/presentation/features/user/order/product_order_details_body.dart';

class SellerProductsOrderDetailsBody extends StatelessWidget {
  const SellerProductsOrderDetailsBody({super.key});

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
            const Wrap(
              spacing: 10.0,
              runSpacing: 10.0,
              children: [
                SizedBox(
                  width: 300,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: null,
                    child: Row(
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
                    onPressed: null,
                    child: Row(
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
                      const Text(
                        "Order #43896839",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      Container(
                        padding: const EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          color: const Color(0xFFEDB842).withOpacity(0.3),
                        ),
                        child: const Text(
                          "order placed",
                          style: TextStyle(color: Color(0xFFEDB842)),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10.0),
                  const Row(
                    children: [
                      Icon(Icons.calendar_month, color: Color(0xFFEDB842)),
                      SizedBox(width: 10),
                      Text("Added: December 26, 2023"),
                    ],
                  ),
                  const SizedBox(height: 10.0),
                  const Row(
                    children: [
                      Icon(Icons.payment, color: Color(0xFFEDB842)),
                      SizedBox(width: 10),
                      Text("Payment Status: successful"),
                    ],
                  ),
                  const SizedBox(height: 10.0),
                  const Row(
                    children: [
                      Icon(Icons.location_on, color: Color(0xFFEDB842)),
                      SizedBox(width: 10),
                      Text("Shipping to: Nigeria , Akwaibom , Uyo"),
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
                  Text("Document",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                  SizedBox(height: 10.0),
                  Row(
                    children: [
                      Icon(Icons.receipt, color: Color(0xFFEDB842)),
                      SizedBox(width: 10),
                      Text("Invoice: INV-32011"),
                    ],
                  ),
                  SizedBox(height: 10.0),
                  Row(
                    children: [
                      Icon(Icons.local_shipping, color: Color(0xFFEDB842)),
                      SizedBox(width: 10),
                      Text("Order ID: ORD-32011"),
                    ],
                  ),
                  SizedBox(height: 10.0),
                  Row(
                    children: [
                      Icon(Icons.payment, color: Color(0xFFEDB842)),
                      SizedBox(width: 10),
                      Text("Payment Status: Paid"),
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
                  Text("Customer",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                  SizedBox(height: 10.0),
                  Row(
                    children: [
                      Icon(Icons.person, color: Color(0xFFEDB842)),
                      SizedBox(width: 10),
                      Text("Customer: Lord Coba"),
                    ],
                  ),
                  SizedBox(height: 10.0),
                  Row(
                    children: [
                      Icon(Icons.email, color: Color(0xFFEDB842)),
                      SizedBox(width: 10),
                      Text("Email: lordscoba2tm@gmail.com"),
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
                      Icon(Icons.location_on, color: Color(0xFFEDB842)),
                      SizedBox(width: 10),
                      Text("Address: 51st St, New York, NY 10019"),
                    ],
                  ),
                  SizedBox(height: 10.0),
                  Row(
                    children: [
                      Icon(Icons.location_on, color: Color(0xFFEDB842)),
                      SizedBox(width: 10),
                      Text("location: New York, USA"),
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
