import 'package:flutter/material.dart';
import 'package:mustafa/features/data_market/presentation/widgets/home_page/menu_catalogues.dart';

class DrawerHome extends StatelessWidget {
  const DrawerHome({super.key});
  @override
  Widget build(BuildContext context) {
    List<String> _catalogues = ["main"];
    return SingleChildScrollView(
      child: Column(
        children: [
          ...List.generate(
              _catalogues.length, (index) => catalogue(_catalogues[index]))
        ],
      ),
    );
  }
}
