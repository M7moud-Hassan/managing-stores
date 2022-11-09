part of 'data_market_bloc.dart';

abstract class DataMarketEvent extends Equatable {
  const DataMarketEvent();

  @override
  List<Object> get props => [];
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

class ShowMessageEvent extends DataMarketEvent {
  final String message;
  final bool isError;

  const ShowMessageEvent({required this.message, required this.isError});
  @override
  List<Object> get props => [message, isError];
}

class GetItemsEvent extends DataMarketEvent {
  final Catalogue catalogue;
  const GetItemsEvent({required this.catalogue});
  @override
  List<Object> get props => [catalogue];
}
