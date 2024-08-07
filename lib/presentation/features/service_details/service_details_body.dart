import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sondya_app/data/local/storedValue.dart';
import 'package:sondya_app/data/remote/home.dart';
import 'package:sondya_app/data/remote/reviews.dart';
import 'package:sondya_app/domain/providers/user.order.provider.dart';
import 'package:sondya_app/domain/providers/wishlist.provider.dart';
import 'package:sondya_app/presentation/features/product_details/review_section.dart';
import 'package:sondya_app/presentation/features/service_details/seller_chat_box.dart';
import 'package:sondya_app/presentation/widgets/picture_slider.dart';
import 'package:sondya_app/presentation/widgets/price_formatter.dart';
import 'package:sondya_app/presentation/widgets/ratings_widget.dart';
import 'package:sondya_app/presentation/widgets/success_error_message.dart';
import 'package:sondya_app/presentation/widgets/threebounce_loader.dart';
import 'package:sondya_app/utils/parse_string.dart';

class ServiceDetailsBody extends ConsumerStatefulWidget {
  final String id;
  final String name;
  const ServiceDetailsBody({super.key, required this.id, required this.name});

  @override
  ConsumerState<ServiceDetailsBody> createState() => _ServiceDetailsBodyState();
}

class _ServiceDetailsBodyState extends ConsumerState<ServiceDetailsBody> {
  final ScrollController _scrollController = ScrollController();

  late Map<String, dynamic> createOrderData;

  bool serviceOrdered = false;
  @override
  void initState() {
    super.initState();
    createOrderData = {
      "order_status": "IN PROGRESS",
      "payment_status": "",
      "payment_method": "",
      "seller": {},
      "buyer": {},
      "checkout_items": {},
      "order_id": "",
    };

    // print(widget.id);
  }

  void _scrollToSection(double position) {
    _scrollController.animateTo(
      position,
      duration: const Duration(seconds: 1),
      curve: Curves.easeInOut,
    );
  }

  var isFavorite = false;

