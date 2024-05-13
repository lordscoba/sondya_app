import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SellerWithdrawalsBody extends StatelessWidget {
  const SellerWithdrawalsBody({super.key});

  @override
  Widget build(BuildContext context) {
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
              const SizedBox(height: 10.0),
              const Text(
                "Withdrawal",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10.0),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  SizedBox(
                    width: 200,
                    height: 50,
                    child: OutlinedButton(
                      onPressed: () {},
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.add),
                          SizedBox(width: 5.0),
                          Text(
                            "Add Account",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 200,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.send),
                          SizedBox(width: 5.0),
                          Text(
                            "Withdraw",
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
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  Container(
                    width: 160,
                    height: 160,
                    padding: const EdgeInsets.all(10.0),
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Total Funds"),
                        SizedBox(height: 10.0),
                        Text("\$0"),
                      ],
                    ),
                  ),
                  Container(
                    width: 160,
                    height: 160,
                    padding: const EdgeInsets.all(10.0),
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Pending Withdrawal",
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 10.0),
                        Text("\$0"),
                      ],
                    ),
                  ),
                  Container(
                    width: 160,
                    height: 160,
                    padding: const EdgeInsets.all(10.0),
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Completed"),
                        SizedBox(height: 10.0),
                        Text("\$0"),
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(height: 10.0),
              const Text(
                "Withdrawal History",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10.0),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columns: const <DataColumn>[
                    DataColumn(
                      label: Text(
                        'Order date',
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Sellers Name',
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Account Details',
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Amount',
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Withdrawal Mode',
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Status',
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Action',
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                    ),
                  ],
                  rows: const <DataRow>[
                    DataRow(
                      cells: <DataCell>[
                        DataCell(Text('December 28, 2023')),
                        DataCell(Text('lordscoba2tm@gmail.com')),
                        DataCell(Text('AccessBank')),
                        DataCell(Text('\$123')),
                        DataCell(Text('bank')),
                        DataCell(Text('success')),
                        DataCell(Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.visibility),
                            Icon(Icons.delete)
                          ],
                        )),
                      ],
                    ),
                    DataRow(
                      cells: <DataCell>[
                        DataCell(Text('December 28, 2023')),
                        DataCell(Text('lordscoba2tm@gmail.com')),
                        DataCell(Text('AccessBank')),
                        DataCell(Text('\$123')),
                        DataCell(Text('bank')),
                        DataCell(Text('success')),
                        DataCell(Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.visibility),
                            Icon(Icons.delete)
                          ],
                        )),
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
