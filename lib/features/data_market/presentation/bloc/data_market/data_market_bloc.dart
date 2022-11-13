import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../catalogue/domain/entities/catalogue.dart';
import '../../../domain/entities/item.dart';

part 'data_market_event.dart';
part 'data_market_state.dart';

class DataMarketBloc extends Bloc<DataMarketEvent, DataMarketState> {
  DataMarketBloc() : super(DataMarketInitial()) {
    on<DataMarketEvent>((event, emit) async {
      if (event is SelectCatalogueEvent) {
        emit(CloseDrawerState(selectedCatalogue: event.catalogue));
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
      }
    });
  }

  static DataMarketBloc get(context) =>
      BlocProvider.of<DataMarketBloc>(context);
}
