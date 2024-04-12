import 'dart:io';

class KycEmailModel {
  String? email;

  KycEmailModel({this.email});

  KycEmailModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    return data;
  }
}

class KycCodeModel {
  String? code;

  KycCodeModel({this.code});

  KycCodeModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    return data;
  }
}

class KycPersonalDetailsModel {
  String? firstName;
  String? lastName;
  String? gender;
  String? maritalStatus;
  String? dateOfBirth;

  KycPersonalDetailsModel(
      {this.firstName,
      this.lastName,
      this.gender,
      this.maritalStatus,
      this.dateOfBirth});

  KycPersonalDetailsModel.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    gender = json['gender'];
    maritalStatus = json['marital_status'];
    dateOfBirth = json['date_of_birth'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['gender'] = gender;
    data['marital_status'] = maritalStatus;
    data['date_of_birth'] = dateOfBirth;
    return data;
  }
}

class KycContactInfoModel {
  String? address;
  String? phoneNumber;
  String? city;
  String? state;
  String? country;

  KycContactInfoModel(
      {this.address, this.phoneNumber, this.city, this.state, this.country});

  KycContactInfoModel.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    phoneNumber = json['phone_number'];
    city = json['city'];
    state = json['state'];
    country = json['country'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['address'] = address;
    data['phone_number'] = phoneNumber;
    data['city'] = city;
    data['state'] = state;
    data['country'] = country;
    return data;
  }
}

class KycDisplayPictureType {
  // String id;
  File? image;

  KycDisplayPictureType({
    // this.id,
    this.image,
  });

  factory KycDisplayPictureType.fromJson(Map<String, dynamic> json) {
    return KycDisplayPictureType(
        // id: json['id'],
        // Since you are not providing a key for the image in JSON, you might need to handle the file in a different way depending on your use case.
        // You might receive a file path instead of a File object.
        );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    // if (this.id != null) data['id'] = this.id;
    // You might not need to convert File to JSON.
    return data;
  }
}

class KycDocumentFileType {
  // String id;
  // List<ImageType>? image;
  File? image;

  KycDocumentFileType({
    // this.id,
    // this.image,
    this.image,
  });

  factory KycDocumentFileType.fromJson(Map<String, dynamic> json) {
    return KycDocumentFileType(
        // id: json['id'],
        // image: json['image'] != null ? List<ImageType>.from(json['image'].map((x) => ImageType.fromJson(x))) : null,
        // Since you are not providing a key for the image in JSON, you might need to handle the file in a different way depending on your use case.
        // You might receive a file path instead of a File object.
        );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    // if (this.id != null) data['id'] = this.id;
    // You might not need to convert File to JSON.
    return data;
  }
}
