part of 'data_market_bloc.dart';

abstract class DataMarketState extends Equatable {
  const DataMarketState();

  @override
  List<Object> get props => [];
}

class DataMarketInitial extends DataMarketState {}

class AddItemState extends DataMarketState {}

class DeleteItemState extends DataMarketState {}

class UpdateItemState extends DataMarketState {}

class GetAllItemsState extends DataMarketState {
  final List<Item> items;
  const GetAllItemsState({required this.items});
}

class ErrorMessageState extends DataMarketState {
  final String message;
  const ErrorMessageState({required this.message});
}

class OpenDrawerState extends DataMarketState {}

class CloseDrawerState extends DataMarketState {
  final Catalogue selectedCatalogue;
  const CloseDrawerState({required this.selectedCatalogue});
  @override
  List<Object> get props => [selectedCatalogue];
}
