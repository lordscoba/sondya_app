import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sondya_app/data/remote/reviews.dart';
import 'package:sondya_app/domain/models/reviews.dart';
import 'package:sondya_app/domain/providers/review.provider.dart';
import 'package:sondya_app/presentation/widgets/ratings_widget.dart';
import 'package:sondya_app/presentation/widgets/success_error_message.dart';
import 'package:sondya_app/presentation/widgets/threebounce_loader.dart';
import 'package:sondya_app/utils/auth_utils.dart';
import 'package:sondya_app/utils/input_validations.dart';

class ReviewSection extends ConsumerStatefulWidget {
  final String? userId;
  final String productId;
  final String category;
  const ReviewSection({
    super.key,
    this.userId,
    required this.productId,
    required this.category,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ReviewSectionState();
}

class _ReviewSectionState extends ConsumerState<ReviewSection> {
  late int limit;
  late int page;
  late String search;

  @override
  void initState() {
    super.initState();
    limit = 5;
    page = 1;
    search = "";
  }

  @override
  Widget build(BuildContext context) {
    debugPrint(widget.productId);
    final getProductRatingStat = ref.watch(getReviewStatsProvider(
        (category: widget.category, id: widget.productId)));
    final getRatingList = ref.watch(getReviewListProvider((
      category: widget.category,
      id: widget.productId,
      limit: limit,
      page: page,
      search: search
    )));
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Reviews",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
        ),
        const SizedBox(
          height: 10,
        ),
        getProductRatingStat.when(
          data: (data) {
            // print(data);
            return Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                    "${data["data"]["totalReviews"] ?? 0} reviews for this ${widget.category}",
                    style: const TextStyle(fontSize: 16)),
                SondyaStarRating(
                    averageRating: data["data"]["averageRating"].toDouble()),
                Text("(${data["data"]["averageRating"].toDouble().toString()})",
                    style: const TextStyle(fontSize: 16)),
              ],
            );
          },
          loading: () => sondyaThreeBounceLoader(),
          error: (error, stackTrace) => Text(error.toString()),
        ),
        const SizedBox(
          height: 10,
        ),
        TextField(
          decoration: InputDecoration(
            suffixIcon: Container(
              decoration: const BoxDecoration(
                color: Color(0xFFEDB842),
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10), // Adjust the radius as needed
                  bottomRight:
                      Radius.circular(10), // Adjust the radius as needed
                ),
              ),
              width: 80,
              child: IconButton(
                iconSize: 30,
                onPressed: () {},
                icon: const Icon(Icons.search),
              ),
            ),
          ),
          onChanged: (value) {
            setState(() {
              search = value;
              page = 1;
            });
          },
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          padding: const EdgeInsets.all(10),
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius:
                BorderRadius.circular(10), // Adjust the border radius as needed
            border: Border.all(
              color: Colors.grey, // Border color
              width: 1, // Border width
            ),
          ),
          child: CreateReviewWidget(
            category: widget.category,
            id: widget.productId,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        const Divider(),
        const SizedBox(
          height: 10,
        ),
        getRatingList.when(
          data: (data) {
            // print(data);
            return SizedBox(
              height: data["data"].length <= 0
                  ? 50.00
                  : data["data"].length * 100.00,
              width: double.infinity,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: data["data"].length > 0 ? data["data"].length : 1,
                itemBuilder: (context, index) {
                  if (data["data"] != null && data["data"].isNotEmpty) {
                    return ReviewSectionTile(
                      imageString: data["data"][index]["user_id"]["image"] !=
                                  null &&
                              data["data"][index]["user_id"]["image"].isNotEmpty
                          ? data["data"][index]["user_id"]["image"][0]["url"]
                          : "https://cdn-icons-png.flaticon.com/512/3135/3135715.png",
                      emailUsername: data["data"][index]["user_id"]["username"]
                              .isEmpty
                          ? data["data"][index]["user_id"]["email"]
                          : data["data"][index]["user_id"]["username"] ?? "",
                      country: '',
                      rating: data["data"][index]["rating"],
                      review: data["data"][index]["review"],
                    );
                  }
                  return const Text("No reviews found");
                },
              ),
            );
          },
          loading: () => sondyaThreeBounceLoader(),
          error: (error, stackTrace) => Text(error.toString()),
        ),
        const SizedBox(
          height: 10,
        ),
        TextButton(
          onPressed: () {
            setState(() {
              limit = 5;
              page = page + 1;
            });
          },
          child: const Row(
            children: [
              Icon(
                Icons.add,
                size: 20,
                color: Color(0xFFEDB842),
              ),
              Text(
                "See More Reviews",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Color(0xFFEDB842)),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class CreateReviewWidget extends ConsumerStatefulWidget {
  final String id;
  final String category;
  final int limit;
  final int page;
  final String search;
  const CreateReviewWidget(
      {super.key,
      required this.id,
      required this.category,
      this.limit = 5,
      this.page = 1,
      this.search = ""});

  @override
  ConsumerState<CreateReviewWidget> createState() => _CreateReviewWidgetState();
}

class _CreateReviewWidgetState extends ConsumerState<CreateReviewWidget> {
  late int createRating;

  late CreateReviewType review;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    review = CreateReviewType();
    createRating = 0;
  }

  @override
  Widget build(BuildContext context) {
    final AsyncValue<Map<String, dynamic>> checkState =
        ref.watch(createReviewProvider);
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          checkState.when(
            data: (data) {
              return sondyaDisplaySuccessMessage(context, data["message"]);
            },
            loading: () => const SizedBox(),
            error: (error, stackTrace) {
              return sondyaDisplayErrorMessage(error.toString(), context);
            },
          ),
          const Text(
            "Write a review",
            style: TextStyle(fontSize: 20),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: () {
                  setState(() {
                    createRating = 1;
                  });
                },
                icon: createRating >= 1
                    ? const Icon(Icons.star)
                    : const Icon(Icons.star_border),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    createRating = 2;
                  });
                },
                icon: createRating >= 2
                    ? const Icon(Icons.star)
                    : const Icon(Icons.star_border),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    createRating = 3;
                  });
                },
                icon: createRating >= 3
                    ? const Icon(Icons.star)
                    : const Icon(Icons.star_border),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    createRating = 4;
                  });
                },
                icon: createRating >= 4
                    ? const Icon(Icons.star)
                    : const Icon(Icons.star_border),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    createRating = 5;
                  });
                },
                icon: createRating >= 5
                    ? const Icon(Icons.star)
                    : const Icon(Icons.star_border),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            validator: isInputEmpty,
            maxLines: 6, // Allows unlimited lines
            keyboardType: TextInputType.multiline, // Adjust keyboard type
            decoration: const InputDecoration(
              hintText: "Enter your text here...",
            ),
            onChanged: (value) {
              review.review = value;
            },
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 45,
            child: ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState?.save();

                  if (createRating == 0) {
                    AnimatedSnackBar.rectangle(
                      'Error',
                      "Please select a rating",
                      type: AnimatedSnackBarType.warning,
                      brightness: Brightness.light,
                    ).show(
                      context,
                    );
                  } else if (!isAuthenticated()) {
                    AnimatedSnackBar.rectangle(
                      'Error',
                      "You have to be logged in to post reviews",
                      type: AnimatedSnackBarType.warning,
                      brightness: Brightness.light,
                    ).show(context);
                  } else {
                    review.rating = createRating;
                    if (widget.category == "service") {
                      review.serviceId = widget.id;
                    } else {
                      review.productId = widget.id;
                    }

                    ref
                        .read(createReviewProvider.notifier)
                        .createReview(review.toJson());

                    // ignore: unused_result
                    ref.refresh(getReviewStatsProvider(
                        (category: widget.category, id: widget.id)));

                    // ignore: unused_result
                    ref.refresh(getReviewListProvider((
                      category: widget.category,
                      id: widget.id,
                      limit: widget.limit,
                      page: widget.page,
                      search: widget.search
                    )));
                  }
                } else {
                  AnimatedSnackBar.rectangle(
                    'Error',
                    "Please fill all the fields",
                    type: AnimatedSnackBarType.warning,
                    brightness: Brightness.light,
                  ).show(
                    context,
                  );
                }
              },
              child: checkState.isLoading
                  ? sondyaThreeBounceLoader(color: Colors.white)
                  : const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text("Publish Review"),
                        SizedBox(
                          width: 10,
                        ),
                        Icon(Icons.arrow_forward),
                      ],
                    ),
            ),
          ),
        ],
      ),
    );
  }
}

class ReviewSectionTile extends StatelessWidget {
  final String imageString;
  final String emailUsername;
  final String country;
  final int rating;
  final String review;
  const ReviewSectionTile(
      {super.key,
      required this.imageString,
      required this.emailUsername,
      required this.country,
      required this.rating,
      required this.review});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image(
                image: imageString.isNotEmpty
                    ? NetworkImage(imageString)
                    : const AssetImage("assets/images/review_placeholder.png")
                        as ImageProvider,
                height: 50,
                width: 50,
                fit: BoxFit.cover,
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    emailUsername,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      SondyaStarRating(averageRating: rating.toDouble()),
                      const SizedBox(
                        width: 10,
                      ),
                      Text("(${rating.toDouble().toString()})"),
                    ],
                  ),
                  SizedBox(
                    width: 200,
                    child: Text(review),
                  )
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
