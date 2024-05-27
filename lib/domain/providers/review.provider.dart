import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sondya_app/data/remote/reviews.dart';

final createReviewProvider = StateNotifierProvider.autoDispose<
    CreateReviewNotifier, AsyncValue<Map<String, dynamic>>>((ref) {
  return CreateReviewNotifier();
});
