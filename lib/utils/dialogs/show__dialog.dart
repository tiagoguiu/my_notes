import 'package:flutter/material.dart';
import 'package:vandad_flutter_course/utils/dialogs/dialogs.dart';

Future<bool> showLogOutDialog(BuildContext context) async {
  return showGenericDialog<bool>(
    context: context,
    title: 'Logout',
    content: 'Are you sure you want log out?',
    optionBuilder: () => {
      'Cancel': false,
      'Log Out' : true,
    },
  ).then((value) => value ?? false);
}
