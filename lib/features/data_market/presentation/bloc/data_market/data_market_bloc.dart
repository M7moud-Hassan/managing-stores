import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mustafa/features/catalogue/presentation/bloc/catalogue_add/catalogue_bloc.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/strings/failures.dart';
import '../../../../catalogue/domain/entities/catalogue.dart';
import '../../../domain/entities/item.dart';
import '../../../domain/usecases/get_all_items.dart';

part 'data_market_event.dart';
part 'data_market_state.dart';

class DataMarketBloc extends Bloc<DataMarketEvent, DataMarketState> {
  final GetAllItems getAllItems;
  DataMarketBloc({required this.getAllItems}) : super(DataMarketInitial()) {
    on<DataMarketEvent>((event, emit) async {
      Either result;
      if (event is SelectCatalogueEvent) {
        emit(CloseDrawerState(selectedCatalogue: event.catalogue));
        //emit(LoadedItemsDataState());
        result = await getAllItems(event.catalogue.id);
        result.fold((l) => emit(ErrorMessageState(message: _mapError(l))),
            (r) => emit(GetAllItemsState(items: r)));
      } else if (event is OpenDrawerEvent) {
        emit(OpenDrawerState());
      } else if (event is CloseDrawerEvent) {
        emit(CloseDrawerState(selectedCatalogue: event.selectedCatalogue));
      } else if (event is ShowMessageEvent) {
        if (event.isError) {
          emit(ErrorMessageState(message: event.message));
        } else {
          emit(ShowMessageSuccefulState(message: event.message));
        }
      } else if (event is GetItemsEvent) {
        //emit(LoadedItemsState());
        result = await getAllItems(event.catalogue.id);
        result.fold((l) => emit(ErrorMessageState(message: _mapError(l))),
            (r) => emit(GetAllItemsState(items: r)));
      }
    });
  }

  static DataMarketBloc get(context) =>
      BlocProvider.of<DataMarketBloc>(context);

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
