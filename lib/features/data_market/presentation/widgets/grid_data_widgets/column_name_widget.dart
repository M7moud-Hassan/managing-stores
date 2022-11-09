import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../../../core/strings/home_str.dart';
import '../../../../../core/themes/my_colors.dart';
import '../../pages/data_grid_view.dart';

List<GridColumn> columnsName(context) => <GridColumn>[
      GridColumn(
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
          columnName: COLUMN3,
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
          columnName: COLUMN4,
          columnWidthMode: ColumnWidthMode.fitByColumnName,
          label: Container(
              color: COLOR_HEADER,
              padding: const EdgeInsets.all(PADDING),
              alignment: Alignment.center,
              child: Text(
                COUNT,
                style: Theme.of(context).textTheme.titleLarge,
              ))),
    ];
