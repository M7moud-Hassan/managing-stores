part of 'add_delete_update_bloc.dart';

abstract class AddDeleteUpdateEvent extends Equatable {
  const AddDeleteUpdateEvent();

  @override
  List<Object> get props => [];
}

class AddItemEvent extends AddDeleteUpdateEvent {
  final Item item;
  const AddItemEvent({required this.item});
  @override
  List<Object> get props => [item];
}

class DeleteItemEvent extends AddDeleteUpdateEvent {
  final Item item;
  const DeleteItemEvent({required this.item});
}

class UpdateItemEvent extends AddDeleteUpdateEvent {
  final Item item;
  const UpdateItemEvent({required this.item});
}
