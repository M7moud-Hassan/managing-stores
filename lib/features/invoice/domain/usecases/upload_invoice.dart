import 'package:dartz/dartz.dart';
import 'package:mustafa/features/invoice/domain/entities/bill_holder.dart';

import '../../../../core/error/failures.dart';
import '../repositories/invoice_repo.dart';

//upload invoice after extract
class UploadInVoice {
  final InvoiceRepo invoiceRepo;

  const UploadInVoice({required this.invoiceRepo});
  Future<Either<Failure, Unit>> call(String path, BillHolder billHolder) =>
      invoiceRepo.uploadInvoice(path, billHolder);
}
