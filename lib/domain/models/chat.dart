class PostMessageType {
  String? messageText;
  String? receiverId;
  String? senderId;
  String? productId;
  String? serviceId;

  PostMessageType(
      {this.messageText,
      this.receiverId,
      this.senderId,
      this.productId,
      this.serviceId});

  PostMessageType.fromJson(Map<String, dynamic> json) {
    messageText = json['message_text'];
    receiverId = json['receiver_id'];
    senderId = json['sender_id'];
    productId = json['product_id'];
    serviceId = json['service_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message_text'] = messageText;
    data['receiver_id'] = receiverId;
    data['sender_id'] = senderId;
    data['product_id'] = productId;
    data['service_id'] = serviceId;
    return data;
  }
}
