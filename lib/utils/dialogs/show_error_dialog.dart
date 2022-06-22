import 'package:flutter/material.dart';
import 'package:vandad_flutter_course/utils/dialogs/dialogs.dart';

Future<void> showErrorDialog({
  required BuildContext context,
  required String text,
}) async {
  return showGenericDialog(
    context: context,
    title: 'An error occurred',
    content: text,
    optionBuilder: () => {
      'Ok' : null,
    },
  );
}
