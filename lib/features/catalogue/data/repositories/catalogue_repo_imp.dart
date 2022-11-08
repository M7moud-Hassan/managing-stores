import 'package:mustafa/core/error/exceptions.dart';
import 'package:mustafa/features/catalogue/data/datasources/local_data_catalogues.dart';
import 'package:mustafa/features/catalogue/data/models/model_catalogue.dart';
import 'package:mustafa/features/catalogue/domain/entities/catalogue.dart';
import 'package:mustafa/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:mustafa/features/catalogue/domain/repositories/catalogue_repo.dart';

class CatalogueRepoImp implements CatalogueRepo {
  final LocalDataCatalogue localDataCatalogue;

  CatalogueRepoImp({required this.localDataCatalogue});

  @override
  Future<Either<Failure, Unit>> addCatalogue(Catalogue catalogue) async {
    try {
      return Right(await localDataCatalogue
          .add(ModelCatalogue(name: catalogue.name, id: catalogue.id)));
    } on CatalogueIsExitsException {
      return Left(CatalogueExitsFailure());
    } on OfflineException {
      return Left(OfflineFailure());
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<Catalogue>>> getCatalogues() async {
    try {
      return Right(await localDataCatalogue.getAll());
    } on OfflineException {
      return Left(OfflineFailure());
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> renameCatalogue(Catalogue catalogue) async {
    try {
      return Right(await localDataCatalogue
          .reName(ModelCatalogue(name: catalogue.name, id: catalogue.id)));
    } on OfflineException {
      return Left(OfflineFailure());
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteCatalogue(Catalogue catalogue) async {
    try {
      return Right(await localDataCatalogue
          .delete(ModelCatalogue(name: catalogue.name, id: catalogue.id)));
    } on OfflineException {
      return Left(OfflineFailure());
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
