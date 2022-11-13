import 'package:dartz/dartz.dart';
import 'package:mustafa/core/error/failures.dart';
import 'package:mustafa/features/invoice/domain/entities/bill_holder.dart';
import 'package:mustafa/features/invoice/domain/entities/catalogue_data.dart';

abstract class InvoiceRepo {
  Future<Either<Failure, List<CatalogueData>>> readData();
  Future<Either<Failure, Unit>> uploadInvoice(
      String path, BillHolder billHolder);
  Future<Either<Failure, List<BillHolder>>> getAllBillHolders();
  Future<Either<Failure, Unit>> downloadInvoice(
      String path, BillHolder billHolder);
}
