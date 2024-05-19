import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sondya_app/data/remote/seller.service.dart';
import 'package:sondya_app/domain/models/home.dart';
import 'package:sondya_app/domain/models/service.dart';

final sellerServiceSearchprovider =
    StateProvider<ProductSearchModel>((ref) => ProductSearchModel());

final sellerServiceDataprovider =
    StateProvider<ServiceDataModel>((ref) => ServiceDataModel());

final sellerAddServiceProvider = StateNotifierProvider.autoDispose<
    SellerAddServiceNotifier, AsyncValue<Map<String, dynamic>>>((ref) {
  return SellerAddServiceNotifier();
});

final sellerEditServiceProvider = StateNotifierProvider.autoDispose<
    SellerEditServiceNotifier, AsyncValue<Map<String, dynamic>>>((ref) {
  return SellerEditServiceNotifier();
});
