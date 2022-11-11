import 'package:flutter/material.dart';

void showSheet(BuildContext context, Widget body) {
  showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20), topRight: Radius.circular(20)),
    ),
    builder: (context) {
      return body;
    },
  ).whenComplete(() {
    // textEditingController.text = ""; //clear text in field
  });
}
