import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sondya_app/domain/models/user/profile.dart';
import 'package:sondya_app/domain/providers/profile.provider.dart';
import 'package:sondya_app/presentation/widgets/success_error_message.dart';
import 'package:sondya_app/presentation/widgets/threebounce_loader.dart';
import 'package:sondya_app/utils/input_validations.dart';

class ChangePasswordBody extends ConsumerStatefulWidget {
  const ChangePasswordBody({super.key});

  @override
  ConsumerState<ChangePasswordBody> createState() => _ChangePasswordBodyState();
}

class _ChangePasswordBodyState extends ConsumerState<ChangePasswordBody> {
  final _formKey = GlobalKey<FormState>();
  late ChangePasswordModel user;

  @override
  void initState() {
    super.initState();
    user = ChangePasswordModel();
    // Initialize the variable in initState
  }

  @override
  Widget build(BuildContext context) {
    final AsyncValue<Map<String, dynamic>> checkState =
        ref.watch(profileProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Change Password"),
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
                checkState.when(
                  data: (data) {
                    if (data.isNotEmpty) {
                      ref.invalidate(profileProvider);
                      WidgetsBinding.instance.addPostFrameCallback(
                          (_) => context.push('/settings'));
                    }
                    return sondyaDisplaySuccessMessage(
                        context, data["message"]);
                  },
                  loading: () => const SizedBox(),
                  error: (error, stackTrace) {
                    // ref.invalidate(profileProvider);

                    debugPrint(error.toString());
                    return sondyaDisplayErrorMessage(error.toString(), context);
                  },
                ),
                const SizedBox(height: 20.0),
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: " Enter your current password",
                    labelText: 'Current Password',
                  ),
                  validator: isInputEmpty,
                  onSaved: (value) {
                    user.currentPassword = value!;
                  },
                ),
                const SizedBox(height: 20.0),
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: " Enter your New password",
                    labelText: 'New Password',
                  ),
                  validator: isInputEmpty,
                  onSaved: (value) {
                    user.newPassword = value!;
                  },
                ),
                const SizedBox(height: 20.0),
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: " Enter your Confirm password",
                    labelText: 'Confirm New Password',
                  ),
                  validator: isInputEmpty,
                  onSaved: (value) {
                    user.confirmPassword = value!;
                  },
                ),
                const SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();

                      await ref.read(profileProvider.notifier).changePassword(
                            user.toJson(),
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
                      : const Text("Save Changes"),
                )
              ],
            ),
          ),
        ),
      )),
    );
  }
}
