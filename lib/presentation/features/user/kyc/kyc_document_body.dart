import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sondya_app/presentation/widgets/image_selection.dart';

class KycDocumentUploadBody extends ConsumerStatefulWidget {
  const KycDocumentUploadBody({super.key});

  @override
  ConsumerState<KycDocumentUploadBody> createState() =>
      _KycDocumentUploadBodyState();
}

class _KycDocumentUploadBodyState extends ConsumerState<KycDocumentUploadBody> {
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
                  "Identification Document",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20.0),
                const Text(
                  "Upload the required document below",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
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
                const SondyaImageSelection(),
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
