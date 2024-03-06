import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sondya_app/domain/models/home.dart';

final productSearchprovider =
    StateProvider<ProductSearchModel>((ref) => ProductSearchModel());

final serviceSearchprovider = StateProvider.autoDispose<String>((ref) => "");
