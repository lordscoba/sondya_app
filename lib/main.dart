import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sondya_app/data/hive_boxes.dart';
import 'package:sondya_app/domain/hive_models/auth/auth.dart';
import 'package:sondya_app/domain/hive_models/cart/cart.dart';
import 'package:sondya_app/domain/hive_models/shipment_info/shipment.dart';
import 'package:sondya_app/domain/hive_models/wishlist/wishlist.dart';
import 'package:sondya_app/router/router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Set device orientation to portrait only
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  // Initialize hive
  await Hive.initFlutter();

  // Register adapters
  Hive.registerAdapter(AuthInfoAdapter());
  Hive.registerAdapter(ProductOrderTypeAdapter());
  Hive.registerAdapter(WishListTypeAdapter());
  Hive.registerAdapter(ShippingDestinationTypeAdapter());

  // Open local boxes
  boxAuth = await Hive.openBox<AuthInfo>(authBoxString);
  boxForCart = await Hive.openBox<ProductOrderType>(cartBoxString);
  boxForWishList = await Hive.openBox<WishListType>(wishlistBoxString);
  boxForShipment =
      await Hive.openBox<ShippingDestinationType>(shipmentBoxString);
  boxIsSeller = await Hive.openBox<bool>(isSellerString);
  boxHasInitializedApp = await Hive.openBox<bool>(hasInitializedAppString);

  runApp(
    const ProviderScope(
      child: MyRouter(),
    ),
  );
}


// I am leaving this here
// You are suprised this small code made this app right
// thank you for viewing
