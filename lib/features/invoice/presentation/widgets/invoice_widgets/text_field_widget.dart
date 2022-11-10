import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget textFieldBill(TextEditingController textEditingController) => TextField(
      controller: textEditingController,
      autofocus: true,
      keyboardType: TextInputType.number,
    );
