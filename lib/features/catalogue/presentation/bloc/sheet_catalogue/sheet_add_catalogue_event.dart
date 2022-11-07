part of 'sheet_add_catalogue_bloc.dart';

abstract class SheetAddCatalogueEvent extends Equatable {
  const SheetAddCatalogueEvent();
  @override
  List<Object> get props => [];
}

class ChangeLengthTextEvent extends SheetAddCatalogueEvent {
  final int length;
  const ChangeLengthTextEvent({required this.length});
  @override
  List<Object> get props => [length];
}
