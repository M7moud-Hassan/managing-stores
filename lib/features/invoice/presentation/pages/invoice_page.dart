import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mustafa/core/strings/bill_strings.dart';
import 'package:mustafa/core/strings/home_str.dart';
import 'package:mustafa/core/strings/messages.dart';
import 'package:mustafa/core/widgets/dialogs.dart';
import 'package:mustafa/core/widgets/snack_bar.dart';
import 'package:mustafa/features/invoice/domain/entities/bill.dart';
import 'package:mustafa/features/invoice/domain/entities/bill_holder.dart';
import 'package:mustafa/features/invoice/presentation/bloc/invoice/invoice_bloc.dart';
import 'package:mustafa/features/invoice/presentation/widgets/add_to_invoice.dart/add_to_invoice_widget.dart';
import 'package:mustafa/features/invoice/presentation/widgets/invoice_widgets/load_export_widget.dart';
import 'package:mustafa/features/invoice/presentation/widgets/invoice_widgets/text_field_widget.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:collection/collection.dart';

import '../../../../core/methods/app_util.dart';
import '../../../../core/methods/invoice.dart';
import '../../../../core/themes/my_colors.dart';
import '../widgets/app_bar_widget/add_items_invoice.dart';
import '../widgets/app_bar_widget/app_bar.dart';
import '../widgets/invoice_widgets/column_names.dart';
import '../widgets/invoice_widgets/delete_item_widget.dart';
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
  final GlobalKey<ScaffoldState> _scafoldKey = GlobalKey();
  final GlobalKey<SfDataGridState> sdKey = GlobalKey<SfDataGridState>();
  @override
  void initState() {
    super.initState();
    _billSorces = BillSorces(context: context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<InvoiceBloc, InvoiceState>(
      listener: (context, state) async {
        if (state is ShowErrorMessageInvoiceSatae) {
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            showErrorSnackBar(
                message: state.message,
                context: context,
                padding: state.padding);
          });
        } else if (state is AddItemToBill) {
          if (_billSorces.contains(state.bill)) {
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              showErrorSnackBar(
                  message: '${state.bill.item.name} $ITEM_EXITS',
                  context: context,
                  padding: HEIGTH_PADDING);
            });
          } else {
            _billSorces.addBill(state.bill);
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              showPassSnackBar(
                  message: ADDED_BILL,
                  context: context,
                  padding: HEIGTH_PADDING);
            });
          }
        } else if (state is ExportInvoiceState) {
          String path = await AppUtil.getFont();
          Invoice invoice = Invoice(
              path: path,
              bills: state.billsDone,
              billHolder: widget.billHolder);
          await invoice.generatePDF();
          _billSorces.clear(state.billsDone);
          Navigator.pop(context);
          InvoiceBloc.get(context).emit(FinshExportInvoice());
        } else if (state is StartExportInvoiceState) {
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            loadExportWidget(context).show();
          });
        }
      },
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          key: _scafoldKey,
          appBar: appBarBill(context, widget.billHolder, _billSorces._bills),
          floatingActionButton: AddButnItemInvoice(
            scafoldKey: _scafoldKey,
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.startDocked,
          body: SfDataGrid(
            key: sdKey,
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
            endSwipeActionsBuilder: (context, dataGridRow, rowIndex) {
              return deleteItemBill(Icons.delete, DELETED_ITEM, Colors.red, () {
                alertDialog(context, DELETED_ITEM, CONFIRM_DELETE_ITEM, () {
                  _billSorces.deleteBill(
                      (dataGridRow.getCells()[0].value.toInt()) - 1);
                }, () {})
                    .show();
              });
            },
            startSwipeActionsBuilder: (context, dataGridRow, rowIndex) {
              return deleteItemBill(Icons.delete, DELETED_ITEM, Colors.red, () {
                alertDialog(context, DELETED_ITEM, CONFIRM_DELETE_ITEM, () {
                  _billSorces.deleteBill(
                      (dataGridRow.getCells()[0].value.toInt()) - 1);
                }, () {})
                    .show();
              });
            },
          ),
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
    _bills = [];
    buildDataGridRows();
  }
  clear(List<Bill> billDone) {
    if (_bills.length == billDone.length) {
      _bills = [];
    } else {
      for (Bill b in billDone) {
        _bills.remove(b);
      }
    }
    buildDataGridRows();
    updateDataGridSource();
  }

  bool contains(Bill bill) {
    for (var element in _bills) {
      if (element.item.name == bill.item.name) return true;
    }
    return false;
  }

  addBill(Bill bill) {
    _bills.add(bill);
    buildDataGridRows();
    updateDataGridSource();
  }

  void buildDataGridRows() {
    squ = 0;
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
          if (newCellValue >= 0 &&
              newCellValue <=
                  _bills[(dataGridRow.getCells()[0].value.toInt()) - 1]
                      .item
                      .count) {
            return true;
          } else {
            return false;
          }
        } catch (e) {
          return false;
        }
      } else {
        try {
          newCellValue = double.parse(editingController.text);
          if (newCellValue > 0) {
            return true;
          } else {
            return false;
          }
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

  deleteBill(int index) {
    _bills.removeAt(index);
    buildDataGridRows();
    updateDataGridSource();
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
