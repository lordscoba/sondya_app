import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sondya_app/domain/models/auth/auth.dart';
import 'package:sondya_app/domain/providers/auth.provider.dart';
import 'package:sondya_app/presentation/widgets/circle_images.dart';
import 'package:sondya_app/presentation/widgets/select_widget.dart';
import 'package:sondya_app/presentation/widgets/success_error_message.dart';
import 'package:sondya_app/presentation/widgets/threebounce_loader.dart';
import 'package:sondya_app/utils/decode_json.dart';
import 'package:sondya_app/utils/input_validations.dart';
import 'package:sondya_app/utils/url_launcher.dart';

class RegisterBody extends ConsumerStatefulWidget {
  const RegisterBody({super.key});

  @override
  ConsumerState<RegisterBody> createState() => _RegisterBodyState();
}

class _RegisterBodyState extends ConsumerState<RegisterBody> {
  String _selectedCountry = "Select Country";
  bool _isChecked = false;
  bool _obscureText = true;
  late CreateUserModel user;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    user = CreateUserModel();
    // Initialize the variable in initState
  }

  @override
  Widget build(BuildContext context) {
    final AsyncValue<Map<String, dynamic>> checkState =
        ref.watch(createUserProvider);
    return SingleChildScrollView(
      child: Center(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                checkState.when(
                  data: (data) {
                    if (data.isNotEmpty) {
                      Future.delayed(const Duration(seconds: 3), () {
                        context.push('/login');
                      });
                    }
                    return sondyaDisplaySuccessMessage(
                        context, data["message"]);
                  },
                  loading: () => const SizedBox(),
                  error: (error, stackTrace) =>
                      sondyaDisplayErrorMessage(error.toString(), context),
                ),
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
                  validator: isInputEmpty,
                  onSaved: (value) {
                    user.firstName = value!;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: " Enter your Last Name",
                    labelText: 'Last Name',
                  ),
                  validator: isInputEmpty,
                  onSaved: (value) {
                    user.lastName = value!;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: " Enter your email",
                    labelText: 'Email',
                  ),
                  validator: isInputEmail,
                  onSaved: (value) {
                    user.email = value!;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: " Enter your username",
                    labelText: 'Username',
                  ),
                  validator: isInputEmpty,
                  onSaved: (value) {
                    user.username = value!;
                  },
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
                        user.country = value.toString();
                      },
                    );
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
                      icon: Icon(_obscureText
                          ? Icons.visibility
                          : Icons.visibility_off),
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                    ),
                  ),
                  validator: isInputEmpty,
                  onSaved: (value) {
                    user.password = value!;
                  },
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
                  onPressed: () async {
                    if (_formKey.currentState!.validate() && _isChecked) {
                      _formKey.currentState?.save();

                      await ref.read(createUserProvider.notifier).createUser(
                            user.toJson(),
                          );
                    } else if (!_isChecked) {
                      AnimatedSnackBar.rectangle(
                        'Error',
                        "Please agree to our terms and conditions",
                        type: AnimatedSnackBarType.warning,
                        brightness: Brightness.light,
                      ).show(
                        context,
                      );
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
                      : const Text("Register"),
                ),
                TextButton(
                  onPressed: () {
                    context.push('/login');
                  },
                  child: const Text("Already have account? Log in"),
                ),
                const AuthFooterImages(),
              ],
              // Your scrollable content here
            ),
          ),
        ),
      ),
    );
  }
}
