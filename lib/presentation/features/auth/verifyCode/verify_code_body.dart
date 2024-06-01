import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sondya_app/domain/models/auth/auth.dart';
import 'package:sondya_app/domain/providers/auth.provider.dart';
import 'package:sondya_app/presentation/widgets/circle_images.dart';
import 'package:sondya_app/presentation/widgets/success_error_message.dart';
import 'package:sondya_app/presentation/widgets/threebounce_loader.dart';

class VerificationCodeBody extends ConsumerStatefulWidget {
  final String email;
  const VerificationCodeBody({required this.email, super.key});

  @override
  ConsumerState<VerificationCodeBody> createState() =>
      _VerificationCodeBodyState();
}

class _VerificationCodeBodyState extends ConsumerState<VerificationCodeBody> {
  late VerifyEmailModel user;
  final _formKey = GlobalKey<FormState>();

  final InputDecoration _inputDecoration = const InputDecoration(
    counterText: '',
  );
  final List<TextEditingController> _controllers =
      List.generate(4, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(4, (_) => FocusNode());

  String get inputs =>
      _controllers[0].text +
      _controllers[1].text +
      _controllers[2].text +
      _controllers[3].text;

  @override
  void initState() {
    super.initState();

    user = VerifyEmailModel();

    // // Add a listener to the last focus node to handle the last input
    // _focusNodes.last.addListener(() {
    //   // if (_focusNodes.last.hasFocus && _controllers.last.text.isNotEmpty) {
    //   //   _focusNodes.last.unfocus(); // Unfocus the last input
    //   //   // Add any other action you want to perform when the last input is filled
    //   // }
    // });
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  void _handleFocusChange(int currentIndex, String value) {
    if (currentIndex < _focusNodes.length - 1 && value.isNotEmpty) {
      _focusNodes[currentIndex].unfocus();
      _focusNodes[currentIndex + 1].requestFocus();
      _controllers[currentIndex].text = value;
    } else if (currentIndex == _focusNodes.length - 1 && value.isNotEmpty) {
      _focusNodes[currentIndex].unfocus();
      _controllers[currentIndex].text = value;
    }
  }

  @override
  Widget build(BuildContext context) {
    final AsyncValue<Map<String, dynamic>> checkState =
        ref.watch(verifyEmailUserProvider);
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
                const CircleImage(),
                checkState.when(
                    data: (data) {
                      if (data.isNotEmpty) {
                        // ref.invalidate(authUserProvider);
                        WidgetsBinding.instance.addPostFrameCallback((_) =>
                            context.go('/resetPassword/${widget.email}'));
                      }
                      return sondyaDisplaySuccessMessage(
                          context, data["message"]);
                    },
                    loading: () => const SizedBox(),
                    error: (error, stackTrace) {
                      // ref.invalidate(authUserProvider);
                      return sondyaDisplayErrorMessage(
                          error.toString(), context);
                    }),
                const Text(
                  "Verification Code",
                  style: TextStyle(fontSize: 30),
                  textAlign: TextAlign.center,
                ),
                const Text(
                  "We will send you a confirmation code in your inbox. Copy and Paste to activate your account.",
                  textAlign: TextAlign.center,
                ),
                const Image(
                  image: AssetImage("assets/images/verification_image.png"),
                  height: 150,
                ),
                Text(inputs),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    for (int i = 0; i < _controllers.length; i++)
                      Row(
                        children: [
                          SizedBox(
                            width: 60,
                            height: 90,
                            child: TextFormField(
                              controller: _controllers[i],
                              focusNode: _focusNodes[i],
                              keyboardType: TextInputType.number,
                              maxLength: 1,
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontSize: 24),
                              decoration: _inputDecoration,
                              onChanged: (value) {
                                _handleFocusChange(i, value);
                              },
                            ),
                          ),
                          i < _controllers.length - 1
                              ? const SizedBox(width: 20)
                              : const SizedBox(),
                        ],
                      ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () async {
                    // context.push('/resetPassword');
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState?.save();

                      // adds the code
                      user.code = inputs;

                      await ref
                          .read(verifyEmailUserProvider.notifier)
                          .verifyEmail(user.toJson(), widget.email);
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
                      : const Text("Verify"),
                ),
                const Align(
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Didn`t receive OTP?",
                        style: TextStyle(fontSize: 18),
                      ),
                      Text(
                        "Resend",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ],
                  ),
                ),
                const AuthFooterImages(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
