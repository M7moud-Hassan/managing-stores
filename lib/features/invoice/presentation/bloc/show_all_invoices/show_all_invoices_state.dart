part of 'show_all_invoices_bloc.dart';

abstract class ShowAllInvoicesState extends Equatable {
  const ShowAllInvoicesState();

  @override
  List<Object> get props => [];
}

class ShowAllInvoicesInitial extends ShowAllInvoicesState {}

class GettAllBillHoldersStete extends ShowAllInvoicesState {
  final List<BillHolder> billHolders;

  const GettAllBillHoldersStete({required this.billHolders});
  @override
  List<Object> get props => [billHolders];
}

class StartGetAllBillHoldersState extends ShowAllInvoicesState {}

class ShowErrorGellBillsState extends ShowAllInvoicesState {
  final String message;

  const ShowErrorGellBillsState({required this.message});
  @override
  List<Object> get props => [message];
}

class StartFilterByDateState extends ShowAllInvoicesState {
  final PickerDateRange pickerDateRange;

  const StartFilterByDateState({required this.pickerDateRange});

  @override
  List<Object> get props => [pickerDateRange];
}
