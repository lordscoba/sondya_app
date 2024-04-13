import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sondya_app/data/remote/profile.dart';
import 'package:sondya_app/domain/models/user/profile.dart';
import 'package:sondya_app/domain/providers/profile.provider.dart';
import 'package:sondya_app/presentation/widgets/success_error_message.dart';
import 'package:sondya_app/presentation/widgets/threebounce_loader.dart';
import 'package:sondya_app/utils/input_validations.dart';

class EditSocialsBody extends ConsumerStatefulWidget {
  const EditSocialsBody({super.key});

  @override
  ConsumerState<EditSocialsBody> createState() => _EditSocialsBodyState();
}

class _EditSocialsBodyState extends ConsumerState<EditSocialsBody> {
  final _formKey = GlobalKey<FormState>();
  late SocialUpdateModel user;

  @override
  void initState() {
    super.initState();
    // Initialize the variable in initState
    user = SocialUpdateModel();
  }

  @override
  Widget build(BuildContext context) {
    final AsyncValue<Map<String, dynamic>> checkState =
        ref.watch(profileProvider);

    final profileData = ref.watch(getProfileByIdProvider);
    // Optionally, use a button or gesture to trigger refresh
    final refresh = ref.refresh(getProfileByIdProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Socials"),
      ),
      extendBody: true,
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(10.0),
            child: Form(
              key: _formKey,
              child: profileData.when(data: (data) {
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
                        hintText: " Enter your Facebook URL",
                        labelText: 'Facebook URL',
                      ),
                      initialValue: data['facebook_url'],
                      validator: isInputEmpty,
                      onSaved: (value) {
                        user.facebookUrl = value!;
                      },
                    ),
                    const SizedBox(height: 20.0),
                    TextFormField(
                      decoration: const InputDecoration(
                        hintText: " Enter your Instagram URL",
                        labelText: 'Instagram URL',
                      ),
                      initialValue: data['instagram_url'],
                      validator: isInputEmpty,
                      onSaved: (value) {
                        user.instagramUrl = value!;
                      },
                    ),
                    const SizedBox(height: 20.0),
                    TextFormField(
                      decoration: const InputDecoration(
                        hintText: " Enter your Linkdln URL",
                        labelText: 'Linkdln URL',
                      ),
                      initialValue: data['linkedin_url'],
                      validator: isInputEmpty,
                      onSaved: (value) {
                        user.linkedinUrl = value!;
                      },
                    ),
                    const SizedBox(height: 20.0),
                    TextFormField(
                      decoration: const InputDecoration(
                        hintText: " Enter your TikTok URL",
                        labelText: 'TikTok URL',
                      ),
                      initialValue: data['tiktok_url'],
                      validator: isInputEmpty,
                      onSaved: (value) {
                        user.tiktokUrl = value!;
                      },
                    ),
                    const SizedBox(height: 20.0),
                    TextFormField(
                      decoration: const InputDecoration(
                        hintText: " Enter your Twitter URL",
                        labelText: 'Twitter URL',
                      ),
                      initialValue: data['twitter_url'],
                      validator: isInputEmpty,
                      onSaved: (value) {
                        user.twitterUrl = value!;
                      },
                    ),
                    const SizedBox(height: 20.0),
                    TextFormField(
                      decoration: const InputDecoration(
                        hintText: " Enter your Youtube URL",
                        labelText: 'Youtube URL',
                      ),
                      initialValue: data['youtube_url'],
                      validator: isInputEmpty,
                      onSaved: (value) {
                        user.youtubeUrl = value!;
                      },
                    ),
                    const SizedBox(height: 20.0),
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();

                          // Update the profile
                          await ref.read(profileProvider.notifier).editSocials(
                                user.toJson(),
                              );

                          // refreshes the profile provider
                          refresh;
                        }
                      },
                      child: checkState.isLoading
                          ? sondyaThreeBounceLoader(color: Colors.white)
                          : const Text("Save Changes"),
                    )
                  ],
                );
              }, error: (error, stackTrace) {
                return Text(error.toString());
              }, loading: () {
                return const CircularProgressIndicator();
              }),
            ),
          ),
        ),
      ),
    );
  }
}
