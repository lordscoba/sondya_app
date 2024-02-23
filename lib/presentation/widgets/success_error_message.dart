import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';

sondyaDisplaySuccessMessage(BuildContext context, data) {
  if (data != null) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      AnimatedSnackBar.rectangle(
        'Success',
        data.toString(),
        type: AnimatedSnackBarType.success,
        brightness: Brightness.light,
      ).show(
        context,
      );
    });
    return const SizedBox();
  }
  return const SizedBox();
}

sondyaDisplayErrorMessage(String error, BuildContext context) {
  WidgetsBinding.instance.addPostFrameCallback((_) {
    AnimatedSnackBar.rectangle(
      'Error',
      error.toString(),
      type: AnimatedSnackBarType.warning,
      brightness: Brightness.light,
    ).show(
      context,
    );
  });
  return const SizedBox();
}
