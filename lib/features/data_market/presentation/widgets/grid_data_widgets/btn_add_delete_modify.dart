import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:mustafa/core/strings/home_str.dart';
import 'package:mustafa/core/widgets/dialogs.dart';
import 'package:mustafa/features/data_market/domain/entities/item.dart';
import 'package:mustafa/features/data_market/presentation/widgets/grid_data_widgets/form_sheet.dart';

class BtnWidget extends StatelessWidget {
  late BtnWidgetType btnWidgetType;
  final Item item;
  BtnWidget.add({super.key, required this.item}) {
    btnWidgetType = BtnWidgetType.ADD;
  }

  BtnWidget.delete({super.key, required this.item}) {
    btnWidgetType = BtnWidgetType.DELETE;
  }
  BtnWidget.modify({super.key, required this.item}) {
    btnWidgetType = BtnWidgetType.MODFY;
  }

  @override
  Widget build(BuildContext context) {
    switch (btnWidgetType) {
      case BtnWidgetType.ADD:
        return FloatingActionButton(
          onPressed: () => _showSheet(context, item),
          child: const Icon(Icons.add),
        );
      case BtnWidgetType.DELETE:
        return _btnDeleteModfiy(
            Icons.delete,
            DELETE_ITEM,
            Colors.red,
            () => alertDialog(
                    context, DELETE_ITEM, CONFIRM_DELETE_ITEM, () {}, () {})
                .show());
      default:
        return _btnDeleteModfiy(Icons.edit, MODIFY_ITEM, Colors.green, () {
          _showSheet(context, item);
        });
    }
  }

  ElevatedButton _btnDeleteModfiy(icon, data, color, onPress) => ElevatedButton(
        onPressed: onPress,
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all<Color>(color),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Icon(icon), Text(data)],
        ),
      );

  void _showSheet(context, Item item) {
    GlobalKey<FormState> _formState = GlobalKey<FormState>();
    BuildContext myContext = context;
    AwesomeDialog(
            context: context,
            animType: AnimType.scale,
            dialogType: DialogType.noHeader,
            body: FormWidget(
              item: item,
              formKey: _formState,
            ),
            autoDismiss: false,
            onDismissCallback: (type) {},
            btnOkOnPress: () {
              if (_formState.currentState!.validate()) {}
            },
            btnOkText: SAVE,
            btnCancelOnPress: () {
              Navigator.pop(myContext);
            },
            btnCancelText: CANCEL)
        .show();
  }
}

enum BtnWidgetType { ADD, DELETE, MODFY }
