class ProductOrderType {
  String id;
  List<List<String>>? selectedVariants;
  int orderQuantity;
  TrackDistanceTimeType? trackDistanceTime;

  ProductOrderType({
    required this.id,
    this.selectedVariants,
    required this.orderQuantity,
    this.trackDistanceTime,
  });

  factory ProductOrderType.fromJson(Map<String, dynamic> json) {
    return ProductOrderType(
      id: json['_id'],
      selectedVariants: (json['selected_variants'] as List<dynamic>?)
          ?.map((variant) => List<String>.from(variant))
          .toList(),
      orderQuantity: json['order_quantity'],
      trackDistanceTime: json['track_distance_time'] != null
          ? TrackDistanceTimeType.fromJson(json['track_distance_time'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'selected_variants': selectedVariants,
      'order_quantity': orderQuantity,
      'track_distance_time':
          trackDistanceTime != null ? trackDistanceTime!.toJson() : null,
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
