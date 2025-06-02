import 'package:flutter/material.dart';

void openDialog({
  required BuildContext context,
  required String title,
  required Widget child,
  required List<Widget> action,
}) {
  showDialog(
    context: context,
    builder: (context) =>
        AlertDialog(title: Text(title), content: child, actions: action),
  );
}
