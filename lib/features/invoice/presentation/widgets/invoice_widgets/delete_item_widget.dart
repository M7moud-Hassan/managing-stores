import 'package:flutter/material.dart';

Widget deleteItemBill(icon, data, color, onPress) => FloatingActionButton(
      onPressed: null,
      child: ElevatedButton(
        onPressed: onPress,
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all<Color>(color),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Icon(icon), Text(data)],
        ),
      ),
    );
