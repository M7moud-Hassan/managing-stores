import 'package:flutter/material.dart';
import 'package:mustafa/core/themes/app_theme.dart';
import 'package:mustafa/core/themes/my_colors.dart';

Widget headerSheet(String title, BuildContext context, Function onSave) =>
    Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      ),
      child: Row(
        children: [
          Expanded(
              child: Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white),
          )),
          //btn click to save catalogue get name catalogue
          saveCataloge(context, onSave),
        ],
      ),
    );

Widget saveCataloge(context, Function onPress) => IconButton(
    onPressed: () => onPress.call(),
    icon: const Icon(
      Icons.add,
      color: BTN_SAVE,
    ));
