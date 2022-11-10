import 'package:equatable/equatable.dart';
import 'package:mustafa/features/data_market/domain/entities/item.dart';

class Bill extends Equatable {
  Item item;
  int count;
  double totalCost;
  Bill({required this.item, required this.count, required this.totalCost});

  factory Bill.add(Item item, int count) =>
      Bill(item: item, count: count, totalCost: count * item.cost);
  @override
  List<Object?> get props => [item, count, totalCost];
}
