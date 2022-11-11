part of 'invoice_bloc.dart';

abstract class InvoiceEvent extends Equatable {
  const InvoiceEvent();

  @override
  List<Object> get props => [];
}

class ShowErrorMessageInvoiceEvent extends InvoiceEvent {
  final double padding;
  final String message;

  const ShowErrorMessageInvoiceEvent({
    required this.message,
    required this.padding,
  });
  @override
  List<Object> get props => [message, padding];
}

class AddItemBillEvent extends InvoiceEvent {
  final Bill bill;

  const AddItemBillEvent({required this.bill});
  @override
  List<Object> get props => [bill];
}
