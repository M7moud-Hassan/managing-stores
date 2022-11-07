import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mustafa/core/strings/catalogues.dart';
import 'package:mustafa/core/themes/my_colors.dart';
import 'package:mustafa/features/catalogue/domain/entities/catalogue.dart';
import 'package:mustafa/features/catalogue/presentation/bloc/sheet_catalogue/sheet_add_catalogue_bloc.dart';

import '../bloc/catalogue_add/catalogue_bloc.dart';

TextEditingController textEditingController = TextEditingController();
const LENTH_TEXT = 35;
const WIDTH_TEXT_FIELD = 200.0;

class SheetAdd extends StatelessWidget {
  const SheetAdd({super.key, required this.id});
  final String id;
  @override
  Widget build(BuildContext context) {
    int length = 0;
    return BlocBuilder<SheetAddCatalogueBloc, SheetAddCatalogueState>(
      builder: (context, state) {
        if (state is ChangeLengthTextState) {
          length = state.length;
        }
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.blueGrey,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                ),
                child: Row(
                  children: [
                    const Expanded(
                        child: Text(
                      NAME_CATALOGUE,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white),
                    )),
                    //btn click to save catalogue get name catalogue
                    saveCataloge(context),
                  ],
                ),
              ),
              const Icon(
                Icons.folder,
                color: Colors.brown,
                size: 80,
              ),
              //text field
              textField(context),
              lengthText(length),
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(Icons.cancel)),
                  const Expanded(child: Text(""))
                ],
              )
            ],
          ),
        );
      },
    );
  }

  Widget lengthText(length) => Text("$length/$LENTH_TEXT");

  Widget saveCataloge(context) => IconButton(
      onPressed: () {
        if (textEditingController.text.isNotEmpty) {
          CatalogueEvent catalogueEvent = id.isEmpty
              ? AddCatalogueEvent(
                  catalogue:
                      Catalogue(id: "", name: textEditingController.text))
              : RepairNameCatalogueEvent(
                  catalogue:
                      Catalogue(id: id, name: textEditingController.text));
          CatalogueBloc.get(context).add(catalogueEvent);
        }
        Navigator.of(context).pop();
      },
      icon: const Icon(
        Icons.add,
        color: BTN_SAVE,
      ));

  Widget textField(context) => SizedBox(
        width: WIDTH_TEXT_FIELD,
        child: CupertinoTextField(
          onChanged: ((value) => SheetAddCatalogueBloc.get(context)
              .add(ChangeLengthTextEvent(length: value.length))),
          controller: textEditingController,
          autofocus: true,
          maxLength: LENTH_TEXT,
        ),
      );
}
