import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mustafa/core/strings/catalogues.dart';
import 'package:mustafa/features/catalogue/domain/entities/catalogue.dart';
import 'package:mustafa/features/catalogue/presentation/bloc/catalogue_bloc.dart';

TextEditingController textEditingController = TextEditingController();
Widget sheetAdd(context) => Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Colors.blueGrey,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
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
          textField(),
          // Text("${controller.length}/25"),
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

Widget saveCataloge(context) => IconButton(
    onPressed: () {
      if (textEditingController!.text.isNotEmpty) {
        CatalogueBloc.get(context).add(AddCatalogueEvent(
            catalogue: Catalogue(id: "", name: textEditingController.text)));
      }
      Navigator.of(context).pop();
    },
    icon: const Icon(
      Icons.add,
      color: Colors.red,
    ));

Widget textField() => SizedBox(
      width: 200,
      child: CupertinoTextField(
        controller: textEditingController,
        autofocus: true,
        maxLength: 25,
      ),
    );
