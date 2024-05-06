import 'package:sondya_app/domain/hive_models/cart/cart.dart';
import 'package:sondya_app/domain/hive_models/shipment_info/shipment.dart';
import 'package:sondya_app/domain/models/home.dart';

class PaymentRequestType {
  Owner buyer;
  double amount;
  String currency;
  String redirectUrl;

  PaymentRequestType({
    required this.buyer,
    required this.amount,
    required this.currency,
    required this.redirectUrl,
  });

  factory PaymentRequestType.fromJson(Map<String, dynamic> json) {
    return PaymentRequestType(
      buyer: Owner.fromJson(json['buyer']),
      amount: json['amount'],
      currency: json['currency'],
      redirectUrl: json['redirect_url'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'buyer': buyer.toJson(),
      'amount': amount,
      'currency': currency,
      'redirect_url': redirectUrl,
    };
    return data;
  }
}

class Owner {
  String id;
  String username;
  String email;
  String? phoneNumber;

  Owner({
    required this.id,
    required this.username,
    required this.email,
    this.phoneNumber,
  });

  factory Owner.fromJson(Map<String, dynamic> json) {
    return Owner(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      phoneNumber: json['phone_number'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'id': id,
      'username': username,
      'email': email,
    };
    if (phoneNumber != null) {
      data['phone_number'] = phoneNumber;
    }
    return data;
  }
}

class CreateProductOrderType {
  Owner? buyer; // done
  List<CheckoutItems>? checkoutItems;
  String? paymentMethod; // card or wallet  // done
  String? paymentStatus; // successful // done
  String? currency; // USD  // done
  String? redirectUrl; // /products/checkout/success  // done
  double? totalAmount; // 0.0  // done
  ShippingDestinationType? shippingDestination; // done
  String? orderStatus; // order placed // done
  double? totalTax; // 0.0 // done
  double? totalShippingFee; //0.0 //done
  double? totalDiscount; // 0.0  // done
  String? paymentId;

  CreateProductOrderType(
      {this.buyer,
      this.checkoutItems,
      this.paymentMethod,
      this.paymentStatus,
      this.currency,
      this.redirectUrl,
      this.totalAmount,
      this.shippingDestination,
      this.orderStatus,
      this.totalTax,
      this.totalShippingFee,
      this.totalDiscount,
      this.paymentId});

  CreateProductOrderType.fromJson(Map<String, dynamic> json) {
    buyer = json['buyer'] != null ? Owner.fromJson(json['buyer']) : null;
    if (json['checkout_items'] != null) {
      checkoutItems = <CheckoutItems>[];
      json['checkout_items'].forEach((v) {
        checkoutItems!.add(CheckoutItems.fromJson(v));
      });
    }
    paymentMethod = json['payment_method'];
    paymentStatus = json['payment_status'];
    currency = json['currency'];
    redirectUrl = json['redirect_url'];
    totalAmount = json['total_amount'];
    shippingDestination = json['shipping_destination'] != null
        ? ShippingDestinationType.fromJson(json['shipping_destination'])
        : null;
    orderStatus = json['order_status'];
    totalTax = json['total_tax'];
    totalShippingFee = json['total_shipping_fee'];
    totalDiscount = json['total_discount'];
    paymentId = json['payment_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (buyer != null) {
      data['buyer'] = buyer!.toJson();
    }
    if (checkoutItems != null) {
      data['checkout_items'] = checkoutItems!.map((v) => v.toJson()).toList();
    }
    data['payment_method'] = paymentMethod;
    data['payment_status'] = paymentStatus;
    data['currency'] = currency;
    data['redirect_url'] = redirectUrl;
    data['total_amount'] = totalAmount;
    if (shippingDestination != null) {
      data['shipping_destination'] = shippingDestination!.toJson();
    }
    data['order_status'] = orderStatus;
    data['total_tax'] = totalTax;
    data['total_shipping_fee'] = totalShippingFee;
    data['total_discount'] = totalDiscount;
    data['payment_id'] = paymentId;
    return data;
  }
}

class CheckoutItems {
  Owner? owner;
  String? id;
  String? name;
  String? category;
  String? subCategory;
  String? description;
  int? totalStock;
  String? tag;
  String? brand;
  String? model;
  double? oldPrice;
  double? currentPrice;
  double? discountPercentage;
  double? vatPercentage;
  String? productStatus;
  double? rating;
  int? totalRating;
  int? totalVariants;
  // Variants? variants;
  dynamic variants;
  String? country;
  String? state;
  String? city;
  String? zipCode;
  String? address;
  List<ImageType>? image;

