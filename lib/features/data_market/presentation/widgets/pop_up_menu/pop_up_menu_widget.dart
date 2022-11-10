import 'package:flutter/material.dart';
import 'package:mustafa/core/strings/home_str.dart';
import 'package:mustafa/features/data_market/presentation/widgets/pop_up_menu/bill_holder_add_widget.dart';
import 'package:mustafa/features/data_market/presentation/widgets/pop_up_menu/item_menu.dart';

const POP_ITEM1 = 1;

class MyPopUpMenu extends StatelessWidget {
  const MyPopUpMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      itemBuilder: (context) =>
          [itemMenu(Icons.request_page_rounded, INVOICE_OPEN, POP_ITEM1)],
      onSelected: (value) {
        switch (value) {
          case POP_ITEM1:
            showSheet(context);
        }
      },
    );
  }

  void showSheet(context) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      ),
      builder: (context) {
        return BillAdd();
      },
    ).whenComplete(() {
      // textEditingController.text = ""; //clear text in field
    });
  }
}
