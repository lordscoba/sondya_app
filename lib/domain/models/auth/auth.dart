/// create user model
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

/// Login Model
class LoginModel {
  String? email;
  String? password;

  LoginModel({this.email, this.password});

  LoginModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['password'] = password;
    return data;
  }
}

/// forgot password model
class ForgotPasswordModel {
  String? email;

  ForgotPasswordModel({this.email});

  ForgotPasswordModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    return data;
  }
}

/// verify Email model
class VerifyEmailModel {
  String? code;

  VerifyEmailModel({this.code});

  VerifyEmailModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    return data;
  }
}

/// reset password model
class ResetPasswordModel {
  String? password;
  String? confirmPassword;

  ResetPasswordModel({this.password, this.confirmPassword});

  ResetPasswordModel.fromJson(Map<String, dynamic> json) {
    password = json['password'];
    confirmPassword = json['confirm_password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['password'] = password;
    data['confirm_password'] = confirmPassword;
    return data;
  }
}
