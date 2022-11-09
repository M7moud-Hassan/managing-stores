import 'package:flutter/material.dart';
import 'package:mustafa/core/strings/home_str.dart';
import 'package:mustafa/features/data_market/presentation/widgets/add_item_widgets/add_modify_widget.dart';

const ROUND_VALUE = 20.0;

class BtnAddModify extends StatelessWidget {
  const BtnAddModify({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => _showSheetAddModify(context),
      child: const Text(ADD_MODFY),
    );
  }

  void _showSheetAddModify(context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(ROUND_VALUE),
            topRight: Radius.circular(ROUND_VALUE)),
      ),
      builder: (context) => AddOrModfiyWidget(),
    ).whenComplete(() => null);
  }
}
