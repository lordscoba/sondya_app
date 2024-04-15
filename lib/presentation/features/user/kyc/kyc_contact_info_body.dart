import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sondya_app/data/remote/profile.dart';
import 'package:sondya_app/domain/models/user/kyc.dart';
import 'package:sondya_app/domain/providers/kyc.provider.dart';
import 'package:sondya_app/presentation/widgets/success_error_message.dart';
import 'package:sondya_app/presentation/widgets/threebounce_loader.dart';
import 'package:sondya_app/utils/input_validations.dart';

class KycContactInfoBody extends ConsumerStatefulWidget {
  const KycContactInfoBody({super.key});

  @override
  ConsumerState<KycContactInfoBody> createState() => _KycContactInfoBodyState();
}

class _KycContactInfoBodyState extends ConsumerState<KycContactInfoBody> {
  final _formKey = GlobalKey<FormState>();
  late KycContactInfoModel user;

  @override
  void initState() {
    super.initState();
    // Initialize the variable in initState
    user = KycContactInfoModel();
  }

  @override
  Widget build(BuildContext context) {
    final AsyncValue<Map<String, dynamic>> checkState =
        ref.watch(kycUserProvider);

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
              return Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    checkState.when(
                      data: (data) {
                        if (data.isNotEmpty) {
                          ref.invalidate(kycUserProvider);

                          // WidgetsBinding.instance.addPostFrameCallback(
                          //     (_) => context.push('/settings'));
                        }
                        return sondyaDisplaySuccessMessage(
                            context, data["message"]);
                      },
                      loading: () => const SizedBox(),
                      error: (error, stackTrace) {
                        ref.invalidate(kycUserProvider);

                        // debugPrint(error.toString());
                        return sondyaDisplayErrorMessage(
                            error.toString(), context);
                      },
                    ),
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
                      "Contact Information",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20.0),
                    const Text(
                      "Fill in the information below",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                    ),
                    const SizedBox(height: 30.0),
                    TextFormField(
                      decoration: const InputDecoration(
                        hintText: " Enter Residential Adrress",
                        labelText: 'Residential Address',
                      ),
                      initialValue: data['address'],
                      validator: isInputEmpty,
                      onSaved: (value) {
                        user.address = value!;
                      },
                    ),
                    const SizedBox(height: 20.0),
                    TextFormField(
                      decoration: const InputDecoration(
                        hintText: " Enter Phone Number",
                        labelText: 'Phone Number',
                      ),
                      initialValue: data['phone_number'],
                      validator: isInputEmpty,
                      onSaved: (value) {
                        user.phoneNumber = value!;
                      },
                    ),
                    const SizedBox(height: 20.0),
                    TextFormField(
                      decoration: const InputDecoration(
                        hintText: " Enter City",
                        labelText: 'City',
                      ),
                      initialValue: data['city'],
                      validator: isInputEmpty,
                      onSaved: (value) {
                        user.city = value!;
                      },
                    ),
                    const SizedBox(height: 20.0),
                    TextFormField(
                      decoration: const InputDecoration(
                        hintText: " Enter State",
                        labelText: 'State',
                      ),
                      initialValue: data['state'],
                      validator: isInputEmpty,
                      onSaved: (value) {
                        user.state = value!;
                      },
                    ),
                    const SizedBox(height: 20.0),
                    TextFormField(
                      decoration: const InputDecoration(
                        hintText: " Enter Country",
                        labelText: 'Country',
                      ),
                      initialValue: data['country'],
                      validator: isInputEmpty,
                      onSaved: (value) {
                        user.country = value!;
                      },
                    ),
                    const SizedBox(height: 20.0),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            // debugPrint(user.toJson().toString());
                            // Update the profile
                            await ref
                                .read(kycUserProvider.notifier)
                                .kycContactInfo(
                                  user.toJson(),
                                );

                            // refreshes the profile provider
                            refresh();
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
            error: (error, stackTrace) {
              return Text(error.toString());
            },
            loading: () {
              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
