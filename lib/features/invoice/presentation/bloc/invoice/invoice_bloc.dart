import 'dart:math';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mustafa/core/methods/map_failure_string.dart';
import 'package:mustafa/core/strings/failures.dart';
import 'package:mustafa/core/themes/my_colors.dart';
import 'package:mustafa/features/data_market/domain/usecases/update_for_invoice.dart';
import 'package:mustafa/features/data_market/domain/usecases/update_item.dart';
import 'package:mustafa/features/data_market/presentation/pages/data_grid_view.dart';
import 'package:mustafa/features/invoice/domain/entities/bill.dart';

part 'invoice_event.dart';
part 'invoice_state.dart';

class InvoiceBloc extends Bloc<InvoiceEvent, InvoiceState> {
  final UpdateForInvoiceUserCase updateForInvoiceUserCase;
  late Either result;
  late List<Bill> billsDone;
  InvoiceBloc({required this.updateForInvoiceUserCase})
      : super(InvoiceInitial()) {
    on<InvoiceEvent>((event, emit) async {
      if (event is ShowErrorMessageInvoiceEvent) {
        emit(ShowErrorMessageInvoiceSatae(
            message: event.message, padding: event.padding));
      } else if (event is AddItemBillEvent) {
        emit(AddItemToBill(bill: event.bill));
      } else if (event is ExportInvoiceEvent) {
        billsDone = [];
        emit(StartExportInvoiceState());
        for (Bill bill in event.bills) {
          // bill.item.count -= bill.count;
          result = await updateForInvoiceUserCase(bill);
          result.fold(
              (l) => emit(ShowErrorMessageInvoiceSatae(
                  message: mapError(l), padding: PADDING)),
              (r) => billsDone.add(bill));
        }
        emit(ExportInvoiceState(billsDone: billsDone));
        if (billsDone.length != event.bills.length) {
          emit(const ShowErrorMessageInvoiceSatae(
              message: ERROR_UnKNOW_INVOICE, padding: PADDING));
        }
      }
    });
  }

  static InvoiceBloc get(BuildContext context) =>
      BlocProvider.of<InvoiceBloc>(context);
}
