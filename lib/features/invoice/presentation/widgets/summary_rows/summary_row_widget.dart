import 'package:flutter/material.dart';
import 'package:mustafa/core/themes/my_colors.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../../../core/strings/bill_strings.dart';
import '../../../../data_market/presentation/pages/data_grid_view.dart';

GridTableSummaryRow summatyRowWidget(
        String title,
        String name,
        String columnName,
        GridSummaryType gridSummaryType,
        GridTableSummaryRowPosition gridTableSummaryRowPosition) =>
    GridTableSummaryRow(
        color: COLOR_SUMMARY_ROW,
        showSummaryInRow: true,
        title: "$title :-  {$name}",
        columns: [
          GridSummaryColumn(
              name: name, columnName: columnName, summaryType: gridSummaryType)
        ],
        position: gridTableSummaryRowPosition);

Widget showSummary(String summaryValue, GridTableSummaryRow summaryRow,
        BuildContext context) =>
    Container(
      padding: const EdgeInsets.all(PADDING),
      child: Text(
        summaryValue,
        textAlign: summaryRow.title == "$TITLE_COUNT :-  {itemCount}"
            ? TextAlign.right
            : TextAlign.left,
        style: Theme.of(context).textTheme.titleLarge,
      ),
    );
