class CreateUserModel {
  String? firstName;
  String? lastName;
  String? username;
  String? email;
  String? password;
  String? country;

  CreateUserModel(
      {this.firstName,
      this.lastName,
      this.username,
      this.email,
      this.password,
      this.country});

  CreateUserModel.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    username = json['username'];
    email = json['email'];
    password = json['password'];
    country = json['country'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['username'] = username;
    data['email'] = email;
    data['password'] = password;
    data['country'] = country;
    return data;
  }
}
