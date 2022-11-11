part of 'add_item_invoice_bloc.dart';

abstract class AddItemInvoiceState extends Equatable {
  const AddItemInvoiceState();

  @override
  List<Object> get props => [];
}

class AddItemInvoiceInitial extends AddItemInvoiceState {}

class StartReadDataState extends AddItemInvoiceState {}

class ReadedDataState extends AddItemInvoiceState {
  final List<CatalogueData> data;

  const ReadedDataState({required this.data});
  @override
  List<Object> get props => [];
}

class SendErrorMessageSatae extends AddItemInvoiceState {
  final String message;

  const SendErrorMessageSatae({required this.message});
  @override
  List<Object> get props => [message];
}
