import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mustafa/core/network/network_info.dart';
import 'package:mustafa/features/data_market/data/datasources/remote_data.dart';
import 'package:mustafa/features/data_market/data/repositories/item_repo_imp.dart';
import 'package:mustafa/features/data_market/domain/repositories/item_repo.dart';
import 'package:mustafa/features/data_market/domain/usecases/delete_item.dart';
import 'package:mustafa/features/data_market/domain/usecases/get_all_items.dart';
import 'package:mustafa/features/data_market/domain/usecases/inser_item.dart';
import 'package:mustafa/features/data_market/domain/usecases/update_item.dart';
import 'package:mustafa/features/data_market/presentation/bloc/data_market_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features - store
// Bloc
  sl.registerFactory(() => DataMarketBloc(
      insertItem: sl(), updateItem: sl(), itemDelete: sl(), getAllItems: sl()));
// Usecases
  sl.registerLazySingleton(() => InsertItem(itemRepo: sl()));
  sl.registerLazySingleton(() => UpdateItem(itemRepo: sl()));
  sl.registerLazySingleton(() => ItemDelete(itemRepo: sl()));
  sl.registerLazySingleton(() => GetAllItems(itemRepo: sl()));
// Repository

  sl.registerLazySingleton<ItemRepo>(() => ItemRepoImp(itemRemoteData: sl()));

// Datasources

  sl.registerLazySingleton<ItemRemoteData>(
      () => ItemRemoteDataImp(firebaseFirestore: sl(), networkInfo: sl()));

//! Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
//! External
  sl.registerLazySingleton(() => InternetConnectionChecker());
  sl.registerLazySingleton(() => FirebaseFirestore.instance);
}
