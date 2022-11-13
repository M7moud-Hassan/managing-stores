import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mustafa/core/methods/app_util.dart';
import 'package:mustafa/core/methods/map_failure_string.dart';
import 'package:mustafa/features/invoice/domain/entities/bill_holder.dart';
import 'package:mustafa/features/invoice/domain/usecases/download_invoice_uc.dart';

part 'download_invoice_event.dart';
part 'download_invoice_state.dart';

class DownloadInvoiceBloc
    extends Bloc<DownloadInvoiceEvent, DownloadInvoiceState> {
  DownloadInvoiceUs downloadInvoiceUs;
  late Either result;
  DownloadInvoiceBloc({required this.downloadInvoiceUs})
      : super(DownloadInvoiceInitial()) {
    on<DownloadInvoiceEvent>((event, emit) async {
      if (event is StartDownloadInVoiceEvent) {
        emit(StartDownloadInVoiceState(billHolderDownload: event.billHolder));
        result =
            await downloadInvoiceUs(await AppUtil.getPath(), event.billHolder);
        result.fold(
            (l) => emit(SendErrorToShowAllBillsState(message: mapError(l))),
            (r) => emit(DoneDownloadState()));
      }
    });
  }
  static DownloadInvoiceBloc get(BuildContext context) =>
      BlocProvider.of<DownloadInvoiceBloc>(context);
}
