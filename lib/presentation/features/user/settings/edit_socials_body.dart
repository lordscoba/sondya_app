import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sondya_app/utils/input_validations.dart';

class EditSocialsBody extends ConsumerStatefulWidget {
  const EditSocialsBody({super.key});

  @override
  ConsumerState<EditSocialsBody> createState() => _EditSocialsBodyState();
}

class _EditSocialsBodyState extends ConsumerState<EditSocialsBody> {
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
        title: const Text("Socials"),
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
                      hintText: " Enter your Facebook URL",
                      labelText: 'Facebook URL',
                    ),
                    validator: isInputEmpty,
                    onSaved: (value) {
                      // user.email = value!;
                    },
                  ),
                  const SizedBox(height: 20.0),
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: " Enter your Instagram URL",
                      labelText: 'Instagram URL',
                    ),
                    validator: isInputEmpty,
                    onSaved: (value) {
                      // user.email = value!;
                    },
                  ),
                  const SizedBox(height: 20.0),
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: " Enter your Linkdln URL",
                      labelText: 'Linkdln URL',
                    ),
                    validator: isInputEmpty,
                    onSaved: (value) {
                      // user.email = value!;
                    },
                  ),
                  const SizedBox(height: 20.0),
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: " Enter your TikTok URL",
                      labelText: 'TikTok URL',
                    ),
                    validator: isInputEmpty,
                    onSaved: (value) {
                      // user.email = value!;
                    },
                  ),
                  const SizedBox(height: 20.0),
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: " Enter your Twitter URL",
                      labelText: 'Twitter URL',
                    ),
                    validator: isInputEmpty,
                    onSaved: (value) {
                      // user.email = value!;
                    },
                  ),
                  const SizedBox(height: 20.0),
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: " Enter your Youtube URL",
                      labelText: 'Youtube URL',
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
