import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sondya_app/data/remote/payments.dart';
import 'package:sondya_app/presentation/widgets/price_formatter.dart';
import 'package:sondya_app/utils/dateTime_to_string.dart';

class UserPaymentsBody extends ConsumerWidget {
  const UserPaymentsBody({super.key});

  final leadStyle = const TextStyle(fontSize: 15);
  final trailStyle = const TextStyle(fontSize: 15, color: Color(0xFFEDB842));
  final titleStyle = const TextStyle(fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final getPayments = ref.watch(getUserPaymentsProvider);

    // print("here");
    // getPayments.whenData((data) {
    //   print(data);
    // });

    return SingleChildScrollView(
      child: Center(
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
            const Divider(),
            const SizedBox(height: 20.0),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                "Order payments",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.start,
              ),
            ),
            const Divider(),
            getPayments.when(
              data: (data) {
                return ListView.separated(
                  shrinkWrap: true,
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    // print(data[index]);
                    return ListTile(
                      leading:
                          Text(data[index]["payment_id"], style: leadStyle),
                      title: Text(sondyaFormattedDate(data[index]["createdAt"]),
                          style: titleStyle),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          PriceFormatWidget(
                            price: data[index]["total_amount"] == null
                                ? 0.0
                                : data[index]["total_amount"].toDouble() ?? 0.0,
                            fontSize: 16,
                          ),
                          TextButton(
                            onPressed: () {
                              context.push(
                                "/user/payment/details/${data[index]["_id"]}",
                              );
                            },
                            child: Text(
                              "View",
                              style: trailStyle,
                            ),
                          ),
                        ],
                      ),
                      subtitle: Text(
                        data[index]["payment_status"] ?? "",
                        style: TextStyle(
                            fontSize: 15,
                            color: data[index]["payment_status"] == "successful"
                                ? Colors.green
                                : const Color(0xFFFA8232)),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(height: 20.0);
                  },
                );
              },
              error: (error, stackTrace) => Text(error.toString()),
              loading: () => const Center(
                child: CupertinoActivityIndicator(
                  radius: 50,
                ),
              ),
            ),
            const Divider()
          ],
        ),
      ),
    );
  }
}
