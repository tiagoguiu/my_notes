import 'package:flutter/material.dart';
import 'package:vandad_flutter_course/utils/dialogs/dialogs.dart';

Future<void> cannotShareEmptyNoteDialog({required BuildContext context}) async {
  return showGenericDialog<void>(
    context: context,
    title: 'Sharing',
    content: 'You cannot share an empty note!',
    optionBuilder: () => {
      'Ok': null,
    },
  );
}
