import 'package:flutter/material.dart';
import 'package:mustafa/core/strings/home_str.dart';
import 'package:mustafa/core/widgets/divider.dart';
import 'package:mustafa/features/data_market/domain/entities/item.dart';

const RADUS = 20.0;
const PADDING = 8.0;

class FormWidget extends StatelessWidget {
  const FormWidget({super.key, required this.formKey, required this.item});
  final GlobalKey<FormState> formKey;
  final Item item;
  @override
  Widget build(BuildContext context) {
    return _form();
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
