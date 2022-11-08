import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mustafa/features/data_market/presentation/pages/add_items_page.dart';

class ItemWiget extends TableRow {
  const ItemWiget({super.children, super.decoration});
  factory ItemWiget.odd(ParameterItem parameterItem) {
    return ItemWiget._createRow(parameterItem);
  }

  factory ItemWiget.even(ParameterItem parameterItem) {
    return ItemWiget._createRow(parameterItem);
  }

  factory ItemWiget.header(ParameterItem parameterItem) {
    return ItemWiget._createRow(parameterItem);
  }

  factory ItemWiget._createRow(ParameterItem parameterItem) => ItemWiget(
          decoration: BoxDecoration(color: parameterItem.color),
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                parameterItem.id.toString(),
                style: parameterItem.style,
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                parameterItem.name,
                style: parameterItem.style,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                parameterItem.cost.toString(),
                style: parameterItem.style,
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                parameterItem.count.toString(),
                style: parameterItem.style,
                textAlign: TextAlign.center,
              ),
            ),
          ]);
}
