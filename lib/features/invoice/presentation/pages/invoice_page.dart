import 'package:flutter/material.dart';
import 'package:mustafa/core/strings/bill_strings.dart';
import 'package:mustafa/features/data_market/domain/entities/item.dart';
import 'package:mustafa/features/data_market/presentation/pages/data_grid_view.dart';
import 'package:mustafa/features/invoice/domain/entities/bill.dart';
import 'package:mustafa/features/invoice/domain/entities/bill_holder.dart';
import 'package:mustafa/features/invoice/presentation/widgets/invoice_widgets/text_field_widget.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:collection/collection.dart';

import '../../../../core/themes/my_colors.dart';
import '../widgets/app_bar_widget/app_bar.dart';
import '../widgets/invoice_widgets/column_names.dart';
import '../widgets/summary_rows/summary_row_widget.dart';

const String NAME_COUNT = "itemCount";
const String NAME_TOTAL = "totalCost";

class InvoicePage extends StatefulWidget {
  const InvoicePage({super.key, required this.billHolder});
  final BillHolder billHolder;
  @override
  State<InvoicePage> createState() => _InvoicePageState();
}

class _InvoicePageState extends State<InvoicePage> {
  late BillSorces _billSorces;
  final DataGridController _dataGridController = DataGridController();
  @override
  void initState() {
    super.initState();
    _billSorces = BillSorces(context: context);
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: appBarBill(),
        body: SfDataGrid(
          tableSummaryRows: [
            summatyRowWidget(TITLE_COUNT, NAME_COUNT, COLUMN1,
                GridSummaryType.count, GridTableSummaryRowPosition.top),
            summatyRowWidget(TITLE_TOTAL_COST, NAME_TOTAL, COLUMN5,
                GridSummaryType.sum, GridTableSummaryRowPosition.bottom),
          ],
          source: _billSorces,
          allowEditing: true,
          selectionMode: SelectionMode.single,
          navigationMode: GridNavigationMode.cell,
          controller: _dataGridController,
          columns: columnsNameBill(context),
          allowSorting: true,
          allowFiltering: true,
          frozenColumnsCount: 1,
          allowSwiping: true,
          allowPullToRefresh: true,
        ),
      ),
    );
  }
}

const COLUMN1 = "id";
const COLUMN2 = "name";
const COLUMN3 = "count";
const COLUMN4 = "cost";
const COLUMN5 = "total";

class BillSorces extends DataGridSource {
  static int squ = 0;
  late List<Bill> _bills;
  dynamic newCellValue;
  TextEditingController editingController = TextEditingController();
  final BuildContext context;
  BillSorces({required this.context}) {
    _bills = [
      Bill.add(Item(id: "", name: "asd", count: 12, cost: 2.5), 12),
      Bill.add(Item(id: "", name: "asd", count: 12, cost: 2.5), 12),
      Bill.add(Item(id: "", name: "asd", count: 12, cost: 2.5), 12),
      Bill.add(Item(id: "", name: "asd", count: 12, cost: 2.5), 12),
      Bill.add(Item(id: "", name: "asd", count: 12, cost: 2.5), 12),
      Bill.add(Item(id: "", name: "asd", count: 12, cost: 2.5), 12),
      Bill.add(Item(id: "", name: "asd", count: 12, cost: 2.5), 12),
      Bill.add(Item(id: "", name: "asd", count: 12, cost: 2.5), 12),
      Bill.add(Item(id: "", name: "asd", count: 12, cost: 2.5), 12),
      Bill.add(Item(id: "", name: "asd", count: 12, cost: 2.5), 12),
      Bill.add(Item(id: "", name: "asd", count: 12, cost: 2.5), 12),
      Bill.add(Item(id: "", name: "asd", count: 12, cost: 2.5), 12),
      Bill.add(Item(id: "", name: "asd", count: 12, cost: 2.5), 12),
      Bill.add(Item(id: "", name: "asd", count: 12, cost: 2.5), 12),
      Bill.add(Item(id: "", name: "asd", count: 12, cost: 2.5), 12),
      Bill.add(Item(id: "", name: "asd", count: 12, cost: 2.5), 12),
      Bill.add(Item(id: "", name: "asd", count: 12, cost: 2.5), 12),
      Bill.add(Item(id: "", name: "asd", count: 12, cost: 2.5), 12),
      Bill.add(Item(id: "", name: "asd", count: 12, cost: 2.5), 12),
      Bill.add(Item(id: "", name: "asd", count: 12, cost: 2.5), 12),
      Bill.add(Item(id: "", name: "asd", count: 12, cost: 2.5), 12)
    ];
    buildDataGridRows();
  }

