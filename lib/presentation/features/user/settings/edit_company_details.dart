import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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

  @override
  void initState() {
    super.initState();
    // Initialize the variable in initState
  }

  @override
  Widget build(BuildContext context) {
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 100.0),
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: " Enter your Company Name",
                      labelText: 'Company Name',
                    ),
                    validator: isInputEmpty,
                    onSaved: (value) {
                      // user.email = value!;
                    },
                  ),
                  const SizedBox(height: 20.0),
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: " Enter your Company Website",
                      labelText: 'Company Website',
                    ),
                    validator: isInputEmpty,
                    onSaved: (value) {
                      // user.email = value!;
                    },
                  ),
                  const SizedBox(height: 20.0),
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: " Enter your Company Email",
                      labelText: 'Company Email',
                    ),
                    validator: isInputEmpty,
                    onSaved: (value) {
                      // user.email = value!;
                    },
                  ),
                  const SizedBox(height: 20.0),
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: " Enter your Contact Person Name",
                      labelText: 'Company Person name',
                    ),
                    validator: isInputEmpty,
                    onSaved: (value) {
                      // user.email = value!;
                    },
                  ),
                  const SizedBox(height: 20.0),
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: " Enter your Contact Person Number",
                      labelText: 'Contact Person Number',
                    ),
                    validator: isInputEmpty,
                    onSaved: (value) {
                      // user.email = value!;
                    },
                  ),
                  const SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                      }
                    },
                    child: const Text("Save Changes"),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
