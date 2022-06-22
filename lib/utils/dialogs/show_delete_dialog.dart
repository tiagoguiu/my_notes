import 'package:flutter/material.dart';
import 'package:vandad_flutter_course/utils/dialogs/dialogs.dart';

Future<bool> showDeleteDialog(BuildContext context) async {
  return showGenericDialog<bool>(
    context: context,
    title: 'Delete',
    content: 'Are you sure you want to delete this item?',
    optionBuilder: () => {
      'Cancel': false,
      'Yes' : true,
    },
  ).then((value) => value ?? false);
}
