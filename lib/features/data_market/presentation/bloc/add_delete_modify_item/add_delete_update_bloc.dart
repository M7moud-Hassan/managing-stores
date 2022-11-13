import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mustafa/core/strings/messages.dart';
import 'package:mustafa/features/data_market/domain/usecases/update_item.dart';

import '../../../../../core/methods/map_failure_string.dart';
import '../../../../../core/strings/home_str.dart';
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
        result.fold(
            (l) => emit(ErrorMessageStateAdd(
                message: mapError(l) == ITEM_EXITS
                    ? "${event.item.name} $ITEM_EXITS"
                    : mapError(l))),
            (r) => emit(AddedItemState(item: event.item)));
      } else if (event is DeleteItemEvent) {
        result = await itemDelete(event.item);
        result.fold((l) => emit(ErrorMessageStateAdd(message: mapError(l))),
            (r) {
          DataMarketBloc.get(event.context).add(ShowMessageEvent(
              message: "$DELETED_ITEM ${event.item.name}", isError: false));
        });
      } else if (event is UpdateItemEvent) {
        emit(LoadAddedItemState());
        result = await updateItem(event.item);
        result.fold((l) => emit(ErrorMessageStateAdd(message: mapError(l))),
            (r) => emit(UpdateItemState(item: event.item)));
      } else if (event is CloseDialogEvent) {
        emit(CloseDialogStata());
        Navigator.pop(event.context);
      }
    });
  }
  static AddDeleteUpdateBloc get(context) =>
      BlocProvider.of<AddDeleteUpdateBloc>(context);
}
