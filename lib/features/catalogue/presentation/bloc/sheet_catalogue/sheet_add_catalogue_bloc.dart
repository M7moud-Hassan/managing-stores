import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'sheet_add_catalogue_event.dart';
part 'sheet_add_catalogue_state.dart';

class SheetAddCatalogueBloc
    extends Bloc<SheetAddCatalogueEvent, SheetAddCatalogueState> {
  SheetAddCatalogueBloc() : super(SheetAddCatalogueInitial()) {
    on<SheetAddCatalogueEvent>((event, emit) {
      if (event is ChangeLengthTextEvent) {
        emit(ChangeLengthTextState(length: event.length));
      }
    });
  }

  static SheetAddCatalogueBloc get(context) =>
      BlocProvider.of<SheetAddCatalogueBloc>(context);
}
