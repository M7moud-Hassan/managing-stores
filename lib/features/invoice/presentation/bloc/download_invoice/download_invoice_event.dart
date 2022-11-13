part of 'download_invoice_bloc.dart';

abstract class DownloadInvoiceEvent extends Equatable {
  const DownloadInvoiceEvent();

  @override
  List<Object> get props => [];
}

class StartDownloadInVoiceEvent extends DownloadInvoiceEvent {
  final BillHolder billHolder;
  const StartDownloadInVoiceEvent({required this.billHolder});
  @override
  List<Object> get props => [billHolder];
}
