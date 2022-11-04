import 'package:dartz/dartz.dart';
import 'package:mustafa/features/catalogue/domain/entities/catalogue.dart';
import 'package:mustafa/features/catalogue/domain/repositories/catalogue_repo.dart';

import '../../../../core/error/failures.dart';

class AddCatalogueUseCase {
  final CatalogueRepo catalogueRepo;
  AddCatalogueUseCase({required this.catalogueRepo});
  Future<Either<Failure, Unit>> call(Catalogue catalogue) =>
      catalogueRepo.addCatalogue(catalogue);
}
