import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sondya_app/presentation/features/service_details/service_details_body.dart';
import 'package:sondya_app/presentation/features/user/order/service_order_details_body.dart';
import 'package:sondya_app/presentation/widgets/price_formatter.dart';

class SellerServiceOrdersDetailsBody extends StatelessWidget {
  final Map<String, dynamic> data;
  const SellerServiceOrdersDetailsBody({super.key, required this.data});

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
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  const Text("Time Left"),
                  const SizedBox(width: 5.0),
                  Container(
                      padding: const EdgeInsets.all(5.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        color: Colors.green.shade500,
                      ),
                      child: const Text("10:00")),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  SizedBox(
                    width: 210,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        context.push(
                          '/seller/order/review/terms/${data["order_id"]}',
                          extra: data,
                        );
                      },
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text("Review Terms"),
                          SizedBox(width: 5.0),
                          Icon(Icons.open_in_new),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 210,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        context.push(
                          '/seller/order/deliver/work/${data["order_id"]}',
                          extra: data,
                        );
                      },
                      child: const Text("Deliver Work"),
                    ),
                  )
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
                            data["checkout_items"]["terms"]["duration"]
                                    .toString() +
                                data["checkout_items"]["terms"]["durationUnit"]
                                    .toString(),
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
                        rows: <DataRow>[
                          DataRow(
                            cells: <DataCell>[
                              DataCell(
                                SizedBox(
                                  width: 150,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        data["checkout_items"]["name"],
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                      ),
                                      Text(
                                        data["checkout_items"]
                                                ["brief_description"]
                                            .toString(),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              DataCell(Text(data["order_id"].toString())),
                              DataCell(Text(
                                  '${data["checkout_items"]["terms"]["duration"]} ${data["checkout_items"]["terms"]["durationUnit"]}')),
                              DataCell(
                                PriceFormatWidget(
                                    color: Colors.black87,
                                    price: data["checkout_items"]["terms"]
                                                ["amount"]
                                            .toDouble() ??
                                        0.0),
                              ),
                              DataCell(
                                PriceFormatWidget(
                                    color: Colors.black87,
                                    price: data["checkout_items"]["terms"]
                                                ["amount"]
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
              const SellerChatBox(),
              Container(
                margin: const EdgeInsets.all(8.0),
                padding: const EdgeInsets.symmetric(
                    vertical: 40.0, horizontal: 12.0),
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
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20)),
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
                            "Email: ${data["checkout_items"]["owner"]["email"].toString()}"),
                      ],
                    ),
                    const SizedBox(height: 10.0),
                    Row(
                      children: [
                        const Icon(Icons.phone, color: Color(0xFFEDB842)),
                        const SizedBox(width: 10),
                        Text(
                            "Phone:  ${data["checkout_items"]["owner"]["phone_number"].toString()}"),
                      ],
                    )
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.all(8.0),
                padding: const EdgeInsets.symmetric(
                    vertical: 40.0, horizontal: 12.0),
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
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20)),
                    const SizedBox(height: 10.0),
                    Row(
                      children: [
                        const Icon(Icons.person, color: Color(0xFFEDB842)),
                        const SizedBox(width: 10),
                        Text("Name: ${data["buyer"]["username"].toString()}"),
                      ],
                    ),
                    const SizedBox(height: 10.0),
                    Row(
                      children: [
                        const Icon(Icons.email, color: Color(0xFFEDB842)),
                        const SizedBox(width: 10),
                        Text("Email: ${data["buyer"]["email"].toString()}"),
                      ],
                    ),
                    const SizedBox(height: 10.0),
                    Row(
                      children: [
                        const Icon(Icons.phone, color: Color(0xFFEDB842)),
                        const SizedBox(width: 10),
                        Text(
                            "Phone: ${data["buyer"]["phone_number"].toString()}"),
                      ],
                    )
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.all(8.0),
                padding: const EdgeInsets.symmetric(
                    vertical: 40.0, horizontal: 12.0),
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
                child: ServiceOrderStatusWidget(
                  orderStatus: data["order_status"].toString(),
                  createdAt: data["createdAt"].toString(),
                  updatedAt: data["updatedAt"].toString(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
