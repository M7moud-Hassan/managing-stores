import 'package:dartz/dartz.dart';
import 'package:mustafa/features/data_market/domain/entities/item.dart';
import 'package:mustafa/features/data_market/domain/repositories/item_repo.dart';

import '../../../../core/error/failures.dart';

class ItemDelete {
  final ItemRepo itemRepo;
  ItemDelete({required this.itemRepo});
  Future<Either<Failure, Unit>> call(Item item) => itemRepo.deleteItem(item);
}
