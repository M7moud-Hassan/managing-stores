import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mustafa/core/widgets/snack_bar.dart';
import 'package:mustafa/features/catalogue/domain/entities/catalogue.dart';
import '../bloc/catalogue_add/catalogue_bloc.dart';
import '../widgets/catalogue_widget.dart';

class DrawerCataloguePage extends StatelessWidget {
  const DrawerCataloguePage({super.key});
  @override
  Widget build(BuildContext context) {
    List<Catalogue> catalogues = [];
    return BlocBuilder<CatalogueBloc, CatalogueState>(
      builder: (context, state) {
        if (state is GetedCataloguesState) {
          catalogues = state.catalogues;
        } else if (state is MessageErrorState) {
          errorSnackBar(state.massage);
        } else if (state is AddedCatalogueState) {
          CatalogueBloc.get(context).add(GetCatalougesEvent());
        }
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            floatingActionButton: addCatalogue(context),
            body: SingleChildScrollView(
              child: Column(children: [
                ...List.generate(
                    catalogues.length,
                    (index) =>
                        mySlidAble(catalogues[index], index + 1, context)),
              ]),
            ),
          ),
        );
      },
    );
  }
}
