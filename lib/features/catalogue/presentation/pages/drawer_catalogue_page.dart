import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mustafa/core/widgets/divider.dart';
import 'package:mustafa/features/catalogue/domain/entities/catalogue.dart';
import '../bloc/catalogue_bloc.dart';
import '../widgets/catalogue_widget.dart';

class DrawerCataloguePage extends StatelessWidget {
  const DrawerCataloguePage({super.key});
  @override
  Widget build(BuildContext context) {
    List<Catalogue> _catalogues = [];
    return BlocBuilder<CatalogueBloc, CatalogueState>(
      builder: (context, state) {
        if (state is GetedCataloguesState) {
          _catalogues = state.catalogues;
        }
        return Scaffold(
          floatingActionButton: addCatalogue(context),
          body: SingleChildScrollView(
            child: Column(children: [
              ...List.generate(_catalogues.length,
                  (index) => catalogueItem(_catalogues[index].name, index + 1)),
            ]),
          ),
        );
      },
    );
  }
}
