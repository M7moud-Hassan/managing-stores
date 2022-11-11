import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mustafa/core/methods/map_failure_string.dart';
import 'package:mustafa/features/invoice/domain/entities/catalogue_data.dart';

import '../../../domain/usecases/read_data_usercase.dart';

part 'add_item_invoice_event.dart';
part 'add_item_invoice_state.dart';

class AddItemInvoiceBloc
    extends Bloc<AddItemInvoiceEvent, AddItemInvoiceState> {
  final ReadData readData;
  late Either either;
  AddItemInvoiceBloc({required this.readData})
      : super(AddItemInvoiceInitial()) {
    on<AddItemInvoiceEvent>((event, emit) async {
      if (event is ReadDataEvent) {
        emit(StartReadDataState());
        either = await readData();
        either.fold((l) => emit(SendErrorMessageSatae(message: mapError(l))),
            (r) => emit(ReadedDataState(data: r)));
      } else if (event is ShowErrorMessageAddItemInvoiceEvent) {
        emit(SendErrorMessageSatae(message: event.message));
      }
    });
  }
  static AddItemInvoiceBloc get(BuildContext context) =>
      BlocProvider.of<AddItemInvoiceBloc>(context);
}
