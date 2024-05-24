import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sondya_app/data/remote/user.order.dart';
import 'package:sondya_app/presentation/widgets/price_formatter.dart';
import 'package:sondya_app/utils/dateTime_to_string.dart';

class ServiceOrderHistoryBody extends ConsumerWidget {
  const ServiceOrderHistoryBody({super.key});

  final leadStyle = const TextStyle(fontSize: 15);
  final trailStyle = const TextStyle(fontSize: 15, color: Color(0xFFEDB842));
  final subStyle = const TextStyle(fontSize: 15, color: Color(0xFFFA8232));
  final titleStyle = const TextStyle(fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final getServiceOrder = ref.watch(getUserServiceOrdersProvider);
    // getServiceOrder.whenData((data) {
    //   print(data);
    // });
    return SingleChildScrollView(
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
            const Divider(),
            const SizedBox(height: 20.0),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                "Recent Order",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.start,
              ),
            ),
            const Divider(),
            getServiceOrder.when(
              data: (data) {
                return ListView.separated(
                    itemCount: data.length,
                    shrinkWrap: true,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 20.0),
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(data[index]["order_id"], style: leadStyle),
                            SizedBox(
                              width: 150,
                              child: Text(
                                data[index]["checkout_items"]["name"],
                                style: leadStyle,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        title: Text(
                            sondyaFormattedDate(data[index]["createdAt"]),
                            style: titleStyle),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            PriceFormatWidget(
                              price: data[index]["checkout_items"]
                                          ["current_price"] ==
                                      null
                                  ? 0.0
                                  : data[index]["checkout_items"]
                                              ["current_price"]
                                          .toDouble() ??
                                      0.0,
                              fontSize: 16,
                            ),
                            TextButton(
                              onPressed: () {
                                context.push(
                                    '/service/order/details/${data[index]["_id"]}',
                                    extra: data[index]);
                              },
                              child: Text(
                                "View",
                                style: trailStyle,
                              ),
                            ),
                          ],
                        ),
                        subtitle: Text(
                          data[index]["order_status"] ?? "",
                          style: TextStyle(
                              fontSize: 15,
                              color:
                                  data[index]["order_status"] == "order placed"
                                      ? Colors.green
                                      : const Color(0xFFFA8232)),
                        ),
                      );
                    });
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
