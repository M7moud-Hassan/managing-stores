import 'package:mustafa/features/catalogue/domain/entities/catalogue.dart';

import '../../../data_market/data/models/item_model.dart';

class CatalogueData extends Catalogue {
  final List<ItemModel> item;
  const CatalogueData({
    required super.name,
    required super.id,
    required this.item,
  });
  @override
  List<Object?> get props => super.props + [item];
}
