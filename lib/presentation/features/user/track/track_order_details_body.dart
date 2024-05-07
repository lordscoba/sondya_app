import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TrackOrderDetailsBody extends StatelessWidget {
  const TrackOrderDetailsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(10.0),
          child: Column(
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
              const Text("Order ID:#91743127", style: TextStyle(fontSize: 20)),
              const SizedBox(height: 20.0),
              const Text(
                "Order date:",
                style: TextStyle(
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
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10.0),
                      Row(
                        children: [
                          const Icon(
                            Icons.book,
                            color: Color(0xFFEDB842),
                            size: 28,
                          ),
                          const SizedBox(width: 10),
                          Container(
                            width: 30,
                            height: 30,
                            padding: const EdgeInsets.all(3.0),
                            decoration: const BoxDecoration(
                              color: Color(0xFFEDB842),
                              shape: BoxShape.circle,
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 24,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          const Text("Order Placed"),
                        ],
                      ),
                      const SizedBox(height: 10.0),
                      Row(
                        children: [
                          const Icon(
                            Icons.luggage_outlined,
                            color: Color(0xFFEDB842),
                            size: 28,
                          ),
                          const SizedBox(width: 10),
                          Container(
                            width: 30,
                            height: 30,
                            padding: const EdgeInsets.all(3.0),
                            decoration: const BoxDecoration(
                              color: Color(0xFFEDB842),
                              shape: BoxShape.circle,
                            ),
                            // child: const Center(
                            //   child: Icon(
                            //     Icons.check,
                            //     color: Colors.white,
                            //     size: 24,
                            //   ),
                            // ),
                          ),
                          const SizedBox(width: 10),
                          const Text("Packaging"),
                        ],
                      ),
                      const SizedBox(height: 10.0),
                      Row(
                        children: [
                          const Icon(
                            Icons.local_shipping,
                            color: Color(0xFFEDB842),
                            size: 28,
                          ),
                          const SizedBox(width: 10),
                          Container(
                            width: 30,
                            height: 30,
                            padding: const EdgeInsets.all(3.0),
                            decoration: const BoxDecoration(
                              color: Color(0xFFEDB842),
                              shape: BoxShape.circle,
                            ),
                            // child: const Center(
                            //   child: Icon(
                            //     Icons.check,
                            //     color: Colors.white,
                            //     size: 24,
                            //   ),
                            // ),
                          ),
                          const SizedBox(width: 10),
                          const Text("On The Road"),
                        ],
                      ),
                      const SizedBox(height: 10.0),
                      Row(
                        children: [
                          const Icon(
                            Icons.handshake,
                            color: Color(0xFFEDB842),
                            size: 28,
                          ),
                          const SizedBox(width: 10),
                          Container(
                            width: 30,
                            height: 30,
                            padding: const EdgeInsets.all(3.0),
                            decoration: const BoxDecoration(
                              color: Color(0xFFEDB842),
                              shape: BoxShape.circle,
                            ),
                            // child: const Center(
                            //   child: Icon(
                            //     Icons.check,
                            //     color: Colors.white,
                            //     size: 24,
                            //   ),
                            // ),
                          ),
                          const SizedBox(width: 10),
                          const Text("Delivered"),
                        ],
                      ),
                      const SizedBox(height: 10.0),
                    ],
                  ),
                  const Column(
                    children: [
                      Image(
                        image: AssetImage("assets/images/success_picture.png"),
                        width: 100,
                      ),
                      SizedBox(
                        width: 200,
                        child: Text(
                          "Sondya App product",
                          style: TextStyle(fontSize: 18),
                        ),
                      )
                    ],
                  )
                ],
              ),
              const SizedBox(height: 40.0),
              const Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Origin",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 20),
                      Text("Address"),
                      SizedBox(height: 5),
                      Text("5167277272"),
                      SizedBox(height: 5),
                      Text("Uyo, Nigeria"),
                      SizedBox(height: 5),
                      Text("+23808726262"),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Destination",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 20),
                      Text("Address"),
                      SizedBox(height: 5),
                      Text("5167277272"),
                      SizedBox(height: 5),
                      Text("Uyo, Nigeria"),
                      SizedBox(height: 5),
                      Text("+23808726262"),
                    ],
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
                  rows: const <DataRow>[
                    DataRow(
                      cells: <DataCell>[
                        DataCell(Text('Nigeria')),
                        DataCell(Text('Akwa Ibom')),
                        DataCell(Text('Uyo')),
                        DataCell(Text('123456')),
                        DataCell(Text('Delivered')),
                      ],
                    ),
                    DataRow(
                      cells: <DataCell>[
                        DataCell(Text('Nigeria')),
                        DataCell(Text('Akwa Ibom')),
                        DataCell(Text('Uyo')),
                        DataCell(Text('123456')),
                        DataCell(Text('Delivered')),
                      ],
                    ),
                    DataRow(
                      cells: <DataCell>[
                        DataCell(Text('Nigeria')),
                        DataCell(Text('Akwa Ibom')),
                        DataCell(Text('Uyo')),
                        DataCell(Text('123456')),
                        DataCell(Text('Delivered')),
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
