import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mustafa/core/strings/home_str.dart';
import 'package:mustafa/core/widgets/loading_widget.dart';
import 'package:mustafa/core/widgets/snack_bar.dart';
import 'package:mustafa/features/catalogue/domain/entities/catalogue.dart';
import 'package:mustafa/features/data_market/presentation/bloc/data_market_bloc.dart';
import '../bloc/catalogue_add/catalogue_bloc.dart';
import '../widgets/appbar_search.dart';
import '../widgets/catalogue_widget.dart';

const NUM_SECOND = 1;

class DrawerCataloguePage extends StatelessWidget {
  DrawerCataloguePage({super.key, required this.idSelected}) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (_keyRefeshIndicator.currentState != null) {
        _keyRefeshIndicator.currentState!.show();
      }
    });
  }

  final GlobalKey<RefreshIndicatorState> _keyRefeshIndicator =
      GlobalKey<RefreshIndicatorState>();
  List<Catalogue> total = [];
  String idSelected;
  @override
  Widget build(BuildContext context) {
    List<Catalogue> catalogues = [];
    bool showProgress = false;
    return BlocBuilder<CatalogueBloc, CatalogueState>(
      builder: (context, state) {
        if (state is GetedCataloguesState) {
          showProgress = false;
          catalogues = state.catalogues;
          total = catalogues;
          if (idSelected.isEmpty) {
            context.read<DataMarketBloc>().add(SelectCatalogueEvent(
                catalogue: catalogues.isNotEmpty
                    ? catalogues.first
                    : const Catalogue(name: TITLE_APP, id: "")));
          }
        } else if (state is MessageErrorState) {
          showProgress = false;
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            showErrorSnackBar(message: state.massage, context: context);
          });
        } else if (state is AddedCatalogueState) {
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            showPassSnackBar(message: state.message, context: context);
          });
          CatalogueBloc.get(context).add(GetCatalougesEvent());
        } else if (state is LoadingCataloguesState) {
          idSelected =
              state.changeIdSelected.id == idSelected && state.changeId == false
                  ? ""
                  : state.changeIdSelected.id == idSelected && state.changeId
                      ? "?"
                      : idSelected;
          idSelected == "?"
              ? DataMarketBloc.get(context)
                  .add(SelectCatalogueEvent(catalogue: state.changeIdSelected))
              : null;

          showProgress = true;
        } else if (state is FilterCataloguesState) {
          catalogues = state.catalogues;
        }
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            appBar: appBarSearch(total, context),
            floatingActionButton: addCatalogue(context),
            body: RefreshIndicator(
              key: _keyRefeshIndicator,
              onRefresh: () async {
                CatalogueBloc.get(context).add(GetCatalougesEvent());
                return Future.delayed(const Duration(seconds: NUM_SECOND));
              },
              child: Stack(
                children: [
                  ListView(children: [
                    ...List.generate(
                        catalogues.length,
                        (index) => mySlidAble(
                            catalogues[index], index + 1, context, idSelected)),
                  ]),
                  showProgress ? const LoadingWidget() : Container()
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
