import 'package:hive/hive.dart';

// storage keys
const cartBoxString = 'cartBox';
const authBoxString = 'authBox';
const wishlistBoxString = 'wishlistBox';
const shipmentBoxString = 'shipmentBox';
const isSellerString = 'isSeller';
const hasInitializedAppString = 'hasInitializedApp';

// boxes
late Box boxAuth;
late Box boxForCart;
late Box boxForWishList;
late Box boxForShipment;
late Box boxIsSeller;
late Box boxHasInitializedApp;
