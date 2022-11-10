import 'package:flutter/material.dart';
import 'package:mustafa/features/invoice/presentation/pages/invoice_page.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../../../core/strings/home_str.dart';
import '../../../../../core/themes/my_colors.dart';
import '../../../../data_market/presentation/widgets/grid_data_widgets/form_sheet.dart';

List<GridColumn> columnsNameBill(context) => <GridColumn>[
      GridColumn(
          allowEditing: false,
          columnName: COLUMN1,
          allowSorting: false,
          allowFiltering: false,
          columnWidthMode: ColumnWidthMode.fitByCellValue,
          label: Container(
              color: COLOR_HEADER,
              padding: const EdgeInsets.all(PADDING),
              alignment: Alignment.center,
              child: Text(
                ESQUENCES,
                style: Theme.of(context).textTheme.titleLarge,
              ))),
      GridColumn(
          allowEditing: false,
          columnName: COLUMN2,
          columnWidthMode: ColumnWidthMode.fitByColumnName,
          label: Container(
              color: COLOR_HEADER,
              padding: const EdgeInsets.all(PADDING),
              alignment: Alignment.center,
              child: Text(
                NAME_ITEM,
                style: Theme.of(context).textTheme.titleLarge,
              ))),
      GridColumn(
          allowEditing: true,
          columnName: COLUMN3,
          columnWidthMode: ColumnWidthMode.fitByColumnName,
          label: Container(
              color: COLOR_HEADER,
              padding: const EdgeInsets.all(PADDING),
              alignment: Alignment.center,
              child: Text(
                COUNT,
                style: Theme.of(context).textTheme.titleLarge,
              ))),
      GridColumn(
          allowEditing: true,
          columnName: COLUMN4,
          columnWidthMode: ColumnWidthMode.fitByColumnName,
          label: Container(
              color: COLOR_HEADER,
              padding: const EdgeInsets.all(PADDING),
              alignment: Alignment.center,
              child: Text(
                COST,
                style: Theme.of(context).textTheme.titleLarge,
              ))),
      GridColumn(
          allowEditing: false,
          columnName: COLUMN5,
          columnWidthMode: ColumnWidthMode.fitByColumnName,
          label: Container(
              color: COLOR_HEADER,
              padding: const EdgeInsets.all(PADDING),
              alignment: Alignment.center,
              child: Text(
                ALL_COST,
                style: Theme.of(context).textTheme.titleLarge,
              )))
    ];
