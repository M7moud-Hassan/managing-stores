import 'package:mustafa/features/catalogue/domain/entities/catalogue.dart';

class ModelCatalogue extends Catalogue {
  const ModelCatalogue({required super.name, required super.id});
  factory ModelCatalogue.fromJson(Map<String, dynamic> json, id) =>
      ModelCatalogue(name: json["name"], id: id);

  Map<String, dynamic> toJson() {
    return {"name": name};
  }
}
