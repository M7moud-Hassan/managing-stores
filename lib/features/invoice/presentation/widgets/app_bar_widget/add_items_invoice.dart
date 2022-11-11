import 'package:flutter/material.dart';
import 'package:mustafa/core/methods/show_sheet_fun.dart';
import 'package:mustafa/features/invoice/presentation/bloc/add_item_invoice/add_item_invoice_bloc.dart';
import 'package:mustafa/features/invoice/presentation/widgets/add_to_invoice.dart/add_to_invoice_widget.dart';

class AddButnItemInvoice extends StatelessWidget {
  const AddButnItemInvoice({super.key, required this.scafoldKey});
  final GlobalKey<ScaffoldState> scafoldKey;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => {
        showSheet(context, AddToInVoice()),
        AddItemInvoiceBloc.get(context).add(ReadDataEvent())
      },
      child: const Icon(Icons.add),
    );
  }
}
