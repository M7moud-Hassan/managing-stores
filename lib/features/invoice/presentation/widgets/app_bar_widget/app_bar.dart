import 'package:flutter/material.dart';
import 'package:mustafa/core/methods/app_util.dart';
import 'package:mustafa/core/strings/bill_strings.dart';
import 'package:mustafa/features/data_market/presentation/widgets/pop_up_menu/item_menu.dart';
import 'package:mustafa/features/invoice/domain/entities/bill_holder.dart';
import 'package:mustafa/features/invoice/presentation/bloc/invoice/invoice_bloc.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../../../core/methods/invoice.dart';
import '../../../domain/entities/bill.dart';

const ITEM_MENU = 1;
AppBar appBarBill(
        BuildContext context, BillHolder billHolder, List<Bill> bills) =>
    AppBar(
      automaticallyImplyLeading: false,
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: const Icon(Icons.arrow_back),
      ),
      title: Text(billHolder.name),
      actions: [myPopMenu(billHolder, bills, context)],
    );

Widget myPopMenu(
        BillHolder billHolder, List<Bill> bills, BuildContext context) =>
    PopupMenuButton(
      itemBuilder: (context) => [
        itemMenu(ItemMenuParameter(
            iconData: Icons.picture_as_pdf,
            data: EXTRACT_AS_PDF,
            value: ITEM_MENU)),
      ],
      onSelected: (value) async {
        InvoiceBloc.get(context).add(ExportInvoiceEvent(bills));
        // String path = await AppUtil.getFont();
        // Invoice invoice =
        //   Invoice(path: path, bills: bills, billHolder: billHolder);
        //invoice.generatePDF();
      },
    );
