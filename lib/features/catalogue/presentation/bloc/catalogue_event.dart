part of 'catalogue_bloc.dart';

abstract class CatalogueEvent extends Equatable {
  const CatalogueEvent();

  @override
  List<Object> get props => [];
}

class AddCatalogueEvent extends CatalogueEvent {
  final Catalogue catalogue;
  const AddCatalogueEvent({required this.catalogue});
}

class GetCatalougesEvent extends CatalogueEvent {}
