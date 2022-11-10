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
  final BuildContext context;
  const DeleteItemEvent({
    required this.item,
    required this.context,
  });
  @override
  List<Object> get props => [item, context];
}

class UpdateItemEvent extends AddDeleteUpdateEvent {
  final Item item;
  const UpdateItemEvent({required this.item});
  @override
  List<Object> get props => [item];
}
