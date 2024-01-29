import 'package:flutter/material.dart';

class SondyaSelectWidget {
  void showBottomSheet<T>(
      {required BuildContext context, required List<T> options}) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return ListView.builder(
            itemCount: options.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(options[index].toString()),
              );
            });
      },
    );
  }
}
