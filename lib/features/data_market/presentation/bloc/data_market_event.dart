part of 'data_market_bloc.dart';

abstract class DataMarketEvent extends Equatable {
  const DataMarketEvent();

  @override
  List<Object> get props => [];
}

class AddItemEvent extends DataMarketEvent {
  final Item item;
  const AddItemEvent({required this.item});
}

class DeleteItemEvent extends DataMarketEvent {
  final Item item;
  const DeleteItemEvent({required this.item});
}

class UpdateItemEvent extends DataMarketEvent {
  final Item item;
  const UpdateItemEvent({required this.item});
}

class GetAllItemsEvent extends DataMarketEvent {
  final String catalogue;
  const GetAllItemsEvent({required this.catalogue});
}
