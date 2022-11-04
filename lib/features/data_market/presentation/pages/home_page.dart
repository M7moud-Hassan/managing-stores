import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mustafa/core/strings/home_str.dart';
import 'package:mustafa/features/data_market/presentation/bloc/data_market_bloc.dart';

import '../widgets/app_bar_home/app_bar_widget.dart';
import '../widgets/home_page/drawer_home.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late GlobalKey<ScaffoldState> _globalKey;
  bool isDrawerOpen = false;
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
          isDrawerOpen = true;
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            _globalKey.currentState!.openDrawer();
            _animationController.forward();
          });
        } else if (state is CloseDrawerState) {
          isDrawerOpen = false;
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            _globalKey.currentState!.closeDrawer();
            _animationController.reverse();
          });
        }
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            appBar: appBarHome(
                _animationController, isDrawerOpen, context, TITLE_APP),
            body: Scaffold(
              key: _globalKey,
              onDrawerChanged: (isOpened) {
                if (isOpened) {
                  DataMarketBloc.get(context).add(OpenDrawerEvent());
                } else {
                  DataMarketBloc.get(context).add(CloseDrawerEvent());
                }
              },
              drawer: const Drawer(
                child: DrawerHome(),
              ),
            ),
          ),
        );
      },
    );
  }
}
