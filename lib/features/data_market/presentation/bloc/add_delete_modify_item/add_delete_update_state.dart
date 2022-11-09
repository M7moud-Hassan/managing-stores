part of 'add_delete_update_bloc.dart';

abstract class AddDeleteUpdateState extends Equatable {
  const AddDeleteUpdateState();
  @override
  List<Object> get props => [];
}

class DataMarketInitial extends AddDeleteUpdateState {}

class AddedItemState extends AddDeleteUpdateState {}

class LoadAddedItemState extends AddDeleteUpdateState {}

class DeleteItemState extends AddDeleteUpdateState {}

class UpdateItemState extends AddDeleteUpdateState {}

class ErrorMessageStateAdd extends AddDeleteUpdateState {
  final String message;
  const ErrorMessageStateAdd({required this.message});
  @override
  List<Object> get props => [message];
}
