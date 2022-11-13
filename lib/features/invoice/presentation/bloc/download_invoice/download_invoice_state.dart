part of 'download_invoice_bloc.dart';

abstract class DownloadInvoiceState extends Equatable {
  const DownloadInvoiceState();

  @override
  List<Object> get props => [];
}

class DownloadInvoiceInitial extends DownloadInvoiceState {}

class StartDownloadInVoiceState extends DownloadInvoiceState {
  final BillHolder billHolderDownload;

  const StartDownloadInVoiceState({required this.billHolderDownload});
  @override
  List<Object> get props => [];
}

class DoneDownloadState extends DownloadInvoiceState {}

class SendErrorToShowAllBillsState extends DownloadInvoiceState {
  final String message;

  const SendErrorToShowAllBillsState({required this.message});
}
