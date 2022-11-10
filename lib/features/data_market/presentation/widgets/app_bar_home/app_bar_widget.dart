import 'package:flutter/material.dart';
import 'package:mustafa/core/strings/home_str.dart';
import 'package:mustafa/features/catalogue/domain/entities/catalogue.dart';
import 'package:mustafa/features/data_market/presentation/bloc/data_market/data_market_bloc.dart';
import 'package:mustafa/features/data_market/presentation/widgets/pop_up_menu/pop_up_menu_widget.dart';

AppBar appBarHome(AnimationController controller, isDrawerOpen, context,
        Catalogue catalogue) =>
    AppBar(
      automaticallyImplyLeading: false,
      title: Text(isDrawerOpen ? TITLE_APP : catalogue.name),
      leading: IconButton(
        onPressed: () {
          if (isDrawerOpen) {
            DataMarketBloc.get(context)
                .add(CloseDrawerEvent(selectedCatalogue: catalogue));
          } else {
            DataMarketBloc.get(context).add(OpenDrawerEvent());
          }
        },
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: controller,
        ),
      ),
      actions: const [MyPopUpMenu()],
    );
