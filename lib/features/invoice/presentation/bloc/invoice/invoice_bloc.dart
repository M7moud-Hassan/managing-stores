import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mustafa/core/methods/map_failure_string.dart';
import 'package:mustafa/core/strings/failures.dart';
import 'package:mustafa/features/data_market/domain/usecases/update_for_invoice.dart';
import 'package:mustafa/features/data_market/presentation/pages/data_grid_view.dart';
import 'package:mustafa/features/invoice/domain/entities/bill.dart';
import 'package:mustafa/features/invoice/domain/entities/bill_holder.dart';
import 'package:mustafa/features/invoice/domain/usecases/upload_invoice.dart';

part 'invoice_event.dart';
part 'invoice_state.dart';

class InvoiceBloc extends Bloc<InvoiceEvent, InvoiceState> {
  final UpdateForInvoiceUserCase updateForInvoiceUserCase;
  final UploadInVoice uploadInVoice;
  late Either result;
  late List<Bill> billsDone;
  InvoiceBloc({
    required this.updateForInvoiceUserCase,
    required this.uploadInVoice,
  }) : super(InvoiceInitial()) {
    on<InvoiceEvent>((event, emit) async {
      if (event is ShowErrorMessageInvoiceEvent) {
        emit(ShowErrorMessageInvoiceSatae(
            message: event.message, padding: event.padding));
      } else if (event is AddItemBillEvent) {
        emit(AddItemToBill(bill: event.bill));
      } else if (event is ExportInvoiceEvent) {
        // print("products=>${event.bills}");
        billsDone = [];
        // emit(StartExportInvoiceState());
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
      } else if (event is UploadInvoiceEvent) {
        //event upload invoice
        result = await uploadInVoice(event.fullPath, event.billHolder);
        result.fold(
            (l) => ErrorDuringUploadState(
                  message: "اثناء تحميل الفاتورة " + mapError(l),
                ),
            (r) => emit(FinshExportInvoiceState()));
      }
    });
  }

  static InvoiceBloc get(BuildContext context) =>
      BlocProvider.of<InvoiceBloc>(context);
}
