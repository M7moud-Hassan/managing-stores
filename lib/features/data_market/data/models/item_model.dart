import 'package:mustafa/features/data_market/domain/entities/item.dart';

class ItemModel extends Item {
  ItemModel(
      {required super.id,
      required super.name,
      super.catalogue,
      required super.count,
      required super.cost});

  factory ItemModel.fromJson(Map<String, dynamic> json, catalogue, id) =>
      ItemModel(
          id: id,
          name: json["name"],
          catalogue: catalogue,
          count: json["count"],
          cost: json["cost"]);
  Map<String, dynamic> toJson() => {"name": name, "count": count, "cost": cost};
}
