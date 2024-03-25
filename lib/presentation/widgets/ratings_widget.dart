import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SondyaStarRating extends ConsumerWidget {
  final double averageRating;
  final Color starColor;
  const SondyaStarRating({
    super.key,
    this.averageRating = 4,
    this.starColor = const Color(0xFFEDB842),
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final int ratingWhole = averageRating.floor();
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (int i = 0; i < ratingWhole; i++)
          Icon(
            Icons.star,
            color: starColor,
          ),
        for (int i = ratingWhole; i < 5; i++)
          Icon(
            Icons.star_border_outlined,
            color: starColor,
          ),
      ],
    );
  }
}
