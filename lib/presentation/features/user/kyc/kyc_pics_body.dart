import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sondya_app/presentation/widgets/image_selection.dart';

class KycProfilePicsBody extends ConsumerStatefulWidget {
  const KycProfilePicsBody({super.key});

  @override
  ConsumerState<KycProfilePicsBody> createState() => _KycProfilePicsBodyState();
}

class _KycProfilePicsBodyState extends ConsumerState<KycProfilePicsBody> {
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
                  "Profile Picture",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20.0),
                const Text(
                  "Upload a profile picture",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
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
