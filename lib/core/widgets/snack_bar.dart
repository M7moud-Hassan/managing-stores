import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mustafa/core/themes/my_colors.dart';

void showErrorSnackBar(
    {required String message, required BuildContext context}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: ERROR_COLOR,
    ),
  );
}

void showPassSnackBar(
    {required String message, required BuildContext context}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: PASSS_COLOR,
    ),
  );
}
