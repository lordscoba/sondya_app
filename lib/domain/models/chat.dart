import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';

class PostMessageType {
  String? messageText;
  String? receiverId;
  String? senderId;
  String? productId;
  String? serviceId;
  String? type;
  FilePickerResult? file;
  XFile? image;

  PostMessageType(
      {this.messageText,
      this.receiverId,
      this.senderId,
      this.productId,
      this.serviceId,
      this.type,
      this.file,
      this.image});

  PostMessageType.fromJson(Map<String, dynamic> json) {
    messageText = json['message_text'];
    receiverId = json['receiver_id'];
    senderId = json['sender_id'];
    productId = json['product_id'];
    serviceId = json['service_id'];
    type = json['type'];
    file = json['file'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message_text'] = messageText;
    data['receiver_id'] = receiverId;
    data['sender_id'] = senderId;
    data['product_id'] = productId;
    data['service_id'] = serviceId;
    data['type'] = type;
    data['file'] = file;
    data['image'] = image;
    return data;
  }
}
