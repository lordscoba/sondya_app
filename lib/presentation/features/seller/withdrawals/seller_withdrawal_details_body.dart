import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SellerWithdrawalDetailsBody extends StatelessWidget {
  const SellerWithdrawalDetailsBody({super.key});

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
            const SizedBox(
              height: 8,
            ),
            const Text(
              "Withdrawal Details",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 8,
            ),
            Table(
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              border: TableBorder.all(
                color: const Color(0xFFE0E7E9),
                width: 0.5,
                borderRadius: BorderRadius.circular(5.0),
              ),
              children: [
                TableRow(
                  children: [
                    Container(
                      height: 50,
                      color: const Color(0xFFE0E7E9),
                      padding: const EdgeInsets.all(5.0),
                      child: const Text("Title"),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Text("Value"),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    Container(
                      height: 50,
                      color: const Color(0xFFE0E7E9),
                      padding: const EdgeInsets.all(5.0),
                      child: const Text("Withdrawal ID"),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Text("79916872"),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    Container(
                      height: 50,
                      color: const Color(0xFFE0E7E9),
                      padding: const EdgeInsets.all(5.0),
                      child: const Text("Withdrawn by"),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Text("lordscoba2tm@gmail.com"),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    Container(
                      height: 50,
                      color: const Color(0xFFE0E7E9),
                      padding: const EdgeInsets.all(5.0),
                      child: const Text("Currency"),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Text("USD"),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    Container(
                      height: 50,
                      color: const Color(0xFFE0E7E9),
                      padding: const EdgeInsets.all(5.0),
                      child: const Text("Withdrawal method"),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Text("bank"),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    Container(
                      height: 50,
                      color: const Color(0xFFE0E7E9),
                      padding: const EdgeInsets.all(5.0),
                      child: const Text("Status"),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Text("success"),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    Container(
                      height: 50,
                      color: const Color(0xFFE0E7E9),
                      padding: const EdgeInsets.all(5.0),
                      child: const Text("Date"),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Text("December 28, 2023"),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    Container(
                      height: 50,
                      color: const Color(0xFFE0E7E9),
                      padding: const EdgeInsets.all(5.0),
                      child: const Text("Amount"),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Text("\$10"),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
