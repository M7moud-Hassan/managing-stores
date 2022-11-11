import 'package:mustafa/core/error/exceptions.dart';
import 'package:mustafa/features/invoice/data/datasources/data_remote.dart';
import 'package:mustafa/features/invoice/domain/entities/catalogue_data.dart';
import 'package:mustafa/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:mustafa/features/invoice/domain/repositories/invoice_repo.dart';

class InvoiceDataImp implements InvoiceRepo {
  final DataRemote dataRemote;

  InvoiceDataImp({required this.dataRemote});
  @override
  Future<Either<Failure, List<CatalogueData>>> readData() async {
    try {
      return Right(await dataRemote.read());
    } on OfflineException {
      return Left(OfflineFailure());
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
