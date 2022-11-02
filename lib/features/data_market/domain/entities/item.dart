import 'package:equatable/equatable.dart';

class Item extends Equatable {
  final String id;
  final String name;
  final String catalogue;
  final int count;
  final double cost;
  const Item(
      {required this.id,
      required this.name,
      this.catalogue = "main",
      required this.count,
      required this.cost});
  @override
  List<Object?> get props => [name, catalogue, count, cost];
}
