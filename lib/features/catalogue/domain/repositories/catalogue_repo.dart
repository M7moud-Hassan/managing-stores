import 'package:dartz/dartz.dart';
import 'package:mustafa/core/error/failures.dart';
import 'package:mustafa/features/catalogue/domain/entities/catalogue.dart';

abstract class CatalogueRepo {
  Future<Either<Failure, Unit>> addCatalogue(Catalogue catalogue);
  Future<Either<Failure, Unit>> renameCatalogue(Catalogue catalogue);
  Future<Either<Failure, List<Catalogue>>> getCatalogues();
  Future<Either<Failure, Unit>> deleteCatalogue(Catalogue catalogue);
}
