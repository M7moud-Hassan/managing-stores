import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:mustafa/core/strings/home_str.dart';
import 'package:mustafa/core/widgets/dialogs.dart';
import 'package:mustafa/features/data_market/domain/entities/item.dart';
import 'package:mustafa/features/data_market/presentation/bloc/add_delete_modify_item/add_delete_update_bloc.dart';
import 'package:mustafa/features/data_market/presentation/pages/data_grid_view.dart';
import 'package:mustafa/features/data_market/presentation/pages/home_page.dart';
import 'package:mustafa/features/data_market/presentation/widgets/grid_data_widgets/form_sheet.dart';

class BtnWidget extends StatelessWidget {
  late BtnWidgetType btnWidgetType;
  final BuildContext myContext;
  final ItemDataSourec itemDataSourec;
  final Item item;
  BtnWidget.add(
      {super.key,
      required this.item,
      required this.myContext,
      required this.itemDataSourec}) {
    btnWidgetType = BtnWidgetType.ADD;
  }

  BtnWidget.delete(
      {super.key,
      required this.item,
      required this.myContext,
      required this.itemDataSourec}) {
    btnWidgetType = BtnWidgetType.DELETE;
  }
  BtnWidget.modify(
      {super.key,
      required this.item,
      required this.myContext,
      required this.itemDataSourec}) {
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
            () => alertDialog(context, DELETE_ITEM, CONFIRM_DELETE_ITEM, () {
                  AddDeleteUpdateBloc.get(myContext)
                      .add(DeleteItemEvent(item: item, context: myContext));
                  // itemDataSourec.handleRefresh();
                }, () {})
                    .show());
      default:
        return _btnDeleteModfiy(Icons.edit, MODIFY_ITEM, Colors.green, () {
          _showSheet(context, item);
        });
    }
  }

  Widget _btnDeleteModfiy(icon, data, color, onPress) => FloatingActionButton(
        onPressed: null,
        child: ElevatedButton(
          onPressed: onPress,
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(color),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Icon(icon), Text(data)],
          ),
        ),
      );

  void _showSheet(context, Item item) {
    GlobalKey<FormState> formState = GlobalKey<FormState>();
    AwesomeDialog(
            context: context,
            animType: AnimType.scale,
            dialogType: DialogType.noHeader,
            body: FormWidget(
              item: item,
              formKey: formState,
              itemDataSourec: itemDataSourec,
            ),
            autoDismiss: false,
            onDismissCallback: (type) {},
            btnOkOnPress: () {
              if (formState.currentState!.validate()) {
                // DataMarketBloc.get(myContext).add(AddItemEvent(item: item));
                if (item.id == DEFAULT_ID) {
                  AddDeleteUpdateBloc.get(myContext)
                      .add(AddItemEvent(item: item));
                } else {
                  AddDeleteUpdateBloc.get(myContext)
                      .add(UpdateItemEvent(item: item));
                }
              }
              //itemDataSourec.handleRefresh();
            },
            btnOkText: SAVE,
            btnCancelOnPress: () {
              AddDeleteUpdateBloc.get(myContext).emit(CloseDialogStata());
              Navigator.pop(myContext);
            },
            btnCancelText: CANCEL)
        .show();
  }
}

enum BtnWidgetType { ADD, DELETE, MODFY }
