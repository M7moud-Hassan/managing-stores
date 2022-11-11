import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mustafa/core/strings/bill_strings.dart';
import 'package:mustafa/features/invoice/domain/entities/bill_holder.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:syncfusion_flutter_datagrid_export/export.dart';
import 'package:path_provider/path_provider.dart';

AppBar appBarBill(BuildContext context, BillHolder billHolder,
        GlobalKey<SfDataGridState> sdKey) =>
    AppBar(
      automaticallyImplyLeading: false,
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: const Icon(Icons.arrow_back),
      ),
      title: Text(billHolder.name),
      actions: [myPopMenu(sdKey, billHolder)],
    );

Widget myPopMenu(GlobalKey<SfDataGridState> sdKey, BillHolder billHolder) =>
    PopupMenuButton<int>(
      itemBuilder: (context) => [
        PopupMenuItem(
            value: 1,
            child: Row(
              children: const [
                Expanded(child: Text(EXTRACT_AS_PDF)),
                Icon(
                  Icons.picture_as_pdf,
                  color: Colors.black,
                )
              ],
            ))
      ],
      onSelected: (value) async {
        PdfDocument document = PdfDocument();
        PdfPage pdfPage = document.pages.add();
        PdfGrid pdfGrid = sdKey.currentState!.exportToPdfGrid();
        pdfGrid.draw(
          page: pdfPage,
          bounds: Rect.fromLTWH(0, 0, 0, 0),
        );
        final List<int> bytes = document.saveSync();
        Directory appDocumentsDirectory =
            await getApplicationDocumentsDirectory(); // 1
        String appDocumentsPath = appDocumentsDirectory.path;
        File('$appDocumentsPath/${billHolder.name}.pdf').writeAsBytes(bytes);
      },
    );
