import 'package:dartz/dartz.dart';
import 'package:mustafa/features/invoice/domain/repositories/invoice_repo.dart';

import '../../../../core/error/failures.dart';
import '../entities/catalogue_data.dart';

class ReadData {
  final InvoiceRepo invoiceRepo;

  ReadData({required this.invoiceRepo});
  Future<Either<Failure, List<CatalogueData>>> call() => invoiceRepo.readData();
}
