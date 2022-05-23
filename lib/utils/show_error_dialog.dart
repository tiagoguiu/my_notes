import 'package:flutter/material.dart';

Future<void> showErrorDialog(
    {required BuildContext context, required String text}) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Something went wrong'),
        content: Text(text),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Ok'),
          ),
        ],
      );
    },
  );
}
