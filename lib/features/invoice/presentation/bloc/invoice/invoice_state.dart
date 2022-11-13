part of 'invoice_bloc.dart';

abstract class InvoiceState extends Equatable {
  const InvoiceState();

  @override
  List<Object> get props => [];
}

class InvoiceInitial extends InvoiceState {}

class ShowErrorMessageInvoiceSatae extends InvoiceState {
  final String message;
  final double padding;

  const ShowErrorMessageInvoiceSatae({
    required this.message,
    required this.padding,
  });
  @override
  List<Object> get props => [message, padding];
}

class FinshExportInvoice extends InvoiceState {}

class StartExportInvoiceState extends InvoiceState {}

class ExportInvoiceState extends InvoiceState {
  final List<Bill> billsDone;

  const ExportInvoiceState({required this.billsDone});
  @override
  List<Object> get props => [billsDone];
}

class AddItemToBill extends InvoiceState {
  final Bill bill;

  const AddItemToBill({required this.bill});
  @override
  List<Object> get props => [bill];
}
