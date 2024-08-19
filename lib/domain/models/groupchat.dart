import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';

class GroupChatPostMessageType {
  String? message;
  String? groupId;
  String? senderId;
  String? type;
  FilePickerResult? file;
  XFile? image;

  GroupChatPostMessageType({
    this.message,
    this.groupId,
    this.senderId,
    this.type,
    this.file,
    this.image,
  });

  GroupChatPostMessageType.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    groupId = json['group_id'];
    senderId = json['sender_id'];
    type = json['type'];
    file = json['file'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['group_id'] = groupId;
    data['sender_id'] = senderId;
    data['type'] = type;
    data['file'] = file;
    data['image'] = image;
    return data;
  }
}
