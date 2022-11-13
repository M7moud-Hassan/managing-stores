import 'package:flutter/material.dart';

PopupMenuItem itemMenu(ItemMenuParameter parameter) => PopupMenuItem(
    value: parameter.value,
    child: Row(
      children: [
        Icon(
          parameter.iconData,
          color: Colors.black,
        ),
        Expanded(
            child: Text(
          parameter.data,
          textAlign: TextAlign.right,
        ))
      ],
    ));

class ItemMenuParameter {
  final IconData iconData;
  final String data;
  final int value;

  ItemMenuParameter(
      {required this.iconData, required this.data, required this.value});
}