  @override
  Widget build(BuildContext context) {
    final getServiceDetails = ref
        .watch(getServiceDetailsProvider((id: widget.id, name: widget.name)));
    final getServiceRatingStat =
        ref.watch(getReviewStatsProvider((category: "service", id: widget.id)));

    final myData = ref.watch(storedAuthValueProvider);

    final AsyncValue<Map<String, dynamic>> checkState1 =
        ref.watch(createUserServiceOrderProvider);

    // final checkServiceOrder = ref.watch(checkUserServiceOrderProvider);
    return RefreshIndicator(
      onRefresh: () async {
        // ignore: unused_result
        ref.refresh(
            getServiceDetailsProvider((id: widget.id, name: widget.name)));
        // ignore: unused_result
        ref.refresh(
            getReviewStatsProvider((category: "service", id: widget.id)));
      },
      child: SingleChildScrollView(
        controller: _scrollController,
        physics: const BouncingScrollPhysics(),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(minHeight: 2500),
            child: Container(
              // height: 2700,
              padding: const EdgeInsets.all(10),
              child: getServiceDetails.when(
                data: (data) {
                  // var checkData = {
                  //   "seller_id": data["data"]["owner"]["username"],
                  //   "service_id": data["data"]["_id"]
                  // };
                  // final checkServiceOrder =
                  //     ref.watch(checkUserServiceOrderProvider(checkData));
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      context.canPop()
                          ? Row(
                              children: [
                                IconButton(
                                  iconSize: 30,
                                  onPressed: () {
                                    context.pop();
                                  },
                                  icon: const Icon(Icons.arrow_back),
                                )
                              ],
                            )
                          : Container(),
                      checkState1.when(
                        data: (data) {
                          return sondyaDisplaySuccessMessage(
                              context, data["message"]);
                        },
                        loading: () => const SizedBox(),
                        error: (error, stackTrace) {
                          // debugPrint(error.toString());
                          if (error.toString() ==
                              "Error: service order already exists") {
                            setState(() {
                              serviceOrdered = true;
                            });
                          }
                          return sondyaDisplayErrorMessage(
                              error.toString(), context);
                        },
                      ),
                      Text(
                        data["data"]["name"],
                        style: const TextStyle(
                            fontSize: 25, fontWeight: FontWeight.w600),
                      ),
                      getServiceRatingStat.when(
                        data: (dataR) {
                          // debugPrint(data["data"]["owner"]["username"]);
                          return Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(data["data"]["owner"]["username"].isNotEmpty
                                  ? data["data"]["owner"]["username"]
                                  : data["data"]["owner"]["email"]),
                              SondyaStarRating(
                                averageRating:
                                    dataR["data"]["averageRating"].toDouble() ??
                                        0.0,
                                starColor: const Color(0xFFEDB842),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                dataR["data"]["averageRating"].toString(),
                                style: const TextStyle(
                                    color: Color(0xFFEDB842), fontSize: 18),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                "(${dataR["data"]["totalReviews"]})",
                                style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xFFEDB842)),
                              ),
                            ],
                          );
                        },
                        loading: () => sondyaThreeBounceLoader(),
                        error: (error, stackTrace) => Text(error.toString()),
                      ),
                      SondyaPictureSlider(
                        pictureList: data["data"]["image"],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        margin: const EdgeInsets.all(8),
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black38,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(2),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const Text(
                              "Service Package",
                              style: TextStyle(
                                fontSize: 20,
                                color: Color(0xFFEDB842),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            const Divider(),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text("GIG"),
                                // Text("\$500"),
                                PriceFormatWidget(
                                  price: data["data"]["current_price"]
                                          .toDouble() ??
                                      0.0,
                                  fontSize: 18,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.8,
                              child: const Text(
                                "Brief Description",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Color(0xFFEDB842),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              data["data"]["brief_description"],
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            Text(
                              "${data["data"]["duration"]} Days Delivery",
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            serviceOrdered
                                ? ElevatedButton(
                                    onPressed: () {
                                      context.push(
                                          '/service/checkout/${data["data"]["owner"]["id"]}/${data["data"]["_id"]}');
                                    },
                                    child: const Text("Continue "),
                                  )
                                : ElevatedButton(
                                    onPressed: () {
                                      createOrderData["seller"] =
                                          data["data"]["owner"];
                                      createOrderData["checkout_items"] =
                                          data["data"];
                                      createOrderData["seller"] =
                                          data["data"]["owner"];
                                      createOrderData["checkout_items"]
                                          ["terms"] = {
                                        "amount": data["data"]["current_price"]
                                                .toDouble() ??
                                            0.0,
                                        "duration": parseDuration(
                                            data["data"]["duration"]),
                                        "durationUnit": "hours",
                                        "acceptedByBuyer": false,
                                        "acceptedBySeller": false,
                                        "rejectedByBuyer": true,
                                        "rejectedBySeller": true,
                                      };
                                      // print(
                                      // createOrderData["checkout_items"]["terms"]);
                                      // debugPrint(createOrderData.toString());

                                      ref
                                          .read(createUserServiceOrderProvider
                                              .notifier)
                                          .createOrder(
                                              createOrderData, widget.id);
                                    },
                                    child: checkState1.isLoading
                                        ? sondyaThreeBounceLoader(
                                            color: Colors.white)
                                        : const Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text("Order Service "),
                                              Icon(Icons.arrow_forward),
                                            ],
                                          ),
                                  ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      isFavorite = !isFavorite;
                                      if (isFavorite) {
                                        ref
                                            .read(
                                                addToWishlistProvider.notifier)
                                            .addToWishlist(widget.id, "service",
                                                widget.name);
                                      } else {
                                        ref
                                            .read(removeFromWishlistProvider
                                                .notifier)
                                            .removeFromWishlist(
                                                widget.id, "service");
                                      }
                                    });
                                  },
                                  icon: Icon(
                                    isFavorite
                                        ? Icons.favorite
                                        : Icons.favorite_outline,
                                    size: 15,
                                    color: const Color(0xFFEDB842),
                                  ),
                                ),
                                const Text("Add to Wishlist"),
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            OutlinedButton(
                                onPressed: () {
                                  _scrollToSection(1400);
                                },
                                child: const Text("Contact Seller")),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        "About this service",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: Text(
                          data["data"]["description"],
                          style: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w400),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        "About the seller",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(Icons.person_outline),
                          const SizedBox(
                            width: 10,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.75,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    "${data["data"]["owner"]["username"]}, ${data["data"]["owner"]["email"]}"),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.7,
                                  child: Text(data["data"]
                                          ["location_description"] ??
                                      ''),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Container(
                        margin: const EdgeInsets.all(8),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black38,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(2),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "From",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xFF74767E),
                                  ),
                                ),
                                Text(
                                  data["data"]["country"] ?? "N/A",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF62646A),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Text(
                                  "State",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xFF74767E),
                                  ),
                                ),
                                Text(
                                  data["data"]["state"] ?? "N/A",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF62646A),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Text(
                                  "City",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xFF74767E),
                                  ),
                                ),
                                Text(
                                  data["data"]["city"] ?? "N/A",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF62646A),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Text(
                                  "Website Link",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xFF74767E),
                                  ),
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.3,
                                  child: Text(
                                    data["data"]["website_link"] ?? "N/A",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFF62646A),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Email",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xFF74767E),
                                  ),
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  child: Text(
                                    data["data"]["email"] ?? "N/A",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFF62646A),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Text(
                                  "Phone Number",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xFF74767E),
                                  ),
                                ),
                                Text(
                                  data["data"]["phone_number"] ?? "N/A",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF62646A),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  child: const Text(
                                    "Phone Number Back Up",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xFF74767E),
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Text(
                                  data["data"]["phone_number_backup"] ?? "N/A",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF62646A),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Text(
                                  "Map Location",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xFF74767E),
                                  ),
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  child: Text(
                                    data["data"]["map_location_link"] ?? "N/A",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFF62646A),
                                    ),
                                  ),
                                ),
                              ],
                            ),
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
                            sellerData: data["data"]["owner"],
                            buyerData: buyer,
                            serviceId: data["data"]["_id"] ?? '',
                          );
                        },
                        error: (error, stackTrace) => Text(error.toString()),
                        loading: () => const SizedBox(),
                      ),
                      const Divider(),
                      const SizedBox(
                        height: 20,
                      ),
                      ReviewSection(
                        userId: "",
                        category: data["data"]["category"] ?? 'service',
                        productId: data["data"]["_id"] ?? '',
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  );
                },
                loading: () => const CupertinoActivityIndicator(),
                error: (error, stackTrace) => Text(error.toString()),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
