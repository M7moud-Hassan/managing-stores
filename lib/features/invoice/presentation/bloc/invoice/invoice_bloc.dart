import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mustafa/features/invoice/domain/entities/bill.dart';

part 'invoice_event.dart';
part 'invoice_state.dart';

class InvoiceBloc extends Bloc<InvoiceEvent, InvoiceState> {
  InvoiceBloc() : super(InvoiceInitial()) {
    on<InvoiceEvent>((event, emit) {
      if (event is ShowErrorMessageInvoiceEvent) {
        emit(ShowErrorMessageInvoiceSatae(
            message: event.message, padding: event.padding));
      } else if (event is AddItemBillEvent) {
        emit(AddItemToBill(bill: event.bill));
      }
    });
  }

  static InvoiceBloc get(BuildContext context) =>
      BlocProvider.of<InvoiceBloc>(context);
}
