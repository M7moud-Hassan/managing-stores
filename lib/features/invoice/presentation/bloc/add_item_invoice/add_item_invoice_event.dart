part of 'add_item_invoice_bloc.dart';

abstract class AddItemInvoiceEvent extends Equatable {
  const AddItemInvoiceEvent();

  @override
  List<Object> get props => [];
}

class ReadDataEvent extends AddItemInvoiceEvent {}

class ShowErrorMessageAddItemInvoiceEvent extends AddItemInvoiceEvent {
  final String message;

  const ShowErrorMessageAddItemInvoiceEvent({required this.message});
  @override
  List<Object> get props => [message];
}
