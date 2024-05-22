import 'package:image_picker/image_picker.dart';
import 'package:sondya_app/domain/models/checkout.dart';

class ServiceDataModel {
  String? name;
  String? tags;
  String? category;
  String? subCategory;
  String? briefDescription;
  String? description;
  Owner? owner;
  String? currency;
  double? oldPrice;
  double? currentPrice;
  double? rating;
  int? totalRating;
  String? serviceStatus;
  String? duration;
  List<XFile>? image;
  String? deleteImageId;
  String? locationDescription;
  String? phoneNumber;
  String? phoneNumberBackup;
  String? email;
  String? websiteLink;
  String? country;
  String? state;
  String? city;
  String? mapLocationLink;

  ServiceDataModel(
      {this.name,
      this.tags,
      this.category,
      this.subCategory,
      this.briefDescription,
      this.description,
      this.owner,
      this.currency,
      this.oldPrice,
      this.currentPrice,
      this.rating,
      this.totalRating,
      this.serviceStatus,
      this.duration,
      this.image,
      this.deleteImageId = "[]",
      this.locationDescription,
      this.phoneNumber,
      this.phoneNumberBackup,
      this.email,
      this.websiteLink,
      this.country,
      this.state,
      this.city,
      this.mapLocationLink});

  ServiceDataModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    tags = json['tags'];
    category = json['category'];
    subCategory = json['sub_category'];
    briefDescription = json['brief_description'];
    description = json['description'];
    owner = json['owner'] != null ? Owner.fromJson(json['owner']) : null;
    currency = json['currency'];
    oldPrice = json['old_price'];
    currentPrice = json['current_price'];
    rating = json['rating'];
    totalRating = json['total_rating'];
    serviceStatus = json['service_status'];
    duration = json['duration'];
    if (json['image'] != null) {
      image = (json['image'] as List).map((x) => XFile(x)).toList();
    }
    deleteImageId = json['deleteImageId'];
    locationDescription = json['location_description'];
    phoneNumber = json['phone_number'];
    phoneNumberBackup = json['phone_number_backup'];
    email = json['email'];
    websiteLink = json['website_link'];
    country = json['country'];
    state = json['state'];
    city = json['city'];
    mapLocationLink = json['map_location_link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['tags'] = tags;
    data['category'] = category;
    data['sub_category'] = subCategory;
    data['brief_description'] = briefDescription;
    data['description'] = description;
    if (owner != null) {
      data['owner'] = owner!.toJson();
    }
    data['currency'] = currency;
    data['old_price'] = oldPrice;
    data['current_price'] = currentPrice;
    data['rating'] = rating;
    data['total_rating'] = totalRating;
    data['service_status'] = serviceStatus;
    data['duration'] = duration;
    if (image != null) {
      data['image'] = image!.map((v) => v).toList();
    }
    data['deleteImageId'] = deleteImageId;
    data['location_description'] = locationDescription;
    data['phone_number'] = phoneNumber;
    data['phone_number_backup'] = phoneNumberBackup;
    data['email'] = email;
    data['website_link'] = websiteLink;
    data['country'] = country;
    data['state'] = state;
    data['city'] = city;
    data['map_location_link'] = mapLocationLink;
    return data;
  }
}
