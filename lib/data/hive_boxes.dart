import 'package:hive/hive.dart';

// storage keys
const cartBoxString = 'cartBox';
const authBoxString = 'authBox';
const wishlistBoxString = 'wishlistBox';
const shipmentBoxString = 'shipmentBox';

// boxes
late Box boxAuth;
late Box boxForCart;
late Box boxForWishList;
late Box boxForShipment;
