import 'package:mustafa/features/data_market/data/models/item_model.dart';
import 'package:mustafa/features/invoice/domain/entities/catalogue_data.dart';

class ModelCatalogueData extends CatalogueData {
  const ModelCatalogueData(
      {required super.name, required super.id, required super.item});

  factory ModelCatalogueData.create(
          Map<String, dynamic> json, String id, List<ItemModel> items) =>
      ModelCatalogueData(name: json["name"], id: id, item: items);
}