  void buildDataGridRows() {
    _dataGridRows = _bills
        .map<DataGridRow>((bill) => DataGridRow(cells: [
              DataGridCell<int>(columnName: COLUMN1, value: ++squ),
              DataGridCell<String>(columnName: COLUMN2, value: bill.item.name),
              DataGridCell<int>(columnName: COLUMN3, value: bill.count),
              DataGridCell<double>(columnName: COLUMN4, value: bill.item.cost),
              DataGridCell<double>(columnName: COLUMN5, value: bill.totalCost)
            ]))
        .toList();
  }

  @override
  Widget? buildEditWidget(DataGridRow dataGridRow,
      RowColumnIndex rowColumnIndex, GridColumn column, CellSubmit submitCell) {
    //  return super.buildEditWidget(dataGridRow, rowColumnIndex, column, submitCell);
    editingController.text = dataGridRow
        .getCells()[column.columnName == COLUMN3 ? 2 : 3]
        .value
        .toString();
    return textFieldBill(editingController);
  }

  @override
  bool canSubmitCell(DataGridRow dataGridRow, RowColumnIndex rowColumnIndex,
      GridColumn column) {
    if (editingController.text.isNotEmpty) {
      if (column.columnName == COLUMN3) {
        try {
          newCellValue = int.parse(editingController.text);
          return true;
        } catch (e) {
          return false;
        }
      } else {
        try {
          newCellValue = double.parse(editingController.text);
          return true;
        } catch (e) {
          return false;
        }
      }
    } else {
      return false;
    }
  }

  @override
  void onCellSubmit(DataGridRow dataGridRow, RowColumnIndex rowColumnIndex,
      GridColumn column) {
    final dynamic oldValue = dataGridRow
            .getCells()
            .firstWhereOrNull((DataGridCell dataGridCell) =>
                dataGridCell.columnName == column.columnName)
            ?.value ??
        '';

    final int dataRowIndex = _dataGridRows.indexOf(dataGridRow);

    if (newCellValue == null || oldValue == newCellValue) {
      return;
    }
    if (column.columnName == COLUMN3) {
      _dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
          DataGridCell<int>(columnName: COLUMN3, value: newCellValue);
      _bills[dataRowIndex].count = newCellValue as int;
    } else if (column.columnName == COLUMN4) {
      _dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
          DataGridCell<double>(columnName: COLUMN4, value: newCellValue);
      _bills[dataRowIndex].item.cost = newCellValue as double;
    }
    _dataGridRows[dataRowIndex].getCells()[4] = DataGridCell<double>(
        columnName: COLUMN4,
        value: _dataGridRows[dataRowIndex].getCells()[2].value.toDouble() *
            _dataGridRows[dataRowIndex].getCells()[3].value);
    _bills[dataRowIndex].totalCost =
        _bills[dataRowIndex].count * _bills[dataRowIndex].item.cost;
    buildDataGridRows();
    notifyDataSourceListeners();
  }

  @override
  Widget? buildTableSummaryCellWidget(
      GridTableSummaryRow summaryRow,
      GridSummaryColumn? summaryColumn,
      RowColumnIndex rowColumnIndex,
      String summaryValue) {
    return showSummary(summaryValue, summaryRow, context);
  }

  void updateDataGridSource() {
    notifyListeners();
  }

  List<DataGridRow> _dataGridRows = [];
  @override
  List<DataGridRow> get rows => _dataGridRows;
  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        color: row.getCells()[0].value % 2 == 0 ? COLOR_EVEN : COLOR_OLD,
        cells: row.getCells().map<Widget>((e) {
          return Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(8.0),
            child: Text(e.value.toString()),
          );
        }).toList());
  }
}
