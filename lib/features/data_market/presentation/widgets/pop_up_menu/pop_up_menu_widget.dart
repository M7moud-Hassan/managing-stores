import 'package:awesome_dialog/awesome_dialog.dart';
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
      itemBuilder: (context) => [
        itemMenu(ItemMenuParameter(
            iconData: Icons.request_page_rounded,
            data: INVOICE_OPEN,
            value: POP_ITEM1))
      ],
      onSelected: (value) {
        switch (value) {
          case POP_ITEM1:
            showSheet(context);
        }
      },
    );
  }

  void showSheet(context) {
    BillAdd billAdd = BillAdd();
    AwesomeDialog(
            context: context,
            animType: AnimType.scale,
            dialogType: DialogType.noHeader,
            body: billAdd,
            autoDismiss: false,
            onDismissCallback: (type) {},
            btnOkOnPress: () {
              billAdd.openInvoice(context);
            },
            btnOkText: SAVE,
            btnCancelOnPress: () {
              Navigator.pop(context);
            },
            btnCancelText: CANCEL)
        .show()
        .whenComplete(() => null);
  }
}
