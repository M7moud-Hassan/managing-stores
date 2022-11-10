import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mustafa/core/methods/map_failure_string.dart';
import 'package:mustafa/core/themes/my_colors.dart';
import 'package:mustafa/core/widgets/snack_bar.dart';
import 'package:mustafa/features/catalogue/domain/entities/catalogue.dart';
import 'package:mustafa/features/catalogue/presentation/pages/drawer_catalogue_page.dart';
import 'package:mustafa/features/data_market/domain/entities/item.dart';
import 'package:mustafa/features/data_market/domain/usecases/get_all_items.dart';
import 'package:mustafa/features/data_market/presentation/pages/home_page.dart';
import 'package:mustafa/features/data_market/presentation/widgets/grid_data_widgets/btn_add_delete_modify.dart';
import 'package:mustafa/injections/injection_mark_data.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import '../bloc/data_market/data_market_bloc.dart';
import '../widgets/grid_data_widgets/column_name_widget.dart';

const PADDING = 8.0;

class DataGridView extends StatefulWidget {
  DataGridView({super.key, required this.catalogue});
  Catalogue catalogue;
  @override
  State<DataGridView> createState() => _DataGridViewState();
}

class _DataGridViewState extends State<DataGridView> {
  late ItemDataSourec _itemDataSourec;

  _DataGridViewState();
  @override
  void initState() {
    super.initState();
    _itemDataSourec = ItemDataSourec(
        catalogue: widget.catalogue, myContext: context, items: []);
    _itemDataSourec.handleRefresh();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<DataMarketBloc, DataMarketState>(
      listener: (context, state) {
        if (state is CloseDrawerState) {
          _itemDataSourec.catalogue = state.selectedCatalogue;
          widget.catalogue = state.selectedCatalogue;
          _itemDataSourec.handleRefresh();
        }
      },
      child: Scaffold(
        floatingActionButton: BtnWidget.add(
          item: Item(
              name: "",
              cost: 0.0,
              count: 0,
              id: DEFAULT_ID,
              catalogue: widget.catalogue.id),
          myContext: context,
          itemDataSourec: _itemDataSourec,
        ),
        body: SfDataGrid(
          source: _itemDataSourec,
          columns: columnsName(context),
          allowSorting: true,
          allowFiltering: true,
          frozenColumnsCount: 1,
          allowSwiping: true,
          allowPullToRefresh: true,
          startSwipeActionsBuilder: (context, dataGridRow, rowIndex) =>
              BtnWidget.delete(
            item: _itemDataSourec
                .items[(dataGridRow.getCells()[0].value.toInt()) - 1],
            myContext: context,
            itemDataSourec: _itemDataSourec,
          ),
          endSwipeActionsBuilder: (context, dataGridRow, rowIndex) =>
              BtnWidget.modify(
            item: _itemDataSourec
                .items[(dataGridRow.getCells()[0].value.toInt()) - 1],
            myContext: context,
            itemDataSourec: _itemDataSourec,
          ),
        ),
      ),
    );
  }
}

const COLUMN1 = "id";
const COLUMN2 = "name";
const COLUMN3 = "cost";
const COLUMN4 = "count";

class ItemDataSourec extends DataGridSource {
  static int squ = 0;
  Catalogue catalogue;
  final BuildContext myContext;
  List<Item> items;
  GetAllItems getAllItems = sl<GetAllItems>();

  ItemDataSourec({
    required this.items,
    required this.catalogue,
    required this.myContext,
  }) {
    buildDataGridRows();
  }

  void buildDataGridRows() {
    _dataGridRows = items
        .map<DataGridRow>((item) => DataGridRow(cells: [
              DataGridCell<int>(columnName: COLUMN1, value: ++squ),
              DataGridCell<String>(columnName: COLUMN2, value: item.name),
              DataGridCell<double>(columnName: COLUMN3, value: item.cost),
              DataGridCell<int>(columnName: COLUMN4, value: item.count)
            ]))
        .toList();
  }

  void updateDataGridSource() {
    notifyListeners();
  }

  @override
  Future<void> handleRefresh() async {
    getAllItems(catalogue.id).then((value) {
      value.fold(
          (l) => showErrorSnackBar(message: mapError(l), context: myContext),
          (r) {
        items = r;
        squ = 0;
        buildDataGridRows();
        updateDataGridSource();
      });
    });
    await Future.delayed(const Duration(seconds: NUM_SECOND));
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
