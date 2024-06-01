import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sondya_app/data/remote/profile.dart';
import 'package:sondya_app/domain/models/user/profile.dart';
import 'package:sondya_app/domain/providers/profile.provider.dart';
import 'package:sondya_app/presentation/widgets/success_error_message.dart';
import 'package:sondya_app/presentation/widgets/threebounce_loader.dart';
import 'package:sondya_app/utils/input_validations.dart';

class EditCompanyDetailsBody extends ConsumerStatefulWidget {
  const EditCompanyDetailsBody({super.key});

  @override
  ConsumerState<EditCompanyDetailsBody> createState() =>
      _EditCompanyDetailsBodyState();
}

class _EditCompanyDetailsBodyState
    extends ConsumerState<EditCompanyDetailsBody> {
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
        ref.watch(profileProvider);

    final profileData = ref.watch(getProfileByIdProvider);
    // Optionally, use a button or gesture to trigger refresh
    Future<void> refresh() async {
      return await ref.refresh(getProfileByIdProvider);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Company Details"),
      ),
      extendBody: true,
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(10.0),
            child: Form(
              key: _formKey,
              child: profileData.when(
                data: (data) {
                  // debugPrint(data['company_details'].toString());
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 100.0),
                      checkState.when(
                        data: (data) {
                          if (data.isNotEmpty) {
                            ref.invalidate(profileProvider);

                            // WidgetsBinding.instance.addPostFrameCallback(
                            //     (_) => context.push('/settings'));
                          }
                          return sondyaDisplaySuccessMessage(
                              context, data["message"]);
                        },
                        loading: () => const SizedBox(),
                        error: (error, stackTrace) {
                          ref.invalidate(profileProvider);

                          debugPrint(error.toString());
                          return sondyaDisplayErrorMessage(
                              error.toString(), context);
                        },
                      ),
                      const SizedBox(height: 20.0),
                      TextFormField(
                        decoration: const InputDecoration(
                          hintText: " Enter your Company Name",
                          labelText: 'Company Name',
                        ),
                        validator: isInputEmpty,
                        initialValue: data['company_details'] == null
                            ? ''
                            : data['company_details']['company_name'] ?? '',
                        onSaved: (value) {
                          // user.email = value!;
                          companyDetails["company_name"] = value;
                        },
                      ),
                      const SizedBox(height: 20.0),
                      TextFormField(
                        decoration: const InputDecoration(
                          hintText: " Enter your Company Website",
                          labelText: 'Company Website',
                        ),
                        initialValue: data['company_details'] == null
                            ? ''
                            : data['company_details']['company_website'] ?? '',
                        validator: isInputEmpty,
                        onSaved: (value) {
                          // user.email = value!;
                          companyDetails["company_website"] = value;
                        },
                      ),
                      const SizedBox(height: 20.0),
                      TextFormField(
                        decoration: const InputDecoration(
                          hintText: " Enter your Company Email",
                          labelText: 'Company Email',
                        ),
                        initialValue: data['company_details'] == null
                            ? ''
                            : data['company_details']['company_email'] ?? '',
                        validator: isInputEmpty,
                        onSaved: (value) {
                          // user.email = value!;
                          companyDetails["company_email"] = value;
                        },
                      ),
                      const SizedBox(height: 20.0),
                      TextFormField(
                        decoration: const InputDecoration(
                          hintText: " Enter your Contact Person Name",
                          labelText: 'Company Person name',
                        ),
                        initialValue: data['company_details'] == null
                            ? ''
                            : data['company_details']['contact_person_name'] ??
                                '',
                        validator: isInputEmpty,
                        onSaved: (value) {
                          // user.email = value!;
                          companyDetails["contact_person_name"] = value;
                        },
                      ),
                      const SizedBox(height: 20.0),
                      TextFormField(
                        decoration: const InputDecoration(
                          hintText: " Enter your Contact Person Number",
                          labelText: 'Contact Person Number',
                        ),
                        initialValue: data['company_details'] == null
                            ? ''
                            : data['company_details']
                                    ['contact_person_number'] ??
                                '',
                        validator: isInputEmpty,
                        onSaved: (value) {
                          // user.email = value!;
                          companyDetails["contact_person_number"] = value;
                        },
                      ),
                      const SizedBox(height: 20.0),
                      ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();

                            // Update the company details
                            user.companyDetails = companyDetails;

                            // Update the profile
                            await ref
                                .read(profileProvider.notifier)
                                .editCompanyDetails(
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
                            : const Text("Save Changes"),
                      )
                    ],
                  );
                },
                loading: () => const CircularProgressIndicator(),
                error: (error, stackTrace) =>
                    Center(child: Text(error.toString())),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
