import 'package:hive/hive.dart';

part 'cart.g.dart';

@HiveType(typeId: 2)
class ProductOrderType {
  @HiveField(0)
  String id;

  @HiveField(1)
  Map<String, dynamic>? selectedVariants;

  @HiveField(2)
  int orderQuantity;

  @HiveField(3)
  TrackDistanceTimeType? trackDistanceTime;

  @HiveField(4)
  String? name;

  @HiveField(5)
  double? tax;

  @HiveField(6)
  double? shippingCost;

  @HiveField(7)
  double? discount;

  ProductOrderType({
    required this.id,
    this.selectedVariants,
    required this.orderQuantity,
    this.trackDistanceTime,
    this.name,
    this.tax,
    this.shippingCost,
    this.discount,
  });

  factory ProductOrderType.fromJson(Map<String, dynamic> json) {
    return ProductOrderType(
      id: json['_id'],
      selectedVariants: (json['selected_variants'] as Map<String, dynamic>?)
          ?.map((key, value) {
        if (value is List<dynamic>) {
          return MapEntry(
              key, List<String>.from(value.map((e) => e.toString())));
        } else if (value is String) {
          return MapEntry(key, [value]);
        }
        return MapEntry(key, null);
      }),
      orderQuantity: json['order_quantity'],
      trackDistanceTime: json['track_distance_time'] != null
          ? TrackDistanceTimeType.fromJson(json['track_distance_time'])
          : null,
      name: json['name'],
      tax: json['tax'],
      shippingCost: json['shipping_cost'],
      discount: json['discount'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'selected_variants': selectedVariants,
      'order_quantity': orderQuantity,
      'track_distance_time':
          trackDistanceTime != null ? trackDistanceTime!.toJson() : null,
      'name': name,
      'tax': tax,
      'shipping_cost': shippingCost,
      'discount': discount,
    };
  }
}

class TrackDistanceTimeType {
  String id;
  OriginCoordinates originCoordinates;
  DestinationCoordinates destinationCoordinates;
  double distance;
  String timeShipping;
  String timeFlight;
  String deliveryDateShipping;
  String deliveryDateFlight;

  TrackDistanceTimeType({
    required this.id,
    required this.originCoordinates,
    required this.destinationCoordinates,
    required this.distance,
    required this.timeShipping,
    required this.timeFlight,
    required this.deliveryDateShipping,
    required this.deliveryDateFlight,
  });

  factory TrackDistanceTimeType.fromJson(Map<String, dynamic> json) {
    return TrackDistanceTimeType(
      id: json['_id'],
      originCoordinates: OriginCoordinates.fromJson(json['originCoordinates']),
      destinationCoordinates:
          DestinationCoordinates.fromJson(json['destinationCoordinates']),
      distance: json['distance'],
      timeShipping: json['timeShipping'],
      timeFlight: json['timeFlight'],
      deliveryDateShipping: json['deliveryDateShipping'],
      deliveryDateFlight: json['deliveryDateFlight'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'originCoordinates': originCoordinates.toJson(),
      'destinationCoordinates': destinationCoordinates.toJson(),
      'distance': distance,
      'timeShipping': timeShipping,
      'timeFlight': timeFlight,
      'deliveryDateShipping': deliveryDateShipping,
      'deliveryDateFlight': deliveryDateFlight,
    };
  }
}

class OriginCoordinates {
  double lat;
  double lng;

  OriginCoordinates({
    required this.lat,
    required this.lng,
  });

  factory OriginCoordinates.fromJson(Map<String, dynamic> json) {
    return OriginCoordinates(
      lat: json['lat'],
      lng: json['lng'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'lat': lat,
      'lng': lng,
    };
  }
}

class DestinationCoordinates {
  double lat;
  double lng;

  DestinationCoordinates({
    required this.lat,
    required this.lng,
  });

  factory DestinationCoordinates.fromJson(Map<String, dynamic> json) {
    return DestinationCoordinates(
      lat: json['lat'],
      lng: json['lng'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'lat': lat,
      'lng': lng,
    };
  }
}
