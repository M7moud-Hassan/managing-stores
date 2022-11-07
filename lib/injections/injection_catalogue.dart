import 'package:mustafa/features/catalogue/data/datasources/local_data_catalogues.dart';
import 'package:mustafa/features/catalogue/data/repositories/catalogue_repo_imp.dart';
import 'package:mustafa/features/catalogue/domain/repositories/catalogue_repo.dart';
import 'package:mustafa/features/catalogue/domain/usecases/add_catalogue.dart';
import 'package:mustafa/features/catalogue/domain/usecases/delete_catalogue_usecase.dart';
import 'package:mustafa/features/catalogue/domain/usecases/get_all_catalogues.dart';
import 'package:mustafa/features/catalogue/domain/usecases/rename_catalogue.dart';
import 'package:mustafa/injections/injection_mark_data.dart';

import '../features/catalogue/presentation/bloc/catalogue_add/catalogue_bloc.dart';

Future<void> init() async {
  //! Features - store
// Bloc
  sl.registerFactory(() => CatalogueBloc(
      addCatalogueUseCase: sl(),
      getCataloguesUseCase: sl(),
      renameCatalogue: sl(),
      deleteCatalogue: sl()));
// Usecases
  sl.registerLazySingleton(() => AddCatalogueUseCase(catalogueRepo: sl()));
  sl.registerLazySingleton(() => GetCataloguesUseCase(catalogueRepo: sl()));
  sl.registerLazySingleton(() => RenameCatalogue(catalogueRepo: sl()));
  sl.registerLazySingleton(() => DeleteCatalogue(catalogueRepo: sl()));
// Repository
  sl.registerLazySingleton<CatalogueRepo>(
      () => CatalogueRepoImp(localDataCatalogue: sl()));
// Datasources
  sl.registerLazySingleton<LocalDataCatalogue>(
      () => LocalDataCatalogueImp(firebaseFirestore: sl(), networkInfo: sl()));
}
