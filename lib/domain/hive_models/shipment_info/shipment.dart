import 'package:hive/hive.dart';

part 'shipment.g.dart';

@HiveType(typeId: 4)
class ShippingDestinationType {
  @HiveField(0)
  String id;

  @HiveField(1)
  String country;

  @HiveField(2)
  String state;

  @HiveField(3)
  String city;

  @HiveField(4)
  String address;

  @HiveField(5)
  String zipcode;

  @HiveField(6)
  String phoneNumber;

  ShippingDestinationType({
    required this.id,
    required this.country,
    required this.state,
    required this.city,
    required this.address,
    required this.zipcode,
    required this.phoneNumber,
  });

  factory ShippingDestinationType.fromJson(Map<String, dynamic> json) {
    return ShippingDestinationType(
      id: json['_id'],
      country: json['country'],
      state: json['state'],
      city: json['city'],
      address: json['address'],
      zipcode: json['zipcode'],
      phoneNumber: json['phone_number'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'country': country,
      'state': state,
      'city': city,
      'address': address,
      'zipcode': zipcode,
      'phone_number': phoneNumber,
    };
  }
}
