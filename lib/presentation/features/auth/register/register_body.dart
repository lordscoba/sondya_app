import 'package:flutter/material.dart';
import 'package:sondya_app/presentation/widgets/circle_images.dart';
import 'package:sondya_app/presentation/widgets/select_widget.dart';
import 'package:sondya_app/utils/decode_json.dart';

class RegisterBody extends StatelessWidget {
  const RegisterBody({super.key});

  @override
  Widget build(BuildContext context) {
    // List<String> countries = [];
    // // () async {
    //   String filePath = "assets/data/countries.json";
    //   countries = await loadJsonAsset(filePath);
    // // };

    return SingleChildScrollView(
      child: Center(
        child: SizedBox(
          height: 700,
          width: 380,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const CircleImage(),
              const Text(
                "Create an account",
                style: TextStyle(fontSize: 30),
                textAlign: TextAlign.center,
              ),
              const Text(
                "Fill your information below",
                textAlign: TextAlign.center,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: " Enter your First Name",
                  labelText: 'First Name',
                ),
              ),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: " Enter your Last Name",
                  labelText: 'Last Name',
                ),
              ),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: " Enter your email",
                  labelText: 'Email',
                ),
              ),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: " Enter your username",
                  labelText: 'Username',
                ),
              ),
              OutlinedButton(
                onPressed: () async {
                  String filePath = "assets/data/countries.json";
                  List<dynamic> countries =
                      await loadJsonAsset<dynamic>(filePath);

                  // ignore: use_build_context_synchronously
                  SondyaSelectWidget().showBottomSheet<String>(
                      options: countries.cast<String>(), context: context);
                },
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("Select Option"),
                    Icon(Icons.arrow_drop_down),
                  ],
                ),
              ),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: " Enter your Password",
                  labelText: '6+ characters',
                ),
              ),
              ElevatedButton(
                onPressed: () {},
                child: const Text("Register"),
              ),
              TextButton(
                onPressed: () {},
                child: const Text("Forgot Password?"),
              ),
              const AuthFooterImages(),
            ],
            // Your scrollable content here
          ),
        ),
      ),
    );
  }
}
