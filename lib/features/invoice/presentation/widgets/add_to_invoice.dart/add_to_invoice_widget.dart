import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mustafa/core/strings/home_str.dart';
import 'package:mustafa/core/widgets/loading_widget.dart';
import 'package:mustafa/features/data_market/domain/entities/item.dart';
import 'package:mustafa/features/data_market/presentation/pages/data_grid_view.dart';
import 'package:mustafa/features/data_market/presentation/pages/home_page.dart';
import 'package:mustafa/features/invoice/data/models/model_catalogue_data.dart';
import 'package:mustafa/features/invoice/domain/entities/bill.dart';
import 'package:mustafa/features/invoice/domain/entities/catalogue_data.dart';
import 'package:mustafa/features/invoice/presentation/bloc/invoice/invoice_bloc.dart';

import '../../../../../core/strings/bill_strings.dart';
import '../../../../../core/widgets/divider.dart';
import '../../../../../core/widgets/header_sheet_widget.dart';
import 'package:dropdown_search/dropdown_search.dart';
import '../../bloc/add_item_invoice/add_item_invoice_bloc.dart';

const DEFAULT_CATALOGUE_DATA =
    ModelCatalogueData(name: ALL, id: DEFAULT_ID, item: []);
const double HEIGTH_PADDING = 400;

class AddToInVoice extends StatelessWidget {
  AddToInVoice({super.key}) {
    editingController.text = "0";
    data = [];
    items = [];
  }
  final TextEditingController editingController = TextEditingController();
  late List<CatalogueData> data;
  late List<Item> items;
  final GlobalKey<DropdownSearchState> _dropDownKey =
      GlobalKey<DropdownSearchState>();
  bool load = true;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddItemInvoiceBloc, AddItemInvoiceState>(
      builder: (context, state) {
        if (state is SendErrorMessageSatae) {
          InvoiceBloc.get(context).add(ShowErrorMessageInvoiceEvent(
              message: state.message, padding: HEIGTH_PADDING));
        } else if (state is StartReadDataState) {
          load = true;
        } else if (state is ReadedDataState) {
          load = false;
          data = state.data;
          if (!data.contains(DEFAULT_CATALOGUE_DATA)) {
            data.insert(0, DEFAULT_CATALOGUE_DATA);
          }
        }
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: Column(
                mainAxisSize: MainAxisSize.min,
                children: load
                    ? [const LoadingWidget()]
                    : [
                        headerSheet(
                            ADD_ITEM_INVOCE, context, _addItem(context)),
                        mySizeBox,
                        _dropCatalogueSelect(data),
                        mySizeBox,
                        _dropItemsSelected(items),
                        mySizeBox,
                        _textFieldCount(),
                        mySizeBox
                      ]),
          ),
        );
      },
    );
  }

  Function _addItem(BuildContext context) => () {
        Item? itemSelect = _dropDownKey.currentState!.getSelectedItem;
        String editText = editingController.text;
        if (editingController.text.isNotEmpty && itemSelect != null) {
          try {
            if (int.parse(editText) <= itemSelect.count &&
                int.parse(editText) >= 0) {
              InvoiceBloc.get(context).add(AddItemBillEvent(
                  bill: Bill.add(_dropDownKey.currentState!.getSelectedItem,
                      int.parse(editingController.text))));
              AddItemInvoiceBloc.get(context).add(ReadDataEvent());
            } else {
              AddItemInvoiceBloc.get(context).add(
                  const ShowErrorMessageAddItemInvoiceEvent(
                      message: NOT_CORRECT_NUMBER));
            }
          } catch (e) {
            AddItemInvoiceBloc.get(context).add(
                const ShowErrorMessageAddItemInvoiceEvent(
                    message: TYPE_INPUT_ERROR));
          }
        } else {
          AddItemInvoiceBloc.get(context).add(
              const ShowErrorMessageAddItemInvoiceEvent(message: EMPTY_FIELD));
        }
      };

  Widget _dropCatalogueSelect(List<CatalogueData> catalogues) => Padding(
        padding: const EdgeInsets.all(PADDING),
        child: DropdownSearch<CatalogueData>.multiSelection(
          items: catalogues,
          dropdownDecoratorProps: const DropDownDecoratorProps(
            dropdownSearchDecoration: InputDecoration(
              labelText: SELECT_CATALOGUE,
            ),
          ),
          itemAsString: (CatalogueData catalogue) => catalogue.name,
          onChanged: (value) {
            items.clear();
            if (value.contains(DEFAULT_CATALOGUE_DATA)) {
              for (var element in catalogues) {
                items.addAll(element.item);
              }
            } else {
              for (var element in value) {
                items.addAll(element.item);
              }
            }
            _dropDownKey.currentState!.clear();
          },
        ),
      );
  Widget _dropItemsSelected(List<Item> items) => Padding(
        padding: const EdgeInsets.all(PADDING),
        child: DropdownSearch<Item>(
          //filterFn: (item, filter) => true,
          filterFn: (item, filter) => item.name.contains(filter),
          //asyncItems: (String filter) => filterData(filter),
          key: _dropDownKey,
          items: items,
          itemAsString: (Item item) => item.name,
          popupProps: const PopupPropsMultiSelection.modalBottomSheet(
            showSearchBox: true,
          ),
          dropdownDecoratorProps: const DropDownDecoratorProps(
            dropdownSearchDecoration: InputDecoration(
              labelText: SELECT_ITEM,
            ),
          ),
          onChanged: (value) {
            if (value != null) {
              editingController.text = value.count.toString();
            } else {
              editingController.clear();
            }
          },
        ),
      );

  Future<List<Item>> filterData(String query) async {
    return [];
  }

  Widget _textFieldCount() => Padding(
        padding: const EdgeInsets.all(PADDING),
        child: TextField(
          controller: editingController,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            // hintText: label,
            labelText: COUNT,
          ),
        ),
      );
}
