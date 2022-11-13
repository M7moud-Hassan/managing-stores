import 'package:flutter/material.dart';

import '../../../../../core/methods/app_util.dart';
import '../../../../../core/strings/bill_strings.dart';
import '../../../../../core/strings/home_str.dart';
import '../../../../data_market/presentation/widgets/pop_up_menu/item_menu.dart';
import '../../../../data_market/presentation/widgets/pop_up_menu/pop_up_menu_widget.dart';

AppBar appBarShowAllInvoice(BuildContext context) => AppBar(
      title: const Text(ALL_INVOICES),
      actions: [MyPopMenuAllVoices(context)],
    );

Widget MyPopMenuAllVoices(BuildContext context) => PopupMenuButton(
      itemBuilder: (context) => [
        itemMenu(ItemMenuParameter(
            iconData: Icons.request_page_rounded,
            data: INVOICE_OPEN,
            value: POP_ITEM1))
      ],
      onSelected: (value) {
        switch (value) {
          case POP_ITEM1:
            AppUtil.showSheetAddBillHolder(context);
        }
      },
    );
