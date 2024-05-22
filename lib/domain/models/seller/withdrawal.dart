import 'package:sondya_app/domain/models/checkout.dart';

class WithdrawalRequestModel {
  double? withdrawalAmount;
  Owner? user;
  String? currency;
  String? withdrawalMode;
  Map<String, dynamic>? withdrawalAccount;

  WithdrawalRequestModel({
    this.withdrawalAmount,
    this.user,
    this.currency,
    this.withdrawalMode,
    this.withdrawalAccount,
  });

  factory WithdrawalRequestModel.fromJson(Map<String, dynamic> json) =>
      WithdrawalRequestModel(
        withdrawalAmount: json['withdrawal_amount'] as double,
        user: Owner.fromJson(json['user']),
        currency: json['currency'] as String,
        withdrawalMode: json['withdrawal_mode'] as String,
        withdrawalAccount: json['withdrawal_account']?.cast<String, dynamic>(),
      );

  Map<String, dynamic> toJson() => {
        'withdrawal_amount': withdrawalAmount,
        'user': user?.toJson(),
        'currency': currency,
        'withdrawal_mode': withdrawalMode,
        'withdrawal_account': withdrawalAccount,
      };
}
