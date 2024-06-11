import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sondya_app/domain/models/home.dart';

final productSearchprovider = StateProvider<ProductSearchModel>((ref) {
  // Create the resource
  final model = ProductSearchModel();
  ref.onDispose(() {
    // return to original state
    model.page = null;
    model.search = null;
  });

  return model;
});

final serviceSearchprovider = StateProvider<ServiceSearchModel>((ref) {
  final model = ServiceSearchModel();

  ref.onDispose(() {
    // return to original state
    model.page = null;
    model.search = null;
  });

  return model;
});
