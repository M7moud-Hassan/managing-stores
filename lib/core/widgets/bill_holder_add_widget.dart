import 'package:flutter/material.dart';
import 'package:mustafa/core/strings/bill_strings.dart';
import 'package:mustafa/core/strings/home_str.dart';
import 'package:mustafa/features/data_market/presentation/pages/data_grid_view.dart';
import 'package:mustafa/features/invoice/domain/entities/bill_holder.dart';
import '../../features/invoice/presentation/pages/invoice_page.dart';

class BillAdd extends StatelessWidget {
  BillAdd({super.key});
  BillHolder billHolder = BillHolder(name: "", phone: "", address: "");
  final GlobalKey<FormState> _keyForm = GlobalKey();
  final address = RegExp(r'^(.+/.+)+$');
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SingleChildScrollView(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Form(
              key: _keyForm,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _filedBill(BILL_HOLDER_NAME, BILL_HOLDER_NAME, billHolder),
                  // mySizeBox,
                  _filedBill(ADDRESS_LABEL, ADDRESS_HINT, billHolder),
                  // mySizeBox,
                  _filedBill(BILL_HOLDER_PHONE, BILL_HOLDER_PHONE, billHolder),
                  // mySizeBox,
                ],
              ))
        ]),
      ),
    );
  }

  Widget _filedBill(String label, String hint, BillHolder holder) {
    return Padding(
      padding: const EdgeInsets.all(PADDING),
      child: TextFormField(
        keyboardType: label == BILL_HOLDER_PHONE
            ? TextInputType.phone
            : TextInputType.text,
        decoration: InputDecoration(hintText: hint, labelText: label),
        validator: (value) {
          if (value.toString().isEmpty) {
            return EMPTY_FIELD;
          } else if (label == ADDRESS_LABEL) {
            if (address.hasMatch(value.toString())) {
              billHolder.address = value.toString();
              return null;
            } else {
              return ADDRESS_ERROR;
            }
          } else {
            if (label == BILL_HOLDER_NAME) {
              billHolder.name = value.toString();
              return null;
            } else {
              billHolder.phone = value.toString();
              return null;
            }
          }
        },
      ),
    );
  }

  void openInvoice(context) {
    if (_keyForm.currentState!.validate()) {
      Navigator.pop(context);
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => InvoicePage(billHolder: billHolder)),
      );
    }
  }
}
