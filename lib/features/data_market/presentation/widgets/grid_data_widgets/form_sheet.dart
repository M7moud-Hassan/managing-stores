import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mustafa/core/strings/home_str.dart';
import 'package:mustafa/core/widgets/divider.dart';
import 'package:mustafa/core/widgets/loading_widget.dart';
import 'package:mustafa/features/data_market/domain/entities/item.dart';
import 'package:mustafa/features/data_market/presentation/bloc/data_market/data_market_bloc.dart';
import 'package:mustafa/features/data_market/presentation/pages/data_grid_view.dart';

import '../../bloc/add_delete_modify_item/add_delete_update_bloc.dart';

const RADUS = 20.0;
const PADDING = 8.0;

class FormWidget extends StatelessWidget {
  const FormWidget(
      {super.key,
      required this.formKey,
      required this.item,
      required this.itemDataSourec});
  final GlobalKey<FormState> formKey;
  final ItemDataSourec itemDataSourec;
  final Item item;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddDeleteUpdateBloc, AddDeleteUpdateState>(
      builder: (context, state) {
        if (state is LoadAddedItemState) {
          return const LoadingWidget();
        } else if (state is AddedItemState) {
          DataMarketBloc.get(context).add(ShowMessageEvent(
              message: "$ADDED_ITEM ${state.item.name}", isError: false));
          item.cost = 0.0;
          item.name = "";
          item.count = 0;
          itemDataSourec.handleRefresh();
        } else if (state is ErrorMessageStateAdd) {
          DataMarketBloc.get(context)
              .add(ShowMessageEvent(message: state.message, isError: true));
        } else if (state is UpdateItemState) {
          DataMarketBloc.get(context).add(ShowMessageEvent(
              message: "$UPDATE_ITEM ${state.item.name}", isError: false));
          itemDataSourec.handleRefresh();
        }
        return _form();
      },
    );
  }

  Widget _form() => Directionality(
        textDirection: TextDirection.rtl,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(PADDING),
          child: Form(
              key: formKey,
              child: Column(
                children: [
                  _textFormField(TextInputType.text, NAME_ITEM),
                  mySizeBox,
                  _textFormField(TextInputType.number, COST),
                  mySizeBox,
                  _textFormField(
                      const TextInputType.numberWithOptions(decimal: true),
                      COUNT),
                ],
              )),
        ),
      );

  TextFormField _textFormField(type, label) => TextFormField(
        initialValue: label == NAME_ITEM
            ? item.name
            : label == COST
                ? item.cost.toString()
                : item.count.toString(),
        keyboardType: type,
        validator: (value) {
          switch (label) {
            case NAME_ITEM:
              if (value.toString().isNotEmpty) {
                item.name = value.toString();
                return null;
              } else {
                return EMPTY_FIELD;
              }

            case COST:
              if (value.toString().isNotEmpty &&
                  !value.toString().contains("-")) {
                try {
                  item.cost = double.parse(value.toString());
                } catch (e) {
                  return TYPE_INPUT_ERROR;
                }
                return null;
              } else {
                return TYPE_INPUT_ERROR;
              }

            case COUNT:
              if (value.toString().isNotEmpty &&
                  !value.toString().contains("-") &&
                  !value.toString().contains(".")) {
                try {
                  item.count = int.parse(value.toString());
                } catch (e) {
                  return TYPE_INPUT_ERROR;
                }
                return null;
              } else {
                return TYPE_INPUT_ERROR;
              }
          }
        },
        decoration: InputDecoration(
          hintText: label,
          labelText: label,
        ),
      );
  /*ElevatedButton _saveBtn() => ElevatedButton(
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          Item item = Item(id: "", name: name, count: count, cost: cost);
        }
      },
      child: const Text(SAVE));*/
}
