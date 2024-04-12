class ProfileUpdateModel {
  String? firstName;
  String? lastName;
  String? username;
  String? email;
  String? phoneNumber;
  String? state;
  String? city;
  String? address;
  String? currency;
  String? language;
  String? country;
  String? zipCode;
  String? websiteUrl;

  ProfileUpdateModel(
      {this.firstName,
      this.lastName,
      this.username,
      this.email,
      this.phoneNumber,
      this.state,
      this.city,
      this.address,
      this.currency,
      this.language,
      this.country,
      this.zipCode,
      this.websiteUrl});

  ProfileUpdateModel.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    username = json['username'];
    email = json['email'];
    phoneNumber = json['phone_number'];
    state = json['state'];
    city = json['city'];
    address = json['address'];
    currency = json['currency'];
    language = json['language'];
    country = json['country'];
    zipCode = json['zip_code'];
    websiteUrl = json['website_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['username'] = username;
    data['email'] = email;
    data['phone_number'] = phoneNumber;
    data['state'] = state;
    data['city'] = city;
    data['address'] = address;
    data['currency'] = currency;
    data['language'] = language;
    data['country'] = country;
    data['zip_code'] = zipCode;
    data['website_url'] = websiteUrl;
    return data;
  }
}

class SocialUpdateModel {
  String? facebookUrl;
  String? linkedinUrl;
  String? youtubeUrl;
  String? instagramUrl;
  String? twitterUrl;
  String? tiktokUrl;

  SocialUpdateModel(
      {this.facebookUrl,
      this.linkedinUrl,
      this.youtubeUrl,
      this.instagramUrl,
      this.twitterUrl,
      this.tiktokUrl});

  SocialUpdateModel.fromJson(Map<String, dynamic> json) {
    facebookUrl = json['facebook_url'];
    linkedinUrl = json['linkedin_url'];
    youtubeUrl = json['youtube_url'];
    instagramUrl = json['instagram_url'];
    twitterUrl = json['twitter_url'];
    tiktokUrl = json['tiktok_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['facebook_url'] = facebookUrl;
    data['linkedin_url'] = linkedinUrl;
    data['youtube_url'] = youtubeUrl;
    data['instagram_url'] = instagramUrl;
    data['twitter_url'] = twitterUrl;
    data['tiktok_url'] = tiktokUrl;
    return data;
  }
}

class ChangePasswordModel {
  String? currentPassword;
  String? newPassword;
  String? confirmPassword;

  ChangePasswordModel(
      {this.currentPassword, this.newPassword, this.confirmPassword});

  ChangePasswordModel.fromJson(Map<String, dynamic> json) {
    currentPassword = json['current_password'];
    newPassword = json['new_password'];
    confirmPassword = json['confirm_password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['current_password'] = currentPassword;
    data['new_password'] = newPassword;
    data['confirm_password'] = confirmPassword;
    return data;
  }
}
