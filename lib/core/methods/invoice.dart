///Package imports
import 'dart:io';

import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';
import 'package:mustafa/core/methods/save_file_mobile.dart';
import 'package:mustafa/features/invoice/domain/entities/bill.dart';
import 'package:mustafa/features/invoice/domain/entities/bill_holder.dart';

///Pdf import
///// ignore: depend_on_referenced_packages
import 'package:syncfusion_flutter_pdf/pdf.dart';

const int ADD_COUNT = 17;

class Invoice {
  final String path;
  final List<Bill> bills;
  final BillHolder billHolder;
  final PdfDocument document = PdfDocument();
  late String FullPath;
  Invoice({
    required this.path,
    required this.bills,
    required this.billHolder,
  });
  Future<void> generatePDF() async {
    //Create a PDF document.

    //Add page to the PDF
    final PdfPage page = document.pages.add();
    //Get page client size
    final Size pageSize = page.getClientSize();
    //Draw rectangle
    page.graphics.drawRectangle(
        bounds: Rect.fromLTWH(0, 0, pageSize.width, pageSize.height),
        pen: PdfPen(PdfColor(142, 170, 219)));
    //Generate PDF grid.
    final PdfGrid grid = _getGrid();
    grid.allowRowBreakingAcrossPages = true;
    //Draw the header section by creating text element
    final PdfLayoutResult result = await _drawHeader(page, pageSize, grid);

    //Draw grid
    _drawGrid(page, grid, result);
    //Add invoice footer

    _drawWater();

    //Save and dispose the document.

    final List<int> bytes = await document.save();
    document.dispose();
    //Launch file.
    // await File('$path/invoice.pdf').writeAsBytes(bytes);

    FullPath = "${billHolder.name}_${DateTime.now()}.pdf";
    FullPath = await FileSaveHelper.saveAndLaunchFile(bytes, FullPath);
  }

  String get getFullPath => FullPath;

