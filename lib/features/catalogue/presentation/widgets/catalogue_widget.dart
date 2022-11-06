import 'package:flutter/material.dart';
import 'package:mustafa/features/catalogue/presentation/widgets/sheet_bottom_add_cata.dart';

Widget catalogueItem(title, index) => ListTile(
      title: Text(title),
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: Colors.grey),
        child: Center(
          child: Text(index),
        ),
      ),
    );

Widget addCatalogue(context) => FloatingActionButton(
    onPressed: () {
      showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        ),
        builder: (context) {
          return sheetAdd(context);
        },
      ).whenComplete(() {
        //  controller.length=0;
      });
    },
    child: const Icon(Icons.add));
