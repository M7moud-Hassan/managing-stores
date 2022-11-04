import 'package:flutter/material.dart';
import 'package:mustafa/core/strings/home_str.dart';
import 'package:mustafa/features/data_market/presentation/bloc/data_market_bloc.dart';

AppBar appBarHome(
        AnimationController controller, isDrawerOpen, context, title) =>
    AppBar(
      automaticallyImplyLeading: false,
      title: const Text(TITLE_APP),
      leading: IconButton(
        onPressed: () {
          if (isDrawerOpen) {
            DataMarketBloc.get(context).add(CloseDrawerEvent());
          } else {
            DataMarketBloc.get(context).add(OpenDrawerEvent());
          }
        },
        icon: AnimatedIcon(
          icon: AnimatedIcons.arrow_menu,
          progress: controller,
        ),
      ),
    );
