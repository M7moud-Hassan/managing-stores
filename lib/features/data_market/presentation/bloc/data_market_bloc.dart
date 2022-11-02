import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'data_market_event.dart';
part 'data_market_state.dart';

class DataMarketBloc extends Bloc<DataMarketEvent, DataMarketState> {
  DataMarketBloc() : super(DataMarketInitial()) {
    on<DataMarketEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
