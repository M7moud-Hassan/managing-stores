import 'package:flutter/material.dart';
import 'package:mustafa/core/themes/my_colors.dart';
import 'package:mustafa/features/catalogue/domain/entities/catalogue.dart';
import 'package:mustafa/features/data_market/domain/entities/item.dart';
import 'package:mustafa/features/data_market/presentation/widgets/add_item_widgets/btn_modify_add.dart';
import 'package:mustafa/features/data_market/presentation/widgets/grid_data_widgets/btn_add_delete_modify.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import '../../../catalogue/presentation/pages/drawer_catalogue_page.dart';
import '../widgets/grid_data_widgets/column_name_widget.dart';

const PADDING = 8.0;

class DataGridView extends StatefulWidget {
  const DataGridView({super.key, required this.catalogue});
  final Catalogue catalogue;
  @override
  State<DataGridView> createState() => _DataGridViewState();
}

class _DataGridViewState extends State<DataGridView> {
  late List<Item> _items;
  late ItemDataSourec _itemDataSourec;
  @override
  void initState() {
    super.initState();
    _items = _getItems();
    _itemDataSourec = ItemDataSourec(items: _items);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: BtnWidget.add(
        item: Item(name: "", cost: 0.0, count: 0, id: "-1"),
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
          item: _items[rowIndex],
        ),
        endSwipeActionsBuilder: (context, dataGridRow, rowIndex) =>
            BtnWidget.modify(
          item: _items[(dataGridRow.getCells()[0].value.toInt()) - 1],
        ),
      ),
    );
  }

  List<Item> _getItems() => [
        Item(id: "fff", name: "item1", count: 162, cost: 145.9),
        Item(id: "fff", name: "item2", count: 16, cost: 15.9),
        Item(id: "fff", name: "item3", count: 222, cost: 1745.9),
        Item(id: "fff", name: "item4", count: 92, cost: 1.9),
        Item(id: "fff", name: "item5", count: 82, cost: 45.9),
        Item(id: "fff", name: "item6", count: 72, cost: 5.9),
        Item(id: "fff", name: "item7", count: 16, cost: 45.9),
        Item(id: "fff", name: "item8", count: 15, cost: 14.9),
        Item(id: "fff", name: "item9", count: 152, cost: 75.9),
        Item(id: "fff", name: "item11", count: 12, cost: 75.9),
        Item(id: "fff", name: "item1", count: 162, cost: 145.9),
        Item(id: "fff", name: "item2", count: 16, cost: 15.9),
        Item(id: "fff", name: "item3", count: 222, cost: 1745.9),
        Item(id: "fff", name: "item4", count: 92, cost: 1.9),
        Item(id: "fff", name: "item5", count: 82, cost: 45.9),
        Item(id: "fff", name: "item6", count: 72, cost: 5.9),
        Item(id: "fff", name: "item7", count: 16, cost: 45.9),
        Item(id: "fff", name: "item8", count: 15, cost: 14.9),
        Item(id: "fff", name: "item9", count: 152, cost: 75.9),
        Item(id: "fff", name: "item11", count: 12, cost: 75.9)
      ];
}

const COLUMN1 = "id";
const COLUMN2 = "name";
const COLUMN3 = "cost";
const COLUMN4 = "count";

class ItemDataSourec extends DataGridSource {
  static int squ = 0;
  ItemDataSourec({required List<Item> items}) {
    _dataGridRows = items
        .map<DataGridRow>((item) => DataGridRow(cells: [
              DataGridCell<int>(columnName: COLUMN1, value: ++squ),
              DataGridCell<String>(columnName: COLUMN2, value: item.name),
              DataGridCell<double>(columnName: COLUMN3, value: item.cost),
              DataGridCell<int>(columnName: COLUMN4, value: item.count)
            ]))
        .toList();
  }

  @override
  Future<void> handleRefresh() async {
    await Future.delayed(const Duration(seconds: NUM_SECOND));

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
