part of 'catalogue_bloc.dart';

abstract class CatalogueState extends Equatable {
  const CatalogueState();

  @override
  List<Object> get props => [];
}

class CatalogueInitial extends CatalogueState {}

class AddedCatalogueState extends CatalogueState {}

class MessageErrorState extends CatalogueState {
  final String massage;
  const MessageErrorState({required this.massage});
}

class GetedCataloguesState extends CatalogueState {
  final List<Catalogue> catalogues;
  const GetedCataloguesState({required this.catalogues});
}
