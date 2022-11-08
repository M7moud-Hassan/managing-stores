part of 'catalogue_bloc.dart';

abstract class CatalogueState extends Equatable {
  const CatalogueState();

  @override
  List<Object> get props => [];
}

class CatalogueInitial extends CatalogueState {}

class AddedCatalogueState extends CatalogueState {
  final String message;

  const AddedCatalogueState({required this.message});
}

class MessageErrorState extends CatalogueState {
  final String massage;
  const MessageErrorState({required this.massage});
  @override
  List<Object> get props => [massage];
}

class GetedCataloguesState extends CatalogueState {
  final List<Catalogue> catalogues;
  const GetedCataloguesState({required this.catalogues});
  @override
  List<Object> get props => [catalogues];
}

class LoadingCataloguesState extends CatalogueState {
  final Catalogue changeIdSelected;
  final bool changeId;
  const LoadingCataloguesState({
    required this.changeIdSelected,
    required this.changeId,
  });
  @override
  List<Object> get props => [changeIdSelected, changeId];
}

class FilterCataloguesState extends CatalogueState {
  final List<Catalogue> catalogues;
  const FilterCataloguesState({required this.catalogues});
  @override
  List<Object> get props => [catalogues];
}
