import 'package:share_plus/share_plus.dart';
import 'package:sondya_app/domain/models/checkout.dart';

class ProductDataModel {
  String? name;
  String? category;
  String? subCategory;
  String? description;
  int? totalStock;
  String? tag;
  String? brand;
  String? model;
  Owner? owner;
  double? oldPrice;
  double? currentPrice;
  double? discountPercentage;
  double? vatPercentage;
  String? productStatus;
  int? totalVariants;
  List<XFile>? image;
  // dynamic variants;
  Map<String, List<dynamic>>? variants;
  String? address;
  String? city;
  String? country;
  String? state;
  String? zipCode;

  ProductDataModel(
      {this.name,
      this.category,
      this.subCategory,
      this.description,
      this.totalStock,
      this.tag,
      this.brand,
      this.model,
      this.owner,
      this.oldPrice,
      this.currentPrice,
      this.discountPercentage,
      this.vatPercentage,
      this.productStatus,
      this.totalVariants,
      this.image,
      this.variants,
      this.address,
      this.city,
      this.country,
      this.state,
      this.zipCode});

  ProductDataModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    category = json['category'];
    subCategory = json['sub_category'];
    description = json['description'];
    totalStock = json['total_stock'];
    tag = json['tag'];
    brand = json['brand'];
    model = json['model'];
    owner = json['owner'] != null ? Owner.fromJson(json['owner']) : null;
    oldPrice = json['old_price'];
    currentPrice = json['current_price'];
    discountPercentage = json['discount_percentage'];
    vatPercentage = json['vat_percentage'];
    productStatus = json['product_status'];
    totalVariants = json['total_variants'];
    if (json['image'] != null) {
      image = (json['image'] as List).map((x) => XFile(x)).toList();
    }
    variants = json['variants']?.cast<String, List<dynamic>>() ?? {};
    // variants =
    //     json['variants'] != null ? Variants.fromJson(json['variants']) : null;
    address = json['address'];
    city = json['city'];
    country = json['country'];
    state = json['state'];
    zipCode = json['zip_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['category'] = category;
    data['sub_category'] = subCategory;
    data['description'] = description;
    data['total_stock'] = totalStock;
    data['tag'] = tag;
    data['brand'] = brand;
    data['model'] = model;
    if (owner != null) {
      data['owner'] = owner!.toJson();
    }
    data['old_price'] = oldPrice;
    data['current_price'] = currentPrice;
    data['discount_percentage'] = discountPercentage;
    data['vat_percentage'] = vatPercentage;
    data['product_status'] = productStatus;
    data['total_variants'] = totalVariants;
    if (image != null) {
      data['image'] = image!.map((v) => v).toList();
    }
    // if (variants != null) {
    //   data['variants'] = variants!.toJson();
    // }
    //
    data['variants'] = variants;
    data['address'] = address;
    data['city'] = city;
    data['country'] = country;
    data['state'] = state;
    data['zip_code'] = zipCode;
    return data;
  }
}
