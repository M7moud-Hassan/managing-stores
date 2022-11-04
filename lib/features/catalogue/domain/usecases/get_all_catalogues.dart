import 'package:dartz/dartz.dart';
import 'package:mustafa/features/catalogue/domain/repositories/catalogue_repo.dart';

import '../../../../core/error/failures.dart';
import '../entities/catalogue.dart';

class GetCataloguesUseCase {
  final CatalogueRepo catalogueRepo;

  GetCataloguesUseCase({required this.catalogueRepo});
  Future<Either<Failure, List<Catalogue>>> call() =>
      catalogueRepo.getCatalogues();
}
