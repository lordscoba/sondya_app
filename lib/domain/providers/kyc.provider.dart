import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sondya_app/data/remote/kyc.dart';

final kycEmailProvider = StateNotifierProvider.autoDispose<KycEmailNotifier,
    AsyncValue<Map<String, dynamic>>>((ref) {
  return KycEmailNotifier();
});

final kycCodeProvider = StateNotifierProvider.autoDispose<KycCodeNotifier,
    AsyncValue<Map<String, dynamic>>>((ref) {
  return KycCodeNotifier();
});

final kycPersonalInformationProvider = StateNotifierProvider.autoDispose<
    KycPersonalInformationNotifier, AsyncValue<Map<String, dynamic>>>((ref) {
  return KycPersonalInformationNotifier();
});

final kycContactInformationProvider = StateNotifierProvider.autoDispose<
    KycContactInfoNotifier, AsyncValue<Map<String, dynamic>>>((ref) {
  return KycContactInfoNotifier();
});

final kycDocumentUploadProvider = StateNotifierProvider.autoDispose<
    KycDocumentUploadNotifier, AsyncValue<Map<String, dynamic>>>((ref) {
  return KycDocumentUploadNotifier();
});

final kycCompanyInfoProvider = StateNotifierProvider.autoDispose<
    KycCompanyInfoNotifier, AsyncValue<Map<String, dynamic>>>((ref) {
  return KycCompanyInfoNotifier();
});

final kycProfilePicsProvider = StateNotifierProvider.autoDispose<
    KycProfilePicsNotifier, AsyncValue<Map<String, dynamic>>>((ref) {
  return KycProfilePicsNotifier();
});
