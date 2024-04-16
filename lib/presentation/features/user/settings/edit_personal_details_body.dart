import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sondya_app/data/remote/profile.dart';
import 'package:sondya_app/domain/models/user/profile.dart';
import 'package:sondya_app/domain/providers/profile.provider.dart';
import 'package:sondya_app/presentation/widgets/image_selection.dart';
import 'package:sondya_app/presentation/widgets/select_widget.dart';
import 'package:sondya_app/presentation/widgets/success_error_message.dart';
import 'package:sondya_app/presentation/widgets/threebounce_loader.dart';
import 'package:sondya_app/utils/decode_json.dart';
import 'package:sondya_app/utils/input_validations.dart';

class EditPersonalDetailsBody extends ConsumerStatefulWidget {
  const EditPersonalDetailsBody({super.key});

  @override
  ConsumerState<EditPersonalDetailsBody> createState() =>
      _EditPersonalDetailsBodyState();
}

class _EditPersonalDetailsBodyState
    extends ConsumerState<EditPersonalDetailsBody> {
  String _selectedCountry = "Select Country";
  final _formKey = GlobalKey<FormState>();
  late ProfileUpdateModel user;

  // for initial values
  var _initialCountry = "";
  XFile? imageValue;

  @override
  void initState() {
    super.initState();

    // Initialize the variable in initState
    user = ProfileUpdateModel();
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
        title: const Text("Personal Details"),
      ),
      extendBody: true,
      body: SingleChildScrollView(
          child: Center(
        child: Container(
          padding: const EdgeInsets.all(10.0),
          child: profileData.when(
            data: (data) {
              // debugPrint(data.toString());

              if (data['country'].isNotEmpty &&
                  _selectedCountry == "Select Country") {
                _initialCountry = data['country'];
                user.country = _initialCountry;
              }
              return Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
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
                    ProfilePicsSelector(
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
                    TextFormField(
                      decoration: const InputDecoration(
                        hintText: "Enter your First Name",
                        labelText: 'First Name',
                      ),
                      initialValue: data['first_name'],
                      validator: isInputEmpty,
                      onSaved: (value) {
                        user.firstName = value!;
                      },
                    ),
                    const SizedBox(height: 20.0),
                    TextFormField(
                      decoration: const InputDecoration(
                        hintText: "Enter your Last Name",
                        labelText: 'Last Name',
                      ),
                      initialValue: data['last_name'],
                      validator: isInputEmpty,
                      onSaved: (value) {
                        user.lastName = value!;
                      },
                    ),
                    const SizedBox(height: 20.0),
                    TextFormField(
                      decoration: const InputDecoration(
                        hintText: " Enter your Username",
                        labelText: 'Username',
                      ),
                      initialValue: data['username'],
                      validator: isInputEmpty,
                      onSaved: (value) {
                        user.username = value!;
                      },
                    ),
                    const SizedBox(height: 20.0),
                    TextFormField(
                      decoration: const InputDecoration(
                        hintText: " Enter your Email",
                        labelText: 'Email',
                      ),
                      initialValue: data['email'],
                      validator: isInputEmpty,
                      onSaved: (value) {
                        user.email = value!;
                      },
                    ),
                    const SizedBox(height: 20.0),
                    TextFormField(
                      decoration: const InputDecoration(
                        hintText: " Enter your Phone Number",
                        labelText: 'Phone Number',
                      ),
                      initialValue: data['phone_number'],
                      validator: isInputEmpty,
                      onSaved: (value) {
                        user.phoneNumber = value!;
                      },
                    ),
                    const SizedBox(height: 20.0),
                    OutlinedButton(
                      onPressed: () async {
                        String filePath = "assets/data/countries.json";
                        List<dynamic> countries =
                            await loadJsonAsset<dynamic>(filePath);
                        // ignore: use_build_context_synchronously
                        SondyaSelectWidget().showBottomSheet<String>(
                          options: countries.cast<String>(),
                          context: context,
                          onItemSelected: (value) {
                            setState(() {
                              _selectedCountry = value;
                              user.country = value.toString();
                            });
                          },
                        );
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Text(_selectedCountry),
                          Text(
                            _initialCountry.isNotEmpty &&
                                    _selectedCountry == "Select Country"
                                ? _initialCountry
                                : _selectedCountry,
                          ),
                          const Icon(Icons.arrow_drop_down),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    TextFormField(
                      decoration: const InputDecoration(
                        hintText: " Enter your State",
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
                        hintText: " Enter your City",
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
                        hintText: " Enter your Language",
                        labelText: 'Language',
                      ),
                      initialValue: data['language'],
                      validator: isInputEmpty,
                      onSaved: (value) {
                        user.language = value!;
                      },
                    ),
                    const SizedBox(height: 20.0),
                    TextFormField(
                      decoration: const InputDecoration(
                        hintText: " Enter your Address",
                        labelText: 'Address',
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
                        hintText: " Enter your Currency",
                        labelText: 'Currency',
                      ),
                      initialValue: data['currency'],
                      validator: isInputEmpty,
                      onSaved: (value) {
                        user.currency = value!;
                      },
                    ),
                    const SizedBox(height: 20.0),
                    TextFormField(
                      decoration: const InputDecoration(
                        hintText: " Enter your Zip Code",
                        labelText: 'Zip Code',
                      ),
                      initialValue: data['zip_code'],
                      validator: isInputEmpty,
                      onSaved: (value) {
                        user.zipCode = value!;
                      },
                    ),
                    const SizedBox(height: 20.0),
                    TextFormField(
                      decoration: const InputDecoration(
                        hintText: " Enter your Website URL",
                        labelText: 'Website URL',
                      ),
                      initialValue: data['website_url'],
                      validator: isInputEmpty,
                      onSaved: (value) {
                        user.websiteUrl = value!;
                      },
                    ),
                    const SizedBox(height: 20.0),
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();

                          if (imageValue != null) {
                            user.image = imageValue;

                            // Update the profile
                            await ref
                                .read(profileProvider.notifier)
                                .editPersonalDetails(
                                  user,
                                );
                          } else {
                            // Update the profile
                            await ref
                                .read(profileProvider.notifier)
                                .editPersonalDetails(
                                  user,
                                );
                          }

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
      )),
    );
  }
}
