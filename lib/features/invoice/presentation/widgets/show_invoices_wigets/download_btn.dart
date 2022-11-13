import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mustafa/core/methods/app_util.dart';
import 'package:mustafa/core/themes/app_theme.dart';
import 'package:mustafa/features/invoice/domain/entities/bill_holder.dart';
import 'package:mustafa/features/invoice/presentation/bloc/download_invoice/download_invoice_bloc.dart';
import 'package:mustafa/features/invoice/presentation/bloc/show_all_invoices/show_all_invoices_bloc.dart';
import 'package:open_file/open_file.dart';

class DownloadBtnWidget extends StatelessWidget {
  const DownloadBtnWidget(
      {super.key, required this.path, required this.billHolder});
  final String path;
  final BillHolder billHolder;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DownloadInvoiceBloc, DownloadInvoiceState>(
      builder: (context, state) {
        if (state is StartDownloadInVoiceState) {
          if (billHolder == state.billHolderDownload)
            return SizedBox(
              width: 30,
              height: 30,
              child: const CircularProgressIndicator(),
            );
        } else if (state is SendErrorToShowAllBillsState) {
          ShowAllInvoicesBloc.get(context)
              .emit(ShowErrorGellBillsState(message: state.message));
        }
        return IconButton(
            onPressed: () async {
              if (!AppUtil.checkInvoiceExits(path)) {
                DownloadInvoiceBloc.get(context)
                    .add(StartDownloadInVoiceEvent(billHolder: billHolder));
              } else {
                try {
                  await OpenFile.open(path);
                } catch (e) {}
              }
            },
            icon: Icon(
              !AppUtil.checkInvoiceExits(path)
                  ? Icons.download_for_offline_outlined
                  : Icons.open_in_browser,
              color: primaryColor,
            ));
      },
    );
  }
}
