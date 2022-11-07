import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:mustafa/core/strings/core_strings.dart';

AwesomeDialog alertDialog(context, title, textBody, btnOk, btnCancel) =>
    AwesomeDialog(
      context: context,
      animType: AnimType.scale,
      dialogType: DialogType.warning,
      body: Center(
        child: Text(
          textBody,
          style: const TextStyle(fontStyle: FontStyle.italic),
          textAlign: TextAlign.center,
        ),
      ),
      title: title,
      btnOkOnPress: btnOk,
      btnCancelOnPress: btnCancel,
      btnOkText: YES,
      btnCancelText: NO,
    );