  //Draws the invoice header
  Future<PdfLayoutResult> _drawHeader(
      PdfPage page, Size pageSize, PdfGrid grid) async {
    //Draw rectangle
    page.graphics.drawRectangle(
        brush: PdfSolidBrush(PdfColor(91, 126, 215)),
        bounds: Rect.fromLTWH(0, 0, pageSize.width - 115, 90));
    //Draw string
    page.graphics.drawString(
        'Eng: Mahmoud Hassan', PdfStandardFont(PdfFontFamily.helvetica, 30),
        brush: PdfBrushes.white,
        bounds: Rect.fromLTWH(25, 0, pageSize.width - 115, 90),
        format: PdfStringFormat(lineAlignment: PdfVerticalAlignment.middle));
    page.graphics.drawRectangle(
        bounds: Rect.fromLTWH(400, 0, pageSize.width - 400, 90),
        brush: PdfSolidBrush(PdfColor(65, 104, 205)));

    page.graphics.drawString(_getTotalAmount(grid).toString(),
        PdfStandardFont(PdfFontFamily.helvetica, 18, style: PdfFontStyle.bold),
        bounds: Rect.fromLTWH(400, 0, pageSize.width - 400, 100),
        brush: PdfBrushes.white,
        format: PdfStringFormat(
            alignment: PdfTextAlignment.center,
            lineAlignment: PdfVerticalAlignment.middle));

    final PdfFont contentFont =
        PdfTrueTypeFont(File(path).readAsBytesSync(), 14);
    //Draw string

    page.graphics.drawString('الإجمالي', contentFont,
        brush: PdfBrushes.white,
        bounds: Rect.fromLTWH(400, 0, pageSize.width - 400, 33),
        format: PdfStringFormat(
            textDirection: PdfTextDirection.rightToLeft,
            alignment: PdfTextAlignment.center,
            lineAlignment: PdfVerticalAlignment.bottom));
    //Create data foramt and convert it to text.
    final DateFormat format = DateFormat.yMMMMd('en_US');
    final String invoiceNumber =
        'رقم الفاتورة: 2058557939\r\n\r\nالتاريخ:${format.format(DateTime.now().toLocal())}';
    final Size contentSize = contentFont.measureString(invoiceNumber);
    String address =
        'فاتورة الي : \r\n\r\n${billHolder.name} \r\n\r\n${billHolder.address.replaceAll(
      "/",
      ",",
    )} \r\n\r\n${billHolder.phone}';

    PdfTextElement(
            text: invoiceNumber,
            font: contentFont,
            format: PdfStringFormat(
              textDirection: PdfTextDirection.rightToLeft,
            ))
        .draw(
            page: page,
            bounds: Rect.fromLTWH(
                30,
                120,
                pageSize.width - (contentSize.width + 30),
                pageSize.height - 120));
    return PdfTextElement(
            text: address,
            font: contentFont,
            format: PdfStringFormat(
                paragraphIndent: 50,
                textDirection: PdfTextDirection.rightToLeft,
                alignment: PdfTextAlignment.right))
        .draw(
            page: page,
            bounds: Rect.fromLTWH(pageSize.width - (contentSize.width + 30),
                120, contentSize.width + 30, pageSize.height - 120))!;
  }

  //Draws the grid
  void _drawGrid(PdfPage page, PdfGrid grid, PdfLayoutResult result) {
    Rect? totalPriceCellBounds;
    Rect? quantityCellBounds;
    //Invoke the beginCellLayout event.
    grid.beginCellLayout = (Object sender, PdfGridBeginCellLayoutArgs args) {
      final PdfGrid grid = sender as PdfGrid;
      if (args.cellIndex == grid.columns.count - 1) {
        totalPriceCellBounds = args.bounds;
      } else if (args.cellIndex == grid.columns.count - 2) {
        quantityCellBounds = args.bounds;
      }
    };
    //Draw the PDF grid and get the result.

    result = grid.draw(
        page: page, bounds: Rect.fromLTWH(0, result.bounds.bottom + 40, 0, 0))!;
    //Draw grand total.
    final PdfFont contentFont2 =
        PdfTrueTypeFont(File(path).readAsBytesSync(), 11);
    document.pages[document.pages.count - 1].graphics.drawString(
        'التكلفة الكلية: ', contentFont2,
        bounds: Rect.fromLTWH(
            quantityCellBounds!.left - 100,
            result.bounds.bottom + 10,
            quantityCellBounds!.width,
            quantityCellBounds!.height),
        format: PdfStringFormat(textDirection: PdfTextDirection.rightToLeft));

    document.pages[document.pages.count - 1].graphics.drawString(
      _getTotalAmount(grid).toString(),
      PdfStandardFont(PdfFontFamily.helvetica, 11, style: PdfFontStyle.bold),
      bounds: Rect.fromLTWH(20, result.bounds.bottom + 10,
          totalPriceCellBounds!.width, totalPriceCellBounds!.height),
    );
  }

  //Draw the invoice footer data.
  void _drawWater() {
    PdfPage page;
    for (int i = 0; i < document.pages.count; i++) {
      page = document.pages[i];
      page.graphics.setTransparency(0.25);
      page.graphics.rotateTransform(-40);
      page.graphics.drawString(
          'this app developed by .\r\n\r\nEng: Mahmoud Hassan Ahmed\r\n\r\nAny Questions? 01012139683',
          PdfStandardFont(PdfFontFamily.helvetica, 25),
          pen: PdfPens.red,
          brush: PdfBrushes.red,
          bounds: const Rect.fromLTWH(-250, 450, 0, 0));
    }
  }

  //Create PDF grid and return
  PdfGrid _getGrid() {
    //Create a PDF grid
    final PdfFont contentFont2 =
        PdfTrueTypeFont(File(path).readAsBytesSync(), 11);
    final PdfGrid grid = PdfGrid();
    grid.style = PdfGridStyle(font: contentFont2);

    //Secify the columns count to the grid.
    grid.columns.add(count: 5);
    //Create the header row of the grid.
    final PdfGridRow headerRow = grid.headers.add(1)[0];
    //Set style
    headerRow.style.backgroundBrush = PdfSolidBrush(PdfColor(68, 114, 196));
    headerRow.style.textBrush = PdfBrushes.white;
    headerRow.cells[4].value = 'م';
    headerRow.cells[4].stringFormat.alignment = PdfTextAlignment.center;
    headerRow.cells[3].value = 'اسم العنصر';
    headerRow.cells[3].stringFormat.textDirection =
        PdfTextDirection.rightToLeft;
    headerRow.cells[3].stringFormat.alignment = PdfTextAlignment.right;
    headerRow.cells[2].value = 'السعر';
    headerRow.cells[2].stringFormat.textDirection =
        PdfTextDirection.rightToLeft;
    headerRow.cells[2].stringFormat.alignment = PdfTextAlignment.right;
    headerRow.cells[1].value = 'الكمية';
    headerRow.cells[1].stringFormat.textDirection =
        PdfTextDirection.rightToLeft;
    headerRow.cells[1].stringFormat.alignment = PdfTextAlignment.right;
    headerRow.cells[0].value = 'الاجمالي';
    headerRow.cells[0].stringFormat.textDirection =
        PdfTextDirection.rightToLeft;
    headerRow.cells[0].stringFormat.alignment = PdfTextAlignment.right;
    int id = 0;
    for (Bill bill in bills) {
      _addProducts((++id).toString(), bill.item.name, bill.item.cost,
          bill.count, bill.totalCost, grid);
    }
    grid.applyBuiltInStyle(PdfGridBuiltInStyle.listTable4Accent5);
    grid.columns[3].width = 200;
    for (int i = 0; i < headerRow.cells.count; i++) {
      headerRow.cells[i].style.cellPadding =
          PdfPaddings(bottom: 5, left: 5, right: 5, top: 5);
    }
    for (int i = 0; i < grid.rows.count; i++) {
      final PdfGridRow row = grid.rows[i];
      for (int j = 0; j < row.cells.count; j++) {
        final PdfGridCell cell = row.cells[j];
        if (j == 0) {
          cell.stringFormat.alignment = PdfTextAlignment.center;
        }
        cell.style.cellPadding =
            PdfPaddings(bottom: 5, left: 5, right: 5, top: 5);
      }
    }
    return grid;
  }

  //Create and row for the grid.
  void _addProducts(String productId, String productName, double price,
      int quantity, double total, PdfGrid grid) {
    final PdfGridRow row = grid.rows.add();
    row.cells[4].value = productId;
    row.cells[4].stringFormat.alignment = PdfTextAlignment.center;
    row.cells[3].value = productName;
    row.cells[3].stringFormat.alignment = PdfTextAlignment.right;
    row.cells[3].stringFormat.textDirection = PdfTextDirection.rightToLeft;
    row.cells[2].value = price.toString();
    row.cells[2].stringFormat.alignment = PdfTextAlignment.right;
    row.cells[1].value = quantity.toString();
    row.cells[1].stringFormat.alignment = PdfTextAlignment.right;
    row.cells[0].value = total.toString();
    row.cells[0].stringFormat.alignment = PdfTextAlignment.center;
  }

  //Get the total amount.
  double _getTotalAmount(PdfGrid grid) {
    double total = 0;
    for (int i = 0; i < grid.rows.count; i++) {
      final String value = grid.rows[i].cells[0].value as String;
      total += double.parse(value);
    }
    return total;
  }
}
