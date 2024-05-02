import 'dart:convert';

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

  String toJsonString() {
    return jsonEncode(toJson());
  }

  static PaymentRequestType fromJsonString(String jsonString) {
    Map<String, dynamic> json = jsonDecode(jsonString);
    return PaymentRequestType.fromJson(json);
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

  String toJsonString() {
    return jsonEncode(toJson());
  }

  static Owner fromJsonString(String jsonString) {
    Map<String, dynamic> json = jsonDecode(jsonString);
    return Owner.fromJson(json);
  }
}
