import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sondya_app/presentation/widgets/select_widget.dart';
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

  @override
  void initState() {
    super.initState();
    // Initialize the variable in initState
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
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Container(
          // height: 1200,
          width: double.infinity,
          padding: const EdgeInsets.all(10.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
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
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20.0),
                const Text(
                  "Fill in the information below",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                ),
                const SizedBox(height: 30.0),
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: " Enter First Name",
                    labelText: 'First Name',
                  ),
                  validator: isInputEmpty,
                  onSaved: (value) {
                    // user.email = value!;
                  },
                ),
                const SizedBox(height: 20.0),
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: " Enter Last Name",
                    labelText: 'Last Name',
                  ),
                  validator: isInputEmpty,
                  onSaved: (value) {
                    // user.email = value!;
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
                            // user.email = value!;
                          });
                        },
                      );
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          _selectedGenderType,
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
                            // user.email = value!;
                          });
                        },
                      );
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          _selectedMaritalStatusType,
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
                          _selectedDate != null
                              ? '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}'
                              : "DD/MM/YYYY",
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
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                      }
                    },
                    child: const Text("Continue"),
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
          ),
        ),
      ),
    );
  }
}
