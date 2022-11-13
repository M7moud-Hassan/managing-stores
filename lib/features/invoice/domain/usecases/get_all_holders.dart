import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/bill_holder.dart';
import '../repositories/invoice_repo.dart';

class GetAllBillHolderUseCase {
  final InvoiceRepo invoiceRepo;

  const GetAllBillHolderUseCase({required this.invoiceRepo});

  Future<Either<Failure, List<BillHolder>>> call() =>
      invoiceRepo.getAllBillHolders();
}