  // order variables
  String? createdAt;
  String? updatedAt;
  Map<String, dynamic>? selectedVariants;
  int? orderQuantity;
  double? subTotal;
  double? shippingFee;
  double? tax;
  double? discount;
  double? totalPrice;
  TrackDistanceTimeType? trackDistanceTime;

  CheckoutItems(
      {this.owner,
      this.id,
      this.name,
      this.category,
      this.subCategory,
      this.description,
      this.totalStock,
      this.tag,
      this.brand,
      this.model,
      this.oldPrice,
      this.currentPrice,
      this.discountPercentage,
      this.vatPercentage,
      this.productStatus,
      this.rating,
      this.totalRating,
      this.totalVariants,
      this.variants,
      this.country,
      this.state,
      this.city,
      this.zipCode,
      this.address,
      this.image,
      this.createdAt,
      this.updatedAt,
      this.selectedVariants,
      this.orderQuantity,
      this.subTotal,
      this.shippingFee,
      this.tax,
      this.discount,
      this.totalPrice,
      this.trackDistanceTime});

  CheckoutItems.fromJson(Map<String, dynamic> json) {
    owner = json['owner'] != null ? Owner.fromJson(json['owner']) : null;
    id = json['_id'];
    name = json['name'];
    category = json['category'];
    subCategory = json['sub_category'];
    description = json['description'];
    totalStock = json['total_stock'];
    tag = json['tag'];
    brand = json['brand'];
    model = json['model'];
    oldPrice = json['old_price'];
    currentPrice = json['current_price'];
    discountPercentage = json['discount_percentage'];
    vatPercentage = json['vat_percentage'];
    productStatus = json['product_status'];
    rating = json['rating'];
    totalRating = json['total_rating'];
    totalVariants = json['total_variants'];
    variants =
        json['variants'] != null ? Variants.fromJson(json['variants']) : null;
    selectedVariants =
        (json['selected_variants'] as Map<String, dynamic>?)?.map((key, value) {
      if (value is List<dynamic>) {
        return MapEntry(key, List<String>.from(value.map((e) => e.toString())));
      } else if (value is String) {
        return MapEntry(key, [value]);
      }
      return MapEntry(key, null);
    });
    country = json['country'];
    state = json['state'];
    city = json['city'];
    zipCode = json['zip_code'];
    address = json['address'];
    if (json['image'] != null) {
      image = (json['image'] as List)
          .map((e) => ImageType.fromJson(e as Map<String, dynamic>))
          .toList();
    }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    orderQuantity = json['order_quantity'];
    subTotal = json['sub_total'];
    shippingFee = json['shipping_fee'];
    tax = json['tax'];
    discount = json['discount'];
    totalPrice = json['total_price'];
    trackDistanceTime = json['track_distance_time'] != null
        ? TrackDistanceTimeType.fromJson(json['track_distance_time'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (owner != null) {
      data['owner'] = owner!.toJson();
    }
    data['_id'] = id;
    data['name'] = name;
    data['category'] = category;
    data['sub_category'] = subCategory;
    data['description'] = description;
    data['total_stock'] = totalStock;
    data['tag'] = tag;
    data['brand'] = brand;
    data['model'] = model;
    data['old_price'] = oldPrice;
    data['current_price'] = currentPrice;
    data['discount_percentage'] = discountPercentage;
    data['vat_percentage'] = vatPercentage;
    data['product_status'] = productStatus;
    data['rating'] = rating;
    data['total_rating'] = totalRating;
    data['total_variants'] = totalVariants;
    if (variants != null) {
      data['variants'] = variants!.toJson();
    }
    data['state'] = state;
    data['city'] = city;
    data['zip_code'] = zipCode;
    data['address'] = address;
    if (image != null) {
      data['image'] = image!.map((v) => v.toJson()).toList();
    }
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['selected_variants'] = selectedVariants;
    data['order_quantity'] = orderQuantity;
    data['sub_total'] = subTotal;
    data['shipping_fee'] = shippingFee;
    data['tax'] = tax;
    data['discount'] = discount;
    data['total_price'] = totalPrice;
    if (trackDistanceTime != null) {
      data['track_distance_time'] = trackDistanceTime!.toJson();
    }
    return data;
  }
}

class Variants {
  List<String>? color;
  List<String>? size;

  Variants({this.color, this.size});

  Variants.fromJson(Map<String, dynamic> json) {
    color = json['color'].cast<String>();
    size = json['size'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['color'] = color;
    data['size'] = size;
    return data;
  }
}
