import 'package:flutter/material.dart';
import 'package:mustafa/core/methods/app_util.dart';
import 'package:mustafa/core/strings/bill_strings.dart';
import 'package:mustafa/core/strings/home_str.dart';
import 'package:mustafa/features/data_market/presentation/widgets/pop_up_menu/item_menu.dart';
import 'package:mustafa/features/invoice/presentation/pages/show_invoices_page.dart';

const POP_ITEM1 = 1;
const POP_ITEM2 = 2;

class MyPopUpMenu extends StatelessWidget {
  const MyPopUpMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      itemBuilder: (context) => [
        itemMenu(ItemMenuParameter(
            iconData: Icons.request_page_rounded,
            data: INVOICE_OPEN,
            value: POP_ITEM1)),
        itemMenu(ItemMenuParameter(
            iconData: Icons.blinds_closed_sharp, data: ALL_INVOICES, value: 2))
      ],
      onSelected: (value) {
        switch (value) {
          case POP_ITEM1:
            AppUtil.showSheetAddBillHolder(context);
            break;
          case POP_ITEM2:
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ShowAllInvoicesPage(),
                ));
        }
      },
    );
  }
}
