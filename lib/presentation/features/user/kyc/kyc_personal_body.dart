import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sondya_app/data/remote/profile.dart';
import 'package:sondya_app/domain/models/user/kyc.dart';
import 'package:sondya_app/domain/providers/kyc.provider.dart';
import 'package:sondya_app/presentation/widgets/select_widget.dart';
import 'package:sondya_app/presentation/widgets/success_error_message.dart';
import 'package:sondya_app/presentation/widgets/threebounce_loader.dart';
import 'package:sondya_app/utils/input_validations.dart';

class KycPersonalInformationBody extends ConsumerStatefulWidget {
  const KycPersonalInformationBody({super.key});

  @override
  ConsumerState<KycPersonalInformationBody> createState() =>
      _KycPersonalInformationBodyState();
}

class _KycPersonalInformationBodyState
    extends ConsumerState<KycPersonalInformationBody> {
  final _formKey = GlobalKey<FormState>();
  var _selectedGenderType = "Gender";
  var _selectedMaritalStatusType = "Marital Status";
  DateTime? _selectedDate;

  // for initial values
  var _initialGender = "";
  var _initialMaritalStatus = "";
  DateTime? _initialDateOfBirth;

  late KycPersonalDetailsModel user;

  @override
  void initState() {
    super.initState();
    // Initialize the variable in initState
    user = KycPersonalDetailsModel();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
      });
      user.dateOfBirth =
          "${_selectedDate!.year}-${_selectedDate!.month.toString().padLeft(2, '0')}-${_selectedDate!.day.toString().padLeft(2, '0')}";
    }
  }

  @override
  Widget build(BuildContext context) {
    final AsyncValue<Map<String, dynamic>> checkState =
        ref.watch(kycPersonalInformationProvider);

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
              if (data['gender'].isNotEmpty &&
                  _selectedGenderType == "Gender") {
                _initialGender = data['gender'];
                user.gender = _initialGender;
              }
              if (data['marital_status'].isNotEmpty &&
                  _selectedMaritalStatusType == "Marital Status") {
                _initialMaritalStatus = data['marital_status'];
                user.maritalStatus = _initialMaritalStatus;
              }
              if (data['date_of_birth'] != null &&
                  data['date_of_birth'].isNotEmpty &&
                  _selectedDate == null) {
                _initialDateOfBirth = DateTime.parse(data['date_of_birth']);
                user.dateOfBirth = data['date_of_birth'];
              }
              return Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    checkState.when(
                      data: (data) {
                        if (data.isNotEmpty) {
                          // Optionally, refresh the kycPersonalInformationProvider
                          // ignore: unused_result
                          ref.refresh(kycPersonalInformationProvider);

                          WidgetsBinding.instance.addPostFrameCallback(
                              (_) => context.push('/kyc/contact/info'));
                        }

                        return sondyaDisplaySuccessMessage(
                            context, data["message"]);
                      },
                      loading: () => const SizedBox(),
                      error: (error, stackTrace) {
                        // Optionally, refresh the kycPersonalInformationProvider
                        // ignore: unused_result
                        ref.refresh(kycPersonalInformationProvider);
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
                      "Personal Information",
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
                        hintText: " Enter First Name",
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
                        hintText: " Enter Last Name",
                        labelText: 'Last Name',
                      ),
                      initialValue: data['last_name'],
                      validator: isInputEmpty,
                      onSaved: (value) {
                        user.lastName = value!;
                      },
                    ),
                    const SizedBox(height: 20.0),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: OutlinedButton(
                        onPressed: () async {
                          List<String> sortByList = [
                            "Male",
                            "Female",
                            "Others",
                          ];
                          SondyaSelectWidget().showBottomSheet<String>(
                            options: sortByList,
                            context: context,
                            onItemSelected: (value) {
                              setState(() {
                                _selectedGenderType = value;
                                user.gender = value;
                              });
                            },
                          );
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              _initialGender.isNotEmpty &&
                                      _selectedGenderType == "Gender"
                                  ? _initialGender
                                  : _selectedGenderType,
                              style: const TextStyle(fontSize: 15),
                            ),
                            const Icon(Icons.arrow_drop_down),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: OutlinedButton(
                        onPressed: () async {
                          List<String> sortByList = [
                            "Single",
                            "Married",
                            "Divorced",
                          ];
                          SondyaSelectWidget().showBottomSheet<String>(
                            options: sortByList,
                            context: context,
                            onItemSelected: (value) {
                              setState(() {
                                _selectedMaritalStatusType = value;
                                user.maritalStatus = value;
                              });
                            },
                          );
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              _initialMaritalStatus.isNotEmpty &&
                                      _selectedMaritalStatusType ==
                                          "Marital Status"
                                  ? _initialMaritalStatus
                                  : _selectedMaritalStatusType,
                              style: const TextStyle(fontSize: 15),
                            ),
                            const Icon(Icons.arrow_drop_down),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: OutlinedButton(
                        onPressed: () {
                          _selectDate(context);
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              _initialDateOfBirth != null &&
                                      _selectedDate == null
                                  ? "${_initialDateOfBirth!.day.toString().padLeft(2, '0')}/${_initialDateOfBirth!.month.toString().padLeft(2, '0')}/${_initialDateOfBirth!.year}"
                                  : _initialDateOfBirth == null &&
                                          _selectedDate == null
                                      ? "DD/MM/YYYY"
                                      : "${_selectedDate!.day.toString().padLeft(2, '0')}/${_selectedDate!.month.toString().padLeft(2, '0')}/${_selectedDate!.year}",
                              style: const TextStyle(fontSize: 15),
                            ),
                            const Icon(Icons.calendar_today),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();

                            // debugPrint(user.toJson().toString());

                            // Invalidate the kycPersonalInformationProvider to clear existing data
                            ref.invalidate(kycPersonalInformationProvider);

                            // Update the profile
                            await ref
                                .read(kycPersonalInformationProvider.notifier)
                                .kycPersonalDetails(
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
