import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sondya_app/data/remote/profile.dart';
import 'package:sondya_app/domain/models/user/kyc.dart';
import 'package:sondya_app/domain/providers/kyc.provider.dart';
import 'package:sondya_app/presentation/widgets/image_selection.dart';
import 'package:sondya_app/presentation/widgets/success_error_message.dart';
import 'package:sondya_app/presentation/widgets/threebounce_loader.dart';

class KycProfilePicsBody extends ConsumerStatefulWidget {
  const KycProfilePicsBody({super.key});

  @override
  ConsumerState<KycProfilePicsBody> createState() => _KycProfilePicsBodyState();
}

class _KycProfilePicsBodyState extends ConsumerState<KycProfilePicsBody> {
  final _formKey = GlobalKey<FormState>();
  late KycDisplayPictureType user;
  XFile? imageValue;

  @override
  void initState() {
    super.initState();

    // Initialize the variable in initState
    user = KycDisplayPictureType();
  }

  @override
  Widget build(BuildContext context) {
    final AsyncValue<Map<String, dynamic>> checkState =
        ref.watch(kycProfilePicsProvider);

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
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: profileData.when(
              data: (data) {
                // debugPrint(data["id_document"][0]["url"]);
                return Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      checkState.when(
                        data: (data) {
                          if (data.isNotEmpty) {
                            WidgetsBinding.instance.addPostFrameCallback((_) =>
                                context.push('/kyc/company/information'));

                            // Optionally, refresh the kycProfilePicsProvider
                            // ignore: unused_result
                            ref.refresh(kycProfilePicsProvider);
                          }

                          return sondyaDisplaySuccessMessage(
                              context, data["message"]);
                        },
                        loading: () => const SizedBox(),
                        error: (error, stackTrace) {
                          // Optionally, refresh the kycProfilePicsProvider
                          // ignore: unused_result
                          ref.refresh(kycProfilePicsProvider);
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
                        "Profile Picture",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 20.0),
                      const Text(
                        "Upload a profile picture",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w400),
                      ),
                      const SizedBox(height: 20.0),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 8.0),
                            Text("1. The picture should show your face"),
                            SizedBox(height: 4.0),
                            Text("2. The picture should be of good quality"),
                            SizedBox(height: 4.0),
                            Text("3. The picture should be clear"),
                            SizedBox(height: 4.0),
                            Text("4. have extension .jpg , .png or .jpeg"),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      SondyaImageSelection(
                        savedNetworkImage: data["image"][0]["url"],
                        onSetImage: (value) async {
                          // Save the image
                          setState(() {
                            imageValue = value;
                            // imageValue = File(value.path);
                          });
                        },
                      ),
                      const SizedBox(height: 20.0),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();

                              if (imageValue != null) {
                                user.image = imageValue!;

                                // Invalidate the kycProfilePicsProvider to clear existing data
                                ref.invalidate(kycProfilePicsProvider);

                                // Update the profile
                                await ref
                                    .read(kycProfilePicsProvider.notifier)
                                    .kycProfilePics(
                                      user,
                                    );

                                // refreshes the profile provider
                                refresh();
                              } else {
                                // Navigate to the next screen
                                // ignore: use_build_context_synchronously
                                context.push('/kyc/company/information');
                              }
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
                return const Center(
                  child: CupertinoActivityIndicator(
                    radius: 50,
                  ),
                );
              },
            )),
      ),
    );
  }
}
