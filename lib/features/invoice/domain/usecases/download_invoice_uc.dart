import 'package:dartz/dartz.dart';
import 'package:mustafa/features/invoice/domain/entities/bill_holder.dart';

import '../../../../core/error/failures.dart';
import '../repositories/invoice_repo.dart';

class DownloadInvoiceUs {
  final InvoiceRepo invoiceRepo;

  const DownloadInvoiceUs({required this.invoiceRepo});

  Future<Either<Failure, Unit>> call(String path, BillHolder billHolder) =>
      invoiceRepo.downloadInvoice(path, billHolder);
}
