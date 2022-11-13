import 'package:mustafa/features/invoice/data/datasources/data_remote.dart';
import 'package:mustafa/features/invoice/data/repositories/invoice_data_imp.dart';
import 'package:mustafa/features/invoice/domain/repositories/invoice_repo.dart';
import 'package:mustafa/features/invoice/domain/usecases/download_invoice_uc.dart';
import 'package:mustafa/features/invoice/domain/usecases/get_all_holders.dart';
import 'package:mustafa/features/invoice/domain/usecases/read_data_usercase.dart';
import 'package:mustafa/features/invoice/domain/usecases/upload_invoice.dart';
import 'package:mustafa/features/invoice/presentation/bloc/add_item_invoice/add_item_invoice_bloc.dart';
import 'package:mustafa/injections/injection_mark_data.dart';

import '../features/invoice/presentation/bloc/download_invoice/download_invoice_bloc.dart';
import '../features/invoice/presentation/bloc/invoice/invoice_bloc.dart';
import '../features/invoice/presentation/bloc/show_all_invoices/show_all_invoices_bloc.dart';

Future<void> init() async {
  //! Features - readData
// Bloc
  sl.registerFactory(() => AddItemInvoiceBloc(readData: sl()));
  sl.registerFactory(
      () => InvoiceBloc(updateForInvoiceUserCase: sl(), uploadInVoice: sl()));
  sl.registerFactory(() => ShowAllInvoicesBloc(getAllBillHolderUseCase: sl()));
  sl.registerFactory(() => DownloadInvoiceBloc(downloadInvoiceUs: sl()));

// Usecases
  sl.registerLazySingleton(() => ReadData(invoiceRepo: sl()));
  sl.registerLazySingleton(() => UploadInVoice(invoiceRepo: sl()));
  sl.registerLazySingleton(() => GetAllBillHolderUseCase(invoiceRepo: sl()));
  sl.registerLazySingleton(() => DownloadInvoiceUs(invoiceRepo: sl()));
// Repository
  sl.registerLazySingleton<InvoiceRepo>(() => InvoiceDataImp(dataRemote: sl()));
// Datasources
  sl.registerLazySingleton<DataRemote>(() => DataRemoteImp(
      firebaseFirestore: sl(), networkInfo: sl(), firebaseStorage: sl()));
}
