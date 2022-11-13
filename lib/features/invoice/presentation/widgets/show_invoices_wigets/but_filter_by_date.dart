import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:mustafa/features/invoice/presentation/bloc/show_all_invoices/show_all_invoices_bloc.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../../../../core/strings/home_str.dart';

class BtnFilterByDate extends StatelessWidget {
  BtnFilterByDate({super.key});

  PickerDateRange? pickerDateRange = null;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        _showDialogDate(context);
      },
      child: Icon(Icons.date_range),
    );
  }

  _showDialogDate(BuildContext context) {
    AwesomeDialog(
            context: context,
            animType: AnimType.scale,
            dialogType: DialogType.noHeader,
            body: pickerDate(),
            autoDismiss: false,
            onDismissCallback: (type) {},
            btnOkOnPress: () {
              Navigator.pop(context);
              if (pickerDateRange!.startDate != null) {
                if (pickerDateRange!.endDate == null) {
                  pickerDateRange = PickerDateRange(
                      pickerDateRange!.startDate, pickerDateRange!.startDate);
                }
                ShowAllInvoicesBloc.get(context).add(
                    StartFilterByDateEvent(pickerDateRange: pickerDateRange!));
              }
            },
            btnOkText: SAVE,
            btnCancelOnPress: () {
              Navigator.pop(context);
            },
            btnCancelText: CANCEL)
        .show()
        .whenComplete(() => null);
  }

  Widget pickerDate() => SfDateRangePicker(
        onSelectionChanged: (dateRangePickerSelectionChangedArgs) {
          if (dateRangePickerSelectionChangedArgs.value is PickerDateRange) {
            this.pickerDateRange = dateRangePickerSelectionChangedArgs.value;
          }
        },
        selectionMode: DateRangePickerSelectionMode.range,
        initialSelectedRange: PickerDateRange(
            DateTime.now().subtract(const Duration(days: 4)),
            DateTime.now().add(const Duration(days: 3))),
      );
}
