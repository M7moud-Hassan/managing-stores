import 'package:flutter/material.dart';
import 'package:mustafa/core/themes/my_colors.dart';

void showErrorSnackBar(
    {required String message, required BuildContext context, padding = 0}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.only(bottom: padding),
      content: Text(message),
      backgroundColor: ERROR_COLOR,
    ),
  );
}

void showPassSnackBar(
    {required String message, required BuildContext context, padding = 0}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      content: Text(message),
      margin: EdgeInsets.only(bottom: padding),
      backgroundColor: PASSS_COLOR,
    ),
  );
}
