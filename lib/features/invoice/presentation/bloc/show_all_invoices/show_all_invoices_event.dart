part of 'show_all_invoices_bloc.dart';

abstract class ShowAllInvoicesEvent extends Equatable {
  const ShowAllInvoicesEvent();

  @override
  List<Object> get props => [];
}

class GettAllBillHoldersEvent extends ShowAllInvoicesEvent {}

class StartFilterByDateEvent extends ShowAllInvoicesEvent {
  final PickerDateRange pickerDateRange;

  const StartFilterByDateEvent({required this.pickerDateRange});

  @override
  List<Object> get props => [pickerDateRange];
}
