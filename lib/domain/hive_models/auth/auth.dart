import 'package:hive/hive.dart';

part 'auth.g.dart';

@HiveType(typeId: 1)
class AuthInfo {
  @HiveField(0)
  String type;

  @HiveField(1)
  String token;

  @HiveField(2)
  String emailVerified;

  @HiveField(3)
  String kycCompleted;

  @HiveField(4)
  String id;

  @HiveField(5)
  String email;

  @HiveField(6)
  String username;

  AuthInfo({
    required this.type,
    required this.token,
    required this.emailVerified,
    required this.kycCompleted,
    required this.id,
    required this.email,
    required this.username,
  });

  factory AuthInfo.fromJson(Map<String, dynamic> json) {
    return AuthInfo(
      type: json['type'],
      token: json['token'],
      emailVerified: json['email_verified'],
      kycCompleted: json['kyc_completed'],
      id: json['id'],
      email: json['email'],
      username: json['username'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'token': token,
      'email_verified': emailVerified,
      'kyc_completed': kycCompleted,
      'id': id,
      'email': email,
      'username': username,
    };
  }
}
