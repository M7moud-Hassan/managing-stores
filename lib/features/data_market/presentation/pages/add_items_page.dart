import 'package:flutter/material.dart';
import 'package:mustafa/core/strings/home_str.dart';
import 'package:mustafa/core/themes/my_colors.dart';
import 'package:mustafa/features/catalogue/domain/entities/catalogue.dart';
import 'package:mustafa/features/data_market/domain/entities/item.dart';
import 'package:mustafa/features/data_market/presentation/widgets/add_item_widgets/item_widget.dart';

import '../widgets/add_item_widgets/btn_modify_add.dart';

class AddItemPage extends StatelessWidget {
  const AddItemPage({super.key, required this.catalogue});
  final Catalogue catalogue;
  @override
  Widget build(BuildContext context) {
    List<Item> items = [
      Item(id: "1", name: "item1", count: 12, cost: 12.5),
      Item(id: "1", name: "item1", count: 12, cost: 12.5),
      Item(id: "1", name: "item1", count: 12, cost: 12.5),
      Item(id: "1", name: "item1", count: 12, cost: 12.5),
      Item(id: "1", name: "item1", count: 12, cost: 12.5),
      Item(id: "1", name: "item1", count: 12, cost: 12.5)
    ];
    return Scaffold(
      floatingActionButton: const BtnAddModify(),
      body: Table(
        columnWidths: const {
          0: FlexColumnWidth(1),
          1: FlexColumnWidth(5),
          2: FlexColumnWidth(2),
          3: FlexColumnWidth(2),
        },
        border: TableBorder.all(),
        children: [
          ItemWiget.header(ParameterItem(
              name: NAME_ITEM,
              cost: COST,
              count: COUNT,
              id: ESQUENCES,
              color: COLOR_HEADER,
              style: Theme.of(context).textTheme.titleLarge!)),
          ...List<ItemWiget>.generate(
              items.length,
              (index) => index % 2 == 0
                  ? ItemWiget.even(ParameterItem(
                      name: items[index].name,
                      cost: items[index].cost.toString(),
                      count: items[index].count.toString(),
                      id: (index + 1).toString(),
                      color: COLOR_EVEN,
                      style: Theme.of(context).textTheme.titleMedium!))
                  : ItemWiget.odd(ParameterItem(
                      name: items[index].name,
                      cost: items[index].cost.toString(),
                      count: items[index].count.toString(),
                      id: (index + 1).toString(),
                      color: COLOR_OLD,
                      style: Theme.of(context).textTheme.titleMedium!)))
        ],
      ),
    );
  }
}

class ParameterItem {
  final String name, cost, count;
  final String id;
  final Color color;
  final TextStyle style;
  ParameterItem({
    required this.name,
    required this.cost,
    required this.count,
    required this.id,
    required this.color,
    required this.style,
  });
}
