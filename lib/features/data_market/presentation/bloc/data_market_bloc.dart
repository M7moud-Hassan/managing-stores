import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:mustafa/core/error/failures.dart';
import 'package:mustafa/core/strings/failures.dart';
import 'package:mustafa/features/data_market/domain/entities/item.dart';
import 'package:mustafa/features/data_market/domain/usecases/inser_item.dart';
import 'package:mustafa/features/data_market/domain/usecases/update_item.dart';

import '../../domain/usecases/delete_item.dart';
import '../../domain/usecases/get_all_items.dart';

part 'data_market_event.dart';
part 'data_market_state.dart';

class DataMarketBloc extends Bloc<DataMarketEvent, DataMarketState> {
  final InsertItem insertItem;
  final UpdateItem updateItem;
  final ItemDelete itemDelete;
  final GetAllItems getAllItems;
  DataMarketBloc({
    required this.insertItem,
    required this.updateItem,
    required this.itemDelete,
    required this.getAllItems,
  }) : super(DataMarketInitial()) {
    on<DataMarketEvent>((event, emit) async {
      Either result;
      if (event is AddItemEvent) {
        result = await insertItem(event.item);
        result.fold((l) => emit(ErrorMessageState(message: _mapError(l))),
            (r) => emit(AddItemState()));
      } else if (event is DeleteItemEvent) {
        result = await itemDelete(event.item);
        result.fold((l) => emit(ErrorMessageState(message: _mapError(l))),
            (r) => emit(DeleteItemState()));
      } else if (event is UpdateItemEvent) {
        result = await updateItem(event.item);
        result.fold((l) => emit(ErrorMessageState(message: _mapError(l))),
            (r) => emit(UpdateItemState()));
      } else if (event is GetAllItemsEvent) {
        result = await getAllItems(event.catalogue);
        result.fold((l) => emit(ErrorMessageState(message: _mapError(l))),
            (r) => emit(GetAllItemsState(items: r)));
      }
    });
  }

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
