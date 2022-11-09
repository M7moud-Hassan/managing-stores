import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mustafa/core/themes/app_theme.dart';
import 'package:mustafa/features/catalogue/domain/entities/catalogue.dart';
import 'package:mustafa/features/catalogue/presentation/bloc/catalogue_add/catalogue_bloc.dart';

TextEditingController textEditingControllerSearch = TextEditingController();
AppBar appBarSearch(List<Catalogue> catalogues, context) {
  List<Catalogue> filter = [];
  return AppBar(
    automaticallyImplyLeading: false,
    title: CupertinoTextField(
      controller: textEditingControllerSearch,
      prefix: IconButton(
        icon: const Icon(
          Icons.close,
          color: primaryColor,
        ),
        onPressed: () {
          CatalogueBloc.get(context)
              .add(FilterCataloguesEvent(catalogues: catalogues));
          textEditingControllerSearch.clear();
        },
      ),
      onChanged: ((value) {
        filter = [];
        for (var element in catalogues) {
          if (element.name.contains(value)) {
            filter.add(element);
          }
        }
        CatalogueBloc.get(context)
            .add(FilterCataloguesEvent(catalogues: filter));
      }),
    ),
  );
}
