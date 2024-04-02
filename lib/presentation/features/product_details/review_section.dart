import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sondya_app/data/remote/home.dart';
import 'package:sondya_app/presentation/widgets/ratings_widget.dart';
import 'package:sondya_app/presentation/widgets/threebounce_loader.dart';

class ReviewSection extends ConsumerStatefulWidget {
  final String userId;
  final String productId;
  final String category;
  const ReviewSection(
    this.userId, {
    super.key,
    required this.productId,
    required this.category,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ReviewSectionState();
}

class _ReviewSectionState extends ConsumerState<ReviewSection> {
  int limit;
  int page;
  String search;
  int createRating;
  _ReviewSectionState()
      : limit = 5,
        page = 1,
        search = "",
        createRating = 0;

  @override
  Widget build(BuildContext context) {
    // debugPrint(widget.productId);
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
            // debugPrint(data.toString());
            return Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("${data["data"]["totalReviews"]} reviews for this product",
                    style: const TextStyle(fontSize: 16)),
                SondyaStarRating(
                    averageRating:
                        (data["data"]["averageRating"] as int).toDouble()),
              ],
            );
          },
          loading: () => sondyaThreeBounceLoader(),
          error: (error, stackTrace) => Text(error.toString()),
        ),
        const SizedBox(
          height: 10,
        ),
        TextFormField(
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
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
              const TextField(
                maxLines: 6, // Allows unlimited lines
                keyboardType: TextInputType.multiline, // Adjust keyboard type
                decoration: InputDecoration(
                  hintText: "Enter your text here...",
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 45,
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Row(
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
            return SizedBox(
              height: data["data"].length <= 0
                  ? 50.00
                  : data["data"].length * 100.00,
              width: double.infinity,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: data["data"].length > 0 ? data["data"].length : 1,
                itemBuilder: (context, index) {
                  if (data["data"].isNotEmpty || data["data"].length > 0) {
                    return ReviewSectionTile(
                      imageString: data["data"][index]["user_id"]["image"][0]
                          ["url"],
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
                  const Text("No country"),
                  SondyaStarRating(averageRating: rating.toDouble()),
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
