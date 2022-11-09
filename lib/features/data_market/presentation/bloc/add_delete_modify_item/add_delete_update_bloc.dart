import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mustafa/core/strings/messages.dart';
import 'package:mustafa/features/data_market/domain/usecases/update_item.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/strings/failures.dart';
import '../../../domain/entities/item.dart';
import '../../../domain/usecases/delete_item.dart';
import '../../../domain/usecases/inser_item.dart';
import '../data_market/data_market_bloc.dart';

part 'add_delete_updatet_event.dart';
part 'add_delete_update_state.dart';

class AddDeleteUpdateBloc
    extends Bloc<AddDeleteUpdateEvent, AddDeleteUpdateState> {
  final InsertItem insertItem;
  final UpdateItem updateItem;
  final ItemDelete itemDelete;

  AddDeleteUpdateBloc({
    required this.insertItem,
    required this.updateItem,
    required this.itemDelete,
  }) : super(DataMarketInitial()) {
    on<AddDeleteUpdateEvent>((event, emit) async {
      Either result;
      if (event is AddItemEvent) {
        emit(LoadAddedItemState());
        result = await insertItem(event.item);
        result.fold((l) => emit(ErrorMessageStateAdd(message: _mapError(l))),
            (r) => emit(AddedItemState()));
      } else if (event is DeleteItemEvent) {
        result = await itemDelete(event.item);
        result.fold((l) => emit(ErrorMessageStateAdd(message: _mapError(l))),
            (r) => emit(DeleteItemState()));
      } else if (event is UpdateItemEvent) {
        result = await updateItem(event.item);
        result.fold((l) => emit(ErrorMessageStateAdd(message: _mapError(l))),
            (r) => emit(UpdateItemState()));
      }
    });
  }
  static AddDeleteUpdateBloc get(context) => BlocProvider.of(context);
  String _mapError(Failure failure) {
    switch (failure.runtimeType) {
      case ItemExistsFailure:
        return ITEM_EXITS;
      case OfflineFailure:
        return OFFLINE_FAILURE_MESSAGE;
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      default:
        return SERVER_FAILURE_MESSAGE;
    }
  }
}
