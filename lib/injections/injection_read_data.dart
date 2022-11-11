import 'package:mustafa/features/invoice/data/datasources/data_remote.dart';
import 'package:mustafa/features/invoice/data/repositories/invoice_data_imp.dart';
import 'package:mustafa/features/invoice/domain/repositories/invoice_repo.dart';
import 'package:mustafa/features/invoice/domain/usecases/read_data_usercase.dart';
import 'package:mustafa/features/invoice/presentation/bloc/add_item_invoice/add_item_invoice_bloc.dart';
import 'package:mustafa/injections/injection_mark_data.dart';

Future<void> init() async {
  //! Features - readData
// Bloc
  sl.registerFactory(() => AddItemInvoiceBloc(readData: sl()));

// Usecases
  sl.registerLazySingleton(() => ReadData(invoiceRepo: sl()));
// Repository
  sl.registerLazySingleton<InvoiceRepo>(() => InvoiceDataImp(dataRemote: sl()));
// Datasources
  sl.registerLazySingleton<DataRemote>(
      () => DataRemoteImp(firebaseFirestore: sl(), networkInfo: sl()));
}
