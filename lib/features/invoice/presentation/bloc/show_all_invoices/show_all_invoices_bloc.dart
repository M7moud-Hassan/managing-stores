import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mustafa/core/methods/map_failure_string.dart';
import 'package:mustafa/features/invoice/domain/entities/bill_holder.dart';
import 'package:mustafa/features/invoice/domain/usecases/get_all_holders.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

part 'show_all_invoices_event.dart';
part 'show_all_invoices_state.dart';

class ShowAllInvoicesBloc
    extends Bloc<ShowAllInvoicesEvent, ShowAllInvoicesState> {
  GetAllBillHolderUseCase getAllBillHolderUseCase;
  late Either result;
  ShowAllInvoicesBloc({required this.getAllBillHolderUseCase})
      : super(ShowAllInvoicesInitial()) {
    on<ShowAllInvoicesEvent>((event, emit) async {
      if (event is GettAllBillHoldersEvent) {
        emit(StartGetAllBillHoldersState());
        result = await getAllBillHolderUseCase();
        result.fold((l) => emit(ShowErrorGellBillsState(message: mapError(l))),
            (r) => emit(GettAllBillHoldersStete(billHolders: r)));
      } else if (event is StartFilterByDateEvent) {
        emit(StartFilterByDateState(pickerDateRange: event.pickerDateRange));
      }
    });
  }
  static ShowAllInvoicesBloc get(BuildContext context) =>
      BlocProvider.of<ShowAllInvoicesBloc>(context);
}
