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
  void reduceCount(int num) {
    count = count - num;
  }

  @override
  List<Object?> get props => [name, catalogue, count, cost, id];
}
