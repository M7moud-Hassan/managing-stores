import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mustafa/core/themes/my_colors.dart';

Widget errorSnackBar(error) => SnackBar(
      content: Text(error),
      backgroundColor: ERROR_COLOR,
    );
