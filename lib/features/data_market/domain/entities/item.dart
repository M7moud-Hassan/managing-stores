import 'package:equatable/equatable.dart';

class Item extends Equatable {
  String id;
  String name;
  String catalogue;
  int count;
  double cost;
  Item({
    required this.id,
    required this.name,
    this.catalogue = "main",
    required this.count,
    required this.cost,
  });
  @override
  List<Object?> get props => [name, catalogue, count, cost];
}
