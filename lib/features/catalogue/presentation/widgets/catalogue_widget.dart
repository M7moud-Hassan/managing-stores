import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:mustafa/core/strings/catalogues.dart';
import 'package:mustafa/core/themes/my_colors.dart';
import 'package:mustafa/features/catalogue/domain/entities/catalogue.dart';
import 'package:mustafa/features/catalogue/presentation/bloc/catalogue_add/catalogue_bloc.dart';
import 'package:mustafa/features/catalogue/presentation/widgets/sheet_bottom_add_cata.dart';

import '../../../../core/widgets/dialogs.dart';

const WI_HE_CIRCLE = 40.0;
Widget catalogueItem(title, index) => ListTile(
      title: Text(title),
      leading: Container(
        width: WI_HE_CIRCLE,
        height: WI_HE_CIRCLE,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: Colors.grey),
        child: Center(
          child: Text(index.toString()),
        ),
      ),
    );

Widget addCatalogue(context) => FloatingActionButton(
    onPressed: () {
      showSheet(context, "");
    },
    child: const Icon(Icons.add));

void showSheet(context, id) {
  showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20), topRight: Radius.circular(20)),
    ),
    builder: (context) {
      return SheetAdd(
        id: id,
      );
    },
  ).whenComplete(() {
    textEditingController.text = ""; //clear text in field
  });
}

Widget mySlidAble(Catalogue catalogue, index, context) => Slidable(
      startActionPane: ActionPane(motion: const ScrollMotion(), children: [
        slidAbleAction(REPAIR_CATALOGUE, catalogue, context),
        slidAbleAction(DELETE_CATALOGUE, catalogue, context),
      ]),
      child: catalogueItem(catalogue.name, index),
    );

Widget slidAbleAction(label, Catalogue catalogue, contextBuilder) =>
    SlidableAction(
      onPressed: label == DELETE_CATALOGUE
          ? (context) {
              alertDialog(contextBuilder, DELETE_CATALOGUE_TITLE,
                      DELETE_CATALOGUE_DES, () {
                CatalogueBloc.get(contextBuilder)
                    .add(DeleteCatalogueEvent(catalogue: catalogue));
              }, () {})
                  .show();
            }
          : (context) {
              showSheet(context, catalogue.id);
              textEditingController.text = catalogue.name;
            },
      backgroundColor: label == DELETE_CATALOGUE
          ? BACKGROUND_SLIDBARE_DELETE
          : BACKGROUND_SLIDBARE_REPAIR,
      foregroundColor: FOREGROUND_SLIDEBAR,
      icon: label == DELETE_CATALOGUE ? Icons.delete : Icons.edit,
      label: label,
    );
