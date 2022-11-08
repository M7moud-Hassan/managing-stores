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

class OpenDrawerEvent extends DataMarketEvent {}

class CloseDrawerEvent extends DataMarketEvent {
  final Catalogue selectedCatalogue;
  const CloseDrawerEvent({required this.selectedCatalogue});
  @override
  List<Object> get props => [selectedCatalogue];
}

class SelectCatalogueEvent extends DataMarketEvent {
  final Catalogue catalogue;
  const SelectCatalogueEvent({
    required this.catalogue,
  });
  @override
  List<Object> get props => [catalogue];
}
