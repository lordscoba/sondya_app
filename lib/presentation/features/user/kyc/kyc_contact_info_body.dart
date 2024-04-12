import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sondya_app/utils/input_validations.dart';

class KycContactInfoBody extends ConsumerStatefulWidget {
  const KycContactInfoBody({super.key});

  @override
  ConsumerState<KycContactInfoBody> createState() => _KycContactInfoBodyState();
}

class _KycContactInfoBodyState extends ConsumerState<KycContactInfoBody> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    // Initialize the variable in initState
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
                  "Contact Information",
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
                    hintText: " Enter Residential Adrress",
                    labelText: 'Residential Address',
                  ),
                  validator: isInputEmpty,
                  onSaved: (value) {
                    // user.email = value!;
                  },
                ),
                const SizedBox(height: 20.0),
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: " Enter Phone Number",
                    labelText: 'Phone Number',
                  ),
                  validator: isInputEmpty,
                  onSaved: (value) {
                    // user.email = value!;
                  },
                ),
                const SizedBox(height: 20.0),
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: " Enter City",
                    labelText: 'City',
                  ),
                  validator: isInputEmpty,
                  onSaved: (value) {
                    // user.email = value!;
                  },
                ),
                const SizedBox(height: 20.0),
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: " Enter State",
                    labelText: 'State',
                  ),
                  validator: isInputEmpty,
                  onSaved: (value) {
                    // user.email = value!;
                  },
                ),
                const SizedBox(height: 20.0),
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: " Enter Country",
                    labelText: 'Country',
                  ),
                  validator: isInputEmpty,
                  onSaved: (value) {
                    // user.email = value!;
                  },
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
