part of 'add_delete_update_bloc.dart';

abstract class AddDeleteUpdateState extends Equatable {
  const AddDeleteUpdateState();
  @override
  List<Object> get props => [];
}

class DataMarketInitial extends AddDeleteUpdateState {}

class AddedItemState extends AddDeleteUpdateState {
  final Item item;

  const AddedItemState({required this.item});
  @override
  List<Object> get props => [item];
}

class LoadAddedItemState extends AddDeleteUpdateState {}

class UpdateItemState extends AddDeleteUpdateState {
  final Item item;

  UpdateItemState({required this.item});
  @override
  List<Object> get props => [item];
}

class ErrorMessageStateAdd extends AddDeleteUpdateState {
  final String message;
  const ErrorMessageStateAdd({required this.message});
  @override
  List<Object> get props => [message];
}

class CloseDialogStata extends AddDeleteUpdateState {}
