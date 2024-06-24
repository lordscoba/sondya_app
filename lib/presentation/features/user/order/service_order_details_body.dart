import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sondya_app/data/local/storedValue.dart';
import 'package:sondya_app/presentation/features/service_details/seller_chat_box.dart';
import 'package:sondya_app/presentation/features/user/order/product_order_details_body.dart';
import 'package:sondya_app/presentation/widgets/price_formatter.dart';
import 'package:sondya_app/utils/dateTime_to_string.dart';

class ServiceOrderDetailsBody extends ConsumerWidget {
  final Map<String, dynamic> data;
  const ServiceOrderDetailsBody({super.key, required this.data});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final myData = ref.watch(storedAuthValueProvider);
    return SingleChildScrollView(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            context.canPop()
                ? Row(
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
                  )
                : Container(),
            const SizedBox(height: 10.0),
            Container(
              margin: const EdgeInsets.all(10.0),
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  context.push(
                    "/user/service/order/review/terms/${data["order_id"]}",
                  );
                },
                child: const Text("Update Terms"),
              ),
            ),
            if (data["payment_status"] != "successful")
              Container(
                margin: const EdgeInsets.all(10.0),
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    context.push(
                        "/service/checkout/${data["seller"]["id"]}/${data["checkout_items"]["_id"]}");
                  },
                  child: const Text("Proceed to Payment"),
                ),
              ),
            const SizedBox(height: 10.0),
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      data["checkout_items"]["name"].toString(),
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
                            DataCell(Text(
                                data["checkout_items"]["name"].toString())),
                            DataCell(Text(data["checkout_items"]["terms"]
                                        ["duration"]
                                    .toString() +
                                data["checkout_items"]["terms"]["durationUnit"]
                                    .toString())),
                            DataCell(
                              PriceFormatWidget(
                                  color: Colors.black87,
                                  price: data["checkout_items"]["terms"]
                                              ["amount"] !=
                                          null
                                      ? data["checkout_items"]["terms"]
                                                  ["amount"]
                                              .toDouble() ??
                                          0.0
                                      : 0.0),
                            ),
                            DataCell(
                              PriceFormatWidget(
                                  color: Colors.black87,
                                  price: data["checkout_items"]["terms"]
                                              ["amount"] !=
                                          null
                                      ? data["checkout_items"]["terms"]
                                                  ["amount"]
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
                  const Text("Customer",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
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
            myData.when(
              data: (data1) {
                var buyer = data1.toJson();
                buyer.remove("type");
                buyer.remove("token");
                buyer.remove("email_verified");
                buyer.remove("kyc_completed");
                buyer.remove("kyc_completed");
                return SellerChatBox(
                  sellerData: data["checkout_items"]["owner"],
                  buyerData: buyer,
                  serviceId: data["checkout_items"]["_id"] ?? '',
                );
              },
              error: (error, stackTrace) => Text(error.toString()),
              loading: () => const SizedBox(),
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
              child: ServiceOrderStatusWidget(
                orderStatus: data["order_status"].toString(),
                createdAt: data["createdAt"].toString(),
                updatedAt: data["updatedAt"].toString(),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ServiceOrderStatusWidget extends StatelessWidget {
  final String orderStatus;
  final String createdAt;
  final String updatedAt;
  const ServiceOrderStatusWidget({
    super.key,
    required this.orderStatus,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Order Status",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
        const SizedBox(height: 10.0),
        OrderStatusItem(
          title: "Order Placed",
          subtitle: "An order has been placed.",
          date: sondyaFormattedDate(updatedAt),
          icon: Icons.shopping_cart,
          isCompleted: orderStatus == "order placed" ||
              orderStatus == "IN PROGRESS" ||
              orderStatus == "delivered",
        ),
        OrderStatusItem(
          title: "Progress",
          subtitle: "Seller is proccessing your order.",
          date: sondyaFormattedDate(updatedAt),
          icon: Icons.book,
          isCompleted:
              orderStatus == "IN PROGRESS" || orderStatus == "delivered",
        ),
        OrderStatusItem(
          title: "Delivered",
          date: sondyaFormattedDate(updatedAt),
          icon: Icons.handshake_outlined,
          isCompleted: orderStatus == "delivered",
        ),
      ],
    );
  }
}
