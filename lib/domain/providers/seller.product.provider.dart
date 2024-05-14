import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sondya_app/domain/models/home.dart';

final sellerProductSearchprovider =
    StateProvider<ProductSearchModel>((ref) => ProductSearchModel());
