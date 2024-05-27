class CreateReviewType {
  String? userId;
  String? review;
  int? rating;
  String? productId;
  String? serviceId;

  CreateReviewType(
      {this.userId, this.review, this.rating, this.productId, this.serviceId});

  CreateReviewType.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    review = json['review'];
    rating = json['rating'];
    productId = json['product_id'];
    serviceId = json['service_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['review'] = review;
    data['rating'] = rating;
    data['product_id'] = productId;
    data['service_id'] = serviceId;
    return data;
  }
}
