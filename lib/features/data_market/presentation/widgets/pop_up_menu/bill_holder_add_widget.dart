import 'package:flutter/material.dart';
import 'package:mustafa/core/strings/bill_strings.dart';
import 'package:mustafa/core/strings/home_str.dart';
import 'package:mustafa/core/widgets/divider.dart';
import 'package:mustafa/features/data_market/presentation/bloc/data_market/data_market_bloc.dart';
import 'package:mustafa/features/data_market/presentation/pages/data_grid_view.dart';
import 'package:mustafa/features/invoice/domain/entities/bill_holder.dart';
import '../../../../../core/themes/my_colors.dart';
import '../../../../invoice/presentation/pages/invoice_page.dart';

class BillAdd extends StatelessWidget {
  BillAdd({super.key});
  BillHolder billHolder = BillHolder(name: "", phone: "");
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Colors.blueGrey,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            ),
            child: Row(
              children: [
                const Expanded(
                    child: Text(
                  BILL_HOLDER_ADD,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white),
                )),
                //btn click to save catalogue get name catalogue
                saveCataloge(context),
              ],
            ),
          ),
          mySizeBox,
          _filedBill(BILL_HOLDER_NAME),
          mySizeBox,
          _filedBill(BILL_HOLDER_PHONE),
          mySizeBox,
        ]),
      ),
    );
  }

  Widget _filedBill(String label) {
    return Padding(
      padding: const EdgeInsets.all(PADDING),
      child: TextField(
        onChanged: (value) {
          if (label == BILL_HOLDER_NAME) {
            billHolder.name = value;
          } else {
            billHolder.phone = value;
          }
        },
        decoration: InputDecoration(
          hintText: label,
          labelText: label,
        ),
      ),
    );
  }

  Widget saveCataloge(context) => IconButton(
      onPressed: () {
        if (billHolder.name.isEmpty || billHolder.phone.isEmpty) {
          // DataMarketBloc.get(context)
          //    .add(const ShowMessageEvent(message: EMPTY_FIELD, isError: true));
        } else {
          Navigator.pop(context);
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => InvoicePage(billHolder: billHolder)),
          );
        }
      },
      icon: const Icon(
        Icons.add,
        color: BTN_SAVE,
      ));
}
