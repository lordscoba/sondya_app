import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sondya_app/presentation/widgets/price_formatter.dart';

class SellerServiceOrdersBody extends StatelessWidget {
  const SellerServiceOrdersBody({super.key});

  final leadStyle = const TextStyle(fontSize: 15);
  final trailStyle = const TextStyle(fontSize: 15, color: Color(0xFFEDB842));
  final subStyle = const TextStyle(fontSize: 15, color: Color(0xFFFA8232));
  final titleStyle = const TextStyle(fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
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
                "Recent Order",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.start,
              ),
            ),
            const Divider(),
            ListView(
              shrinkWrap: true,
              children: [
                const SizedBox(height: 20.0),
                ListTile(
                  leading: Column(
                    children: [
                      Text("#96459761", style: leadStyle),
                      Text("Car wash", style: leadStyle),
                    ],
                  ),
                  title: Text("Dec 30, 2023", style: titleStyle),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const PriceFormatWidget(
                        price: 100.0,
                        fontSize: 16,
                      ),
                      TextButton(
                        onPressed: null,
                        child: Text(
                          "View",
                          style: trailStyle,
                        ),
                      ),
                    ],
                  ),
                  subtitle: Text(
                    "IN PROGRESS",
                    style: subStyle,
                  ),
                ),
                const SizedBox(height: 20.0),
                ListTile(
                  leading: Column(
                    children: [
                      Text("#96459761", style: leadStyle),
                      Text("Car wash", style: leadStyle),
                    ],
                  ),
                  title: Text("Dec 30, 2023", style: titleStyle),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const PriceFormatWidget(
                        price: 100.0,
                        fontSize: 16,
                      ),
                      TextButton(
                        onPressed: null,
                        child: Text(
                          "View",
                          style: trailStyle,
                        ),
                      ),
                    ],
                  ),
                  subtitle: Text(
                    "IN PROGRESS",
                    style: subStyle,
                  ),
                ),
                const SizedBox(height: 20.0),
                ListTile(
                  leading: Column(
                    children: [
                      Text("#96459761", style: leadStyle),
                      Text("Car wash", style: leadStyle),
                    ],
                  ),
                  title: Text("Dec 30, 2023", style: titleStyle),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const PriceFormatWidget(
                        price: 100.0,
                        fontSize: 16,
                      ),
                      TextButton(
                        onPressed: null,
                        child: Text(
                          "View",
                          style: trailStyle,
                        ),
                      ),
                    ],
                  ),
                  subtitle: Text(
                    "IN PROGRESS",
                    style: subStyle,
                  ),
                ),
              ],
            ),
            const Divider()
          ],
        ),
      ),
    );
  }
}
