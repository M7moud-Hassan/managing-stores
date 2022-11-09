import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:mustafa/core/strings/catalogues.dart';
import 'package:mustafa/core/themes/my_colors.dart';
import 'package:mustafa/features/catalogue/domain/entities/catalogue.dart';
import 'package:mustafa/features/catalogue/presentation/bloc/catalogue_add/catalogue_bloc.dart';
import 'package:mustafa/features/catalogue/presentation/widgets/sheet_bottom_add_cata.dart';
import 'package:mustafa/features/data_market/presentation/bloc/data_market/data_market_bloc.dart';

import '../../../../core/widgets/dialogs.dart';

const WI_HE_CIRCLE = 40.0;
Widget catalogueItem(Catalogue catalogue, index, idSelected, context) =>
    ListTile(
      onTap: () {
        DataMarketBloc.get(context)
            .add(SelectCatalogueEvent(catalogue: catalogue));
      },
      title: Text(catalogue.name),
      selected: catalogue.id == idSelected,
      selectedColor: SELECTED_COLOR,
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

Widget mySlidAble(Catalogue catalogue, index, context, idSelected) => Slidable(
      startActionPane: ActionPane(motion: const ScrollMotion(), children: [
        slidAbleAction(REPAIR_CATALOGUE, catalogue, context, idSelected),
        slidAbleAction(DELETE_CATALOGUE, catalogue, context, idSelected),
      ]),
      child: catalogueItem(catalogue, index, idSelected, context),
    );

Widget slidAbleAction(label, Catalogue catalogue, contextBuilder, idSelected) =>
    SlidableAction(
      onPressed: label == DELETE_CATALOGUE
          ? (context) {
              alertDialog(contextBuilder, DELETE_CATALOGUE_TITLE,
                      DELETE_CATALOGUE_DES, () {
                CatalogueBloc.get(contextBuilder).add(DeleteCatalogueEvent(
                    catalogue: catalogue,
                    changeIdSelected: idSelected == catalogue.id));
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
