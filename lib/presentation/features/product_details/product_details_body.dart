import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sondya_app/data/remote/home.dart';
import 'package:sondya_app/presentation/widgets/picture_slider.dart';
import 'package:sondya_app/presentation/widgets/price_formatter.dart';
import 'package:sondya_app/presentation/widgets/ratings_widget.dart';
import 'package:sondya_app/presentation/widgets/select_widget.dart';

class ProductDetailsBody extends ConsumerStatefulWidget {
  final String id;
  final String name;
  const ProductDetailsBody({super.key, required this.id, required this.name});

  @override
  ConsumerState<ProductDetailsBody> createState() => _ProductDetailsBodyState();
}

class _ProductDetailsBodyState extends ConsumerState<ProductDetailsBody> {
  @override
  Widget build(BuildContext context) {
    final getProductDetails = ref
        .watch(getProductDetailsProvider((id: widget.id, name: widget.name)));
    final getProductRatingStat =
        ref.watch(getReviewStatsProvider((category: "product", id: widget.id)));

    getProductRatingStat.whenData((data) {
      debugPrint(data.toString());
    });

    return SingleChildScrollView(
      child: Center(
        child: Container(
          height: 1000,
          padding: const EdgeInsets.all(10),
          child: getProductDetails.when(
            data: (data) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      IconButton(
                          iconSize: 30,
                          onPressed: () {
                            context.pop();
                          },
                          icon: const Icon(Icons.arrow_back))
                    ],
                  ),
                  SondyaPictureSlider(
                    pictureList: data["data"]["image"],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  getProductRatingStat.when(
                    data: (data) {
                      return Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SondyaStarRating(
                            averageRating:
                                (data["data"]["averageRating"] as int)
                                    .toDouble(),
                          ),
                          Text(
                            "${data["data"]["totalReviews"]} Star Rating",
                            style: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w600),
                          ),
                        ],
                      );
                    },
                    loading: () => const CupertinoActivityIndicator(),
                    error: (error, stackTrace) => Text(error.toString()),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    data["data"]["name"],
                    style: GoogleFonts.playfairDisplay(
                        fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      RichText(
                        text: TextSpan(
                          style: const TextStyle(fontWeight: FontWeight.w600),
                          children: [
                            const TextSpan(
                              text: 'Model:',
                              style: TextStyle(color: Color(0xFF5F6C72)),
                            ),
                            TextSpan(
                              text: data["data"]["model"],
                              style: const TextStyle(color: Color(0xFF000000)),
                            ),
                          ],
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          style: const TextStyle(fontWeight: FontWeight.w600),
                          children: [
                            const TextSpan(
                              text: 'Availability:',
                              style: TextStyle(color: Color(0xFF5F6C72)),
                            ),
                            TextSpan(
                              text: data["data"]["product_status"],
                              style: const TextStyle(color: Color(0xFFEDB842)),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      RichText(
                        text: TextSpan(
                          style: const TextStyle(fontWeight: FontWeight.w600),
                          children: [
                            const TextSpan(
                              text: 'Brand:',
                              style: TextStyle(color: Color(0xFF5F6C72)),
                            ),
                            TextSpan(
                              text: data["data"]["brand"],
                              style: const TextStyle(color: Color(0xFF000000)),
                            ),
                          ],
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          style: const TextStyle(fontWeight: FontWeight.w600),
                          children: [
                            const TextSpan(
                              text: 'Category:',
                              style: TextStyle(color: Color(0xFF5F6C72)),
                            ),
                            TextSpan(
                              text: data["data"]["sub_category"],
                              style: const TextStyle(color: Color(0xFFEDB842)),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      PriceFormatWidget(
                        price:
                            (data["data"]["current_price"] as int).toDouble(),
                        fontSize: 15,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      PriceFormatWidget(
                        price: (data["data"]["old_price"] as int).toDouble(),
                        oldPrice: true,
                        fontSize: 15,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Container(
                        padding: const EdgeInsets.all(
                            8.0), // Adjust padding as needed
                        decoration: BoxDecoration(
                          color: const Color(0xFFEDB842), // Background color
                          borderRadius: BorderRadius.circular(
                              8.0), // Optional: Rounded corners
                        ),
                        child: Text(
                          "${data["data"]["discount_percentage"]} %off",
                          style: const TextStyle(
                            color: Colors.white, // Text color
                            fontSize: 16.0, // Font size
                            fontWeight: FontWeight.bold, // Font weight
                          ),
                        ),
                      )
                    ],
                  ),
                  const Divider(),
                  const SizedBox(
                    height: 8,
                  ),
                  const Text('Select Variant:', style: TextStyle(fontSize: 20)),
                  Wrap(
                    spacing: 5.0, // horizontal spacing between items
                    runSpacing: 5.0, // vertical spacing between lines
                    children: data["data"]["variants"]
                            ?.entries
                            ?.map<Widget>((entry) {
                          final key = entry.key;
                          final value = entry.value;
                          if (data["data"]["variants"].isNotEmpty) {
                            return SizedBox(
                              width: 200,
                              child: OutlinedButton(
                                onPressed: () async {
                                  SondyaSelectWidget().showBottomSheet<String>(
                                    options: value.whereType<String>().toList(),
                                    context: context,
                                    onItemSelected: (value) {},
                                  );
                                },
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      key.toString(),
                                      style: const TextStyle(fontSize: 12),
                                    ),
                                    const Icon(Icons.arrow_drop_down),
                                  ],
                                ),
                              ),
                            );
                          } else {
                            return const Text("No variants");
                          }
                        })?.toList() ??
                        [],
                  ),
                ],
              );
            },
            loading: () => const CupertinoActivityIndicator(),
            error: (error, stackTrace) => Text(error.toString()),
          ),
        ),
      ),
    );
  }
}
