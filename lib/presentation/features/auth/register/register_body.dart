import 'package:flutter/material.dart';
import 'package:sondya_app/presentation/widgets/circle_images.dart';
import 'package:sondya_app/presentation/widgets/select_widget.dart';
import 'package:sondya_app/utils/decode_json.dart';
import 'package:sondya_app/utils/url_launcher.dart';

class RegisterBody extends StatefulWidget {
  const RegisterBody({super.key});

  @override
  State<RegisterBody> createState() => _RegisterBodyState();
}

class _RegisterBodyState extends State<RegisterBody> {
  String _selectedCountry = "Select Country";
  bool _isChecked = false;
  bool _obscureText = true;
  // final Uri _urlTermsAndConditions = Uri.parse('https://www.sondya.com/terms');

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: SizedBox(
          height: 780,
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
                      options: countries.cast<String>(),
                      context: context,
                      onItemSelected: (value) {
                        setState(() {
                          _selectedCountry = value;
                        });
                      });
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(_selectedCountry),
                    const Icon(Icons.arrow_drop_down),
                  ],
                ),
              ),
              TextFormField(
                obscureText: _obscureText,
                decoration: InputDecoration(
                  hintText: " Enter your Password",
                  labelText: '6+ characters',
                  suffixIcon: IconButton(
                    icon: Icon(
                        _obscureText ? Icons.visibility : Icons.visibility_off),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  ),
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Checkbox(
                    value: _isChecked,
                    onChanged: (value) {
                      setState(() {
                        _isChecked = value!;
                      });
                    },
                  ),
                  TextButton(
                    onPressed: () async {
                      await sondyaUrlLauncher(
                          url: Uri.parse('https://www.sondya.com/terms'));
                    },
                    child: const Text(
                      "Agree to Our Terms and Conditions",
                    ),
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () {},
                child: const Text("Register"),
              ),
              TextButton(
                onPressed: () {},
                child: const Text("Already have account? Log in"),
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
