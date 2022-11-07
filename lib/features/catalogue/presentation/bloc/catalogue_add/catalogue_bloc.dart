import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mustafa/core/strings/failures.dart';
import 'package:mustafa/features/catalogue/domain/entities/catalogue.dart';
import 'package:mustafa/features/catalogue/domain/usecases/add_catalogue.dart';
import 'package:mustafa/features/catalogue/domain/usecases/delete_catalogue_usecase.dart';
import 'package:mustafa/features/catalogue/domain/usecases/get_all_catalogues.dart';
import 'package:mustafa/features/catalogue/domain/usecases/rename_catalogue.dart';

import '../../../../../core/error/failures.dart';

part 'catalogue_event.dart';
part 'catalogue_state.dart';

class CatalogueBloc extends Bloc<CatalogueEvent, CatalogueState> {
  final AddCatalogueUseCase addCatalogueUseCase;
  final GetCataloguesUseCase getCataloguesUseCase;
  final RenameCatalogue renameCatalogue;
  final DeleteCatalogue deleteCatalogue;
  CatalogueBloc({
    required this.addCatalogueUseCase,
    required this.getCataloguesUseCase,
    required this.renameCatalogue,
    required this.deleteCatalogue,
  }) : super(CatalogueInitial()) {
    on<CatalogueEvent>((event, emit) async {
      Either result;
      if (event is AddCatalogueEvent) {
        result = await addCatalogueUseCase(event.catalogue);
        result.fold((l) => emit(MessageErrorState(massage: _mapError(l))),
            (r) => emit(AddedCatalogueState()));
      } else if (event is GetCatalougesEvent) {
        result = await getCataloguesUseCase();
        result.fold((l) => emit(MessageErrorState(massage: _mapError(l))),
            (r) => emit(GetedCataloguesState(catalogues: r)));
      } else if (event is RepairNameCatalogueEvent) {
        result = await renameCatalogue(event.catalogue);
        result.fold((l) => emit(MessageErrorState(massage: _mapError(l))),
            (r) => emit(AddedCatalogueState()));
      } else if (event is DeleteCatalogueEvent) {
        result = await deleteCatalogue(event.catalogue);
        result.fold((l) => emit(MessageErrorState(massage: _mapError(l))),
            (r) => emit(AddedCatalogueState()));
      }
    });
  }
  static CatalogueBloc get(context) => BlocProvider.of<CatalogueBloc>(context);
  String _mapError(Failure failure) {
    switch (failure.runtimeType) {
      case OfflineFailure:
        return OFFLINE_FAILURE_MESSAGE;
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      default:
        return SERVER_FAILURE_MESSAGE;
    }
  }
}