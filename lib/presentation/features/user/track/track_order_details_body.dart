import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sondya_app/data/remote/track.dart';
import 'package:sondya_app/presentation/features/user/order/product_order_details_body.dart';
import 'package:sondya_app/utils/dateTime_to_string.dart';

class TrackOrderDetailsBody extends ConsumerWidget {
  final String id;
  const TrackOrderDetailsBody({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final getOrderDetails = ref.watch(getTrackOrderDetailsProvider(id));

    // getOrderDetails.whenData(
    //   (value) {
    //     print(value);
    //   },
    // );

    return SingleChildScrollView(
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(10.0),
          child: getOrderDetails.when(
            data: (data) {
              // print(data["order_location"]);
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20.0),
                  IconButton(
                    onPressed: () {
                      context.pop();
                    },
                    icon: const Icon(Icons.arrow_back),
                  ),
                  const SizedBox(height: 20.0),
                  SelectableText(
                    "Order ID: ${data["order_id"]}",
                    style: const TextStyle(fontSize: 20),
                  ),
                  const SizedBox(height: 20.0),
                  Text(
                    "Order date: ${sondyaFormattedDate(data["createdAt"])}",
                    style: const TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  const Text(
                    "Estimated delivery:",
                    style: TextStyle(
                      fontSize: 15,
                      color: Color(0xFFEDB842),
                    ),
                  ),
                  const SizedBox(height: 30.0),
                  Column(
                    children: [
                      Column(
                        children: [
                          data["checkout_items"]["image"].isEmpty ||
                                  data["checkout_items"]["image"][0]["url"] ==
                                      null
                              ? Container()
                              : Image(
                                  image: NetworkImage(data["checkout_items"]
                                      ["image"][0]["url"]),
                                  width:
                                      MediaQuery.of(context).size.width - 100,
                                  height: 300,
                                  fit: BoxFit.cover,
                                ),
                          const SizedBox(height: 20),
                          SizedBox(
                            width: double.infinity,
                            child: Text(
                              data["checkout_items"]["name"],
                              style: const TextStyle(fontSize: 18),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      OrderStatusWidget(
                        orderStatus: data["order_status"].toLowerCase(),
                        updatedAt: data["updatedAt"],
                        createdAt: data["createdAt"],
                      ),
                    ],
                  ),
                  const SizedBox(height: 40.0),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Origin",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 20),
                            const Text("Address"),
                            const SizedBox(height: 5),
                            Text(data["checkout_items"]["address"] ?? ""),
                            const SizedBox(height: 5),
                            Text(
                                "${data["checkout_items"]?["city"] ?? ""}, ${data["checkout_items"]["state"] ?? ""},  ${data["checkout_items"]["country"] ?? ""}"),
                            const SizedBox(height: 5),
                            Text(data["checkout_items"]["phone_number"] ?? ""),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Destination",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 20),
                            const Text("Address"),
                            const SizedBox(height: 5),
                            Text(data["shipping_destination"]["address"] ?? ""),
                            const SizedBox(height: 5),
                            Text(
                                "${data["shipping_destination"]["city"] ?? ""}, ${data["shipping_destination"]["state"] ?? ""},  ${data["shipping_destination"]["country"] ?? ""}"),
                            const SizedBox(height: 5),
                            Text(data["shipping_destination"]["phone_number"] ??
                                ""),
                          ],
                        ),
                      )
                    ],
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
              );
            },
            error: (error, stackTrace) => Text(error.toString()),
            loading: () => const Center(
              child: CupertinoActivityIndicator(
                radius: 50,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
