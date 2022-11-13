import 'package:flutter/material.dart';

PopupMenuItem itemMenu(IconData icon, String data, int value) => PopupMenuItem(
    value: value,
    child: Row(
      children: [
        Icon(
          icon,
          color: Colors.black,
        ),
        Expanded(
            child: Text(
          data,
          textAlign: TextAlign.right,
        ))
      ],
    ));
