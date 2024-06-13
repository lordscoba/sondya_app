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

class KycDocumentUploadBody extends ConsumerStatefulWidget {
  const KycDocumentUploadBody({super.key});

  @override
  ConsumerState<KycDocumentUploadBody> createState() =>
      _KycDocumentUploadBodyState();
}

class _KycDocumentUploadBodyState extends ConsumerState<KycDocumentUploadBody> {
  final _formKey = GlobalKey<FormState>();
  late KycDocumentFileType user;
  XFile? imageValue;

  @override
  void initState() {
    super.initState();

    // Initialize the variable in initState
    user = KycDocumentFileType();
  }

  @override
  Widget build(BuildContext context) {
    final AsyncValue<Map<String, dynamic>> checkState =
        ref.watch(kycDocumentUploadProvider);

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
              // print("hy");
              // print(data["id_document"]);
              return Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    checkState.when(
                      data: (data) {
                        if (data.isNotEmpty) {
                          // Optionally, refresh the kycDocumentUploadProvider
                          // ignore: unused_result
                          ref.refresh(kycDocumentUploadProvider);

                          WidgetsBinding.instance.addPostFrameCallback(
                              (_) => context.push('/kyc/profile/pics'));
                        }

                        return sondyaDisplaySuccessMessage(
                            context, data["message"]);
                      },
                      loading: () => const SizedBox(),
                      error: (error, stackTrace) {
                        // Optionally, refresh the kycDocumentUploadProvider
                        // ignore: unused_result
                        ref.refresh(kycDocumentUploadProvider);
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
                      "Identification Document",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20.0),
                    const Text(
                      "Upload the required document below",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                    ),
                    const SizedBox(height: 20.0),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Identification document should be",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                          SizedBox(height: 8.0),
                          Text("1. Clear"),
                          SizedBox(height: 4.0),
                          Text("2. Good quality"),
                          SizedBox(height: 4.0),
                          Text("3. have extension .jpg , .png or .jpeg"),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Identification document can be",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                          SizedBox(height: 8.0),
                          Text("1. International Passport"),
                          SizedBox(height: 4.0),
                          Text("2. National Identity card"),
                          SizedBox(height: 4.0),
                          Text("3. Driver’s License"),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    SondyaImageSelection(
                      savedNetworkImage: data["id_document"] != null &&
                              data["id_document"].isNotEmpty
                          ? data["id_document"][0]["url"]
                          : null,
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

                              // Invalidate the kycDocumentUploadProvider to clear existing data
                              ref.invalidate(kycDocumentUploadProvider);

                              // Update the profile
                              await ref
                                  .read(kycDocumentUploadProvider.notifier)
                                  .kycDocumentUpload(
                                    user,
                                  );

                              // refreshes the profile provider
                              refresh();
                            } else {
                              // Navigate to the next screen
                              // ignore: use_build_context_synchronously
                              context.push('/kyc/profile/pics');
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
          ),
        ),
      ),
    );
  }
}
