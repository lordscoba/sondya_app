class UpdateSellerLocationType {
  String? country;
  String? state;
  String? city;
  String? zipCode;
  String? orderStatus;

  UpdateSellerLocationType(
      {this.country, this.state, this.city, this.zipCode, this.orderStatus});

  UpdateSellerLocationType.fromJson(Map<String, dynamic> json) {
    country = json['country'];
    state = json['state'];
    city = json['city'];
    zipCode = json['zip_code'];
    orderStatus = json['order_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['country'] = country;
    data['state'] = state;
    data['city'] = city;
    data['zip_code'] = zipCode;
    data['order_status'] = orderStatus;
    return data;
  }
}
