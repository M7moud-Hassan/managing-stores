import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mustafa/core/strings/home_str.dart';
import 'package:mustafa/features/catalogue/domain/entities/catalogue.dart';
import 'package:mustafa/features/data_market/presentation/pages/hello_page.dart';

import '../../../../core/widgets/snack_bar.dart';
import '../../../catalogue/presentation/pages/drawer_catalogue_page.dart';
import '../bloc/data_market/data_market_bloc.dart';
import '../widgets/app_bar_home/app_bar_widget.dart';
import 'data_grid_view.dart';

const DEFAULT_ID = "-1";

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late GlobalKey<ScaffoldState> _globalKey;
  bool isDrawerOpen = false;
  String title = TITLE_APP;
  Catalogue catalogue = const Catalogue(name: TITLE_APP, id: DEFAULT_ID);
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: const Duration(microseconds: 300));
    _globalKey = GlobalKey<ScaffoldState>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DataMarketBloc, DataMarketState>(
      builder: (context, state) {
        if (state is OpenDrawerState) {
          title = TITLE_APP;
          isDrawerOpen = true;
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            _globalKey.currentState!.openDrawer();
            _animationController.forward();
          });
        } else if (state is CloseDrawerState) {
          title = state.selectedCatalogue.name;
          catalogue = state.selectedCatalogue;
          isDrawerOpen = false;
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            _globalKey.currentState!.closeDrawer();
            _animationController.reverse();
          });
        } else if (state is ShowMessageSuccefulState) {
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            showPassSnackBar(message: state.message, context: context);
          });
        } else if (state is ErrorMessageState) {
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            showErrorSnackBar(message: state.message, context: context);
          });
        }
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            appBar: appBarHome(
                _animationController, isDrawerOpen, context, catalogue),
            body: Scaffold(
              key: _globalKey,
              onDrawerChanged: (isOpened) {
                if (isOpened) {
                  DataMarketBloc.get(context).add(OpenDrawerEvent());
                } else {
                  DataMarketBloc.get(context)
                      .add(CloseDrawerEvent(selectedCatalogue: catalogue));
                }
              },
              drawer: Drawer(
                child: DrawerCataloguePage(
                  idSelected: catalogue.id,
                ),
              ),
              body: catalogue.id == DEFAULT_ID
                  ? const HelloPage()
                  : DataGridView(
                      catalogue: catalogue,
                    ),
            ),
          ),
        );
      },
    );
  }
}
