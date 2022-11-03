import 'package:flutter/material.dart';

import '../widgets/app_bar_home/app_bar_widget.dart';
import '../widgets/home_page/drawer_home.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: appBarHome(AnimationController(vsync: this)),
        body: const Scaffold(
          drawer: Drawer(
            child: DrawerHome(),
          ),
        ),
      ),
    );
  }
}
