import 'package:dartz/dartz.dart';
import 'package:mustafa/core/error/failures.dart';
import 'package:mustafa/features/invoice/domain/entities/catalogue_data.dart';

abstract class InvoiceRepo {
  Future<Either<Failure, List<CatalogueData>>> readData();
}
