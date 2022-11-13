import 'package:flutter/material.dart';
import 'package:mustafa/core/themes/my_colors.dart';
import 'package:mustafa/features/data_market/presentation/pages/data_grid_view.dart';

void showErrorSnackBar(
    {required String message,
    required BuildContext context,
    double padding = PADDING}) {
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
    {required String message,
    required BuildContext context,
    double padding = PADDING}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      content: Text(message),
      margin: EdgeInsets.only(bottom: padding),
      backgroundColor: PASSS_COLOR,
    ),
  );
}
