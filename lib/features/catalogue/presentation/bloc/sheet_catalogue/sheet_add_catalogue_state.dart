part of 'sheet_add_catalogue_bloc.dart';

abstract class SheetAddCatalogueState extends Equatable {
  const SheetAddCatalogueState();

  @override
  List<Object> get props => [];
}

class SheetAddCatalogueInitial extends SheetAddCatalogueState {}

class ChangeLengthTextState extends SheetAddCatalogueState {
  final int length;
  const ChangeLengthTextState({required this.length});
  @override
  List<Object> get props => [length];
}
