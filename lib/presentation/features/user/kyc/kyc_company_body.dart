import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sondya_app/data/remote/profile.dart';
import 'package:sondya_app/domain/models/user/profile.dart';
import 'package:sondya_app/domain/providers/kyc.provider.dart';
import 'package:sondya_app/presentation/widgets/success_error_message.dart';
import 'package:sondya_app/presentation/widgets/threebounce_loader.dart';
import 'package:sondya_app/utils/input_validations.dart';

class KycCompanyInformationBody extends ConsumerStatefulWidget {
  const KycCompanyInformationBody({super.key});

  @override
  ConsumerState<KycCompanyInformationBody> createState() =>
      _KycCompanyInformationBodyState();
}

class _KycCompanyInformationBodyState
    extends ConsumerState<KycCompanyInformationBody> {
  final _formKey = GlobalKey<FormState>();
  late CompanyDetailsUpdateModel user;

  Map<String, dynamic> companyDetails = {};

  @override
  void initState() {
    super.initState();
    // Initialize the variable in initState
    user = CompanyDetailsUpdateModel(companyDetails: {});
  }

  @override
  Widget build(BuildContext context) {
    final AsyncValue<Map<String, dynamic>> checkState =
        ref.watch(kycCompanyInfoProvider);

    final profileData = ref.watch(getProfileByIdProvider);
    // Optionally, use a button or gesture to trigger refresh
    Future<void> refresh() async {
      return await ref.refresh(getProfileByIdProvider);
    }

    return SingleChildScrollView(
      child: Center(
        child: Container(
            // height: 1200,
            width: double.infinity,
            padding: const EdgeInsets.all(10.0),
            child: profileData.when(
              data: (data) {
                // debugPrint(data['company_details'].toString());
                return Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      checkState.when(
                        data: (data) {
                          if (data.isNotEmpty) {
                            WidgetsBinding.instance.addPostFrameCallback(
                                (_) => context.push('/settings'));

                            // Optionally, refresh the kycCompanyInfoProvider
                            // ignore: unused_result
                            ref.refresh(kycCompanyInfoProvider);
                          }

                          return sondyaDisplaySuccessMessage(
                              context, data["message"]);
                        },
                        loading: () => const SizedBox(),
                        error: (error, stackTrace) {
                          // Optionally, refresh the kycCompanyInfoProvider
                          // ignore: unused_result
                          ref.refresh(kycCompanyInfoProvider);
                          return sondyaDisplayErrorMessage(
                              error.toString(), context);
                        },
                      ),
                      const SizedBox(height: 20.0),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(Icons.arrow_back),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20.0),
                      const Text(
                        "Company Information",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 20.0),
                      const Text(
                        "Fill in the information below",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w400),
                      ),
                      const SizedBox(height: 30.0),
                      TextFormField(
                        decoration: const InputDecoration(
                          hintText: " Enter Company Name",
                          labelText: 'Company Name',
                        ),
                        validator: isInputEmpty,
                        initialValue: data['company_details']['company_name'],
                        onSaved: (value) {
                          // user.email = value!;
                          companyDetails["company_name"] = value;
                        },
                      ),
                      const SizedBox(height: 20.0),
                      TextFormField(
                        decoration: const InputDecoration(
                          hintText: " Enter Company Website",
                          labelText: 'Company Website',
                        ),
                        validator: isInputEmpty,
                        initialValue: data['company_details']
                            ['company_website'],
                        onSaved: (value) {
                          // user.email = value!;
                          companyDetails["company_website"] = value;
                        },
                      ),
                      const SizedBox(height: 20.0),
                      TextFormField(
                        decoration: const InputDecoration(
                          hintText: " Enter Company Email",
                          labelText: 'Company Email',
                        ),
                        validator: isInputEmpty,
                        initialValue: data['company_details']['company_email'],
                        onSaved: (value) {
                          // user.email = value!;
                          companyDetails["company_email"] = value;
                        },
                      ),
                      const SizedBox(height: 20.0),
                      TextFormField(
                        decoration: const InputDecoration(
                          hintText: " Enter Contact Person Name",
                          labelText: 'Contact Person Name',
                        ),
                        initialValue: data['company_details']
                            ['contact_person_name'],
                        validator: isInputEmpty,
                        onSaved: (value) {
                          // user.email = value!;
                          companyDetails["contact_person_name"] = value;
                        },
                      ),
                      const SizedBox(height: 20.0),
                      TextFormField(
                        decoration: const InputDecoration(
                          hintText: " Enter Contact Person Number",
                          labelText: 'Contact Person Number',
                        ),
                        initialValue: data['company_details']
                            ['contact_person_number'],
                        validator: isInputEmpty,
                        onSaved: (value) {
                          // user.email = value!;
                          companyDetails["contact_person_number"] = value;
                        },
                      ),
                      const SizedBox(height: 20.0),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();

                              // Update the company details
                              user.companyDetails = companyDetails;

                              // Invalidate the kycCompanyInfoProvider to clear existing data
                              ref.invalidate(kycCompanyInfoProvider);

                              // Update the profile
                              await ref
                                  .read(kycCompanyInfoProvider.notifier)
                                  .kycCompanyDetails(
                                    user.toJson(),
                                  );

                              // refreshes the profile provider
                              refresh;
                            } else {
                              AnimatedSnackBar.rectangle(
                                'Error',
                                "Please fill all the fields",
                                type: AnimatedSnackBarType.warning,
                                brightness: Brightness.light,
                              ).show(
                                context,
                              );
                            }
                          },
                          child: checkState.isLoading
                              ? sondyaThreeBounceLoader(color: Colors.white)
                              : const Text("Continue"),
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      const Text(
                        "Fill the required information and click continue to proceed to the next section",
                        textAlign: TextAlign.center,
                      )
                    ],
                    // Your scrollable content here
                  ),
                );
              },
              loading: () => const CircularProgressIndicator(),
              error: (error, stackTrace) =>
                  Center(child: Text(error.toString())),
            )),
      ),
    );
  }
}
