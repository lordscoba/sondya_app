import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sondya_app/data/remote/seller.product.dart';
import 'package:sondya_app/domain/models/home.dart';
import 'package:sondya_app/domain/models/product.dart';

final sellerProductSearchprovider =
    StateProvider<ProductSearchModel>((ref) => ProductSearchModel());

final sellerProductDataprovider =
    StateProvider<ProductDataModel>((ref) => ProductDataModel());

final sellerAddProductProvider = StateNotifierProvider.autoDispose<
    SellerAddProductNotifier, AsyncValue<Map<String, dynamic>>>((ref) {
  return SellerAddProductNotifier();
});

final sellerEditProductProvider = StateNotifierProvider.autoDispose<
    SellerEditProductNotifier, AsyncValue<Map<String, dynamic>>>((ref) {
  return SellerEditProductNotifier();
});
